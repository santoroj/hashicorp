resource "random_pet" "server" {
  length = 2
}



provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = {
      Owner       = "Joes"
      Provisioned = "Terraform"
      Environment = terraform.workspace
    }
  }
}

# Retrieve the list of AZs in the current AWS region
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

# Terraform Data Block - Lookup Ubuntu 20.04
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# Define the VPC 
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = var.vpc_name
    Environment = "pet_environment"
    Terraform   = "true"
  }
}

# Deploy the private subnets
resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]

  tags = {
    Name      = each.key
    Terraform = "true"
    Type      = "Private Subnet"
  }
}

# Deploy the public subnets
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value + 100)
  availability_zone       = tolist(data.aws_availability_zones.available.names)[each.value]
  map_public_ip_on_launch = true

  tags = {
    Name      = each.key
    Terraform = "true"
    Type      = "Public Subnet"
  }
}

# Create route tables for public and private subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
    #nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name      = "pet_public_rtb"
    Terraform = "true"
    Type      = "Pet"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    # gateway_id     = aws_internet_gateway.internet_gateway.id
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name      = "pet_private_rtb"
    Terraform = "true"
    Type      = "Pet"
  }
}

# Create route table associations
resource "aws_route_table_association" "public" {
  depends_on     = [aws_subnet.public_subnets]
  route_table_id = aws_route_table.public_route_table.id
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
}

resource "aws_route_table_association" "private" {
  depends_on     = [aws_subnet.private_subnets]
  route_table_id = aws_route_table.private_route_table.id
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id
}

# Create Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "pet_igw"
    Type = "Pet"
  }
}

# Create EIP for NAT Gateway
resource "aws_eip" "nat_gateway_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.internet_gateway]
  tags = {
    Name = "pet_igw_eip"
    Type = "Pet"
  }
}

# Create NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  depends_on    = [aws_subnet.public_subnets]
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnets["public_subnet_1"].id

  tags = {
    Name = "pet_nat_gateway"
    Type = "Pet"
  }
}



resource "aws_subnet" "variables-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.variables_sub_cidr
  availability_zone       = var.variables_sub_az
  map_public_ip_on_launch = var.variables_sub_auto_ip

  tags = {
    Name      = "sub-variables-${var.variables_sub_az}"
    Terraform = "true"
    Type      = "Pet"
  }
}


module "ubuntu_server" {
  source    = "./modules/server"
  ami       = data.aws_ami.ubuntu.id
  size      = "t2.micro"
  subnet_id = aws_subnet.public_subnets["public_subnet_1"].id
  security_groups = [
    aws_security_group.vpc-ping.id,
    aws_security_group.ingress-ssh.id,
    aws_security_group.vpc-web.id
  ]
}


module "ubuntu_webserver" {
  source   = "./modules/web_server"
  ami      = data.aws_ami.ubuntu.id
  size     = "t2.micro"
  user     = "ubuntu"
  key_name = aws_key_pair.generated.key_name
  # private_key = tls_private_key.generated.private_key_pem
  # private_key = "${file(var.private_key_path)}"
  private_key = file("./${var.private_key_file_name}")

  subnet_id = aws_subnet.public_subnets["public_subnet_2"].id
  security_groups = [
    aws_security_group.vpc-ping.id,
    aws_security_group.ingress-ssh.id,
    aws_security_group.vpc-web.id
  ]
}


module "autoscaling" {
  # source  = "terraform-aws-modules/autoscaling/aws"
  # version = "7.3.1"

  source = "github.com/terraform-aws-modules/terraform-aws-autoscaling?ref=v7.3.1"


  # Autoscaling group
  name = "myasg"

  vpc_zone_identifier = [aws_subnet.private_subnets["private_subnet_1"].id,
  aws_subnet.private_subnets["private_subnet_2"].id]
  # aws_subnet.private_subnets["private_subnet_3"].id]
  min_size         = 1
  max_size         = 3
  desired_capacity = 1

  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "Web EC2 Server 2"
  }

}





module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.0"
}

output "s3_bucket_name" {
  value = module.s3-bucket.s3_bucket_bucket_domain_name
}

# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "5.5.1"


#   name = "my-vpc-terraform"
#   cidr = "10.0.0.0/16"

#   azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#   enable_nat_gateway = true
#   enable_vpn_gateway = true

#   tags = {
#     Name        = "VPC from Module"
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }