
### Terraform commands

terraform init
terraform get
terraform fmt
terraform validate
terraform plan
terraform push
terraform output [options] [NAME]
terraform graph
     sudo apt install graphviz
     
terraform apply
terraform refresh
terraform remote
terraform show     # terraform state show 'aws_vpc.main'
terraform state
terraform taint    # terraform taint aws_instance.example
terraform untaint  # terraform untaint aws_instance.example
terraform destroy

# import this already setup ec2 instance to new terraform
terraform import aws_instance.example i-0bda46c8e5c461e6a

## How to find cloud images

### Ubuntu
     https://cloud-images.ubuntu.com/locator/ec2/
     
### CentOS
     https://centos.org/download/aws-images/
     
     
### Command to run     
     terraform apply -var-file=../env/terraform.tfvars
     

## Variable Examples

variable "a-string"{
  type = string
}

variable "this-is-a-number"{
  type = number
}

variable "true-or-false"{
  type = bool
}


List: [0,1,5,2] 

map: {"key" = "value"}

A list is always ordered, it'll always return 0,1,5,2, and not 5,1,20
 
A set is like a list but doesn't keep the order you put it in and can only contain "unique values"
 
A list that has [ 5,1,1,2 ] becomes [1,2,5'] in a set (when you output it terraform will sort it)
 
 
 
 An object is like a map, but each element can have different type
 For Example:
 
 {
   firtname = "John"
   housenumber = 10
 }
   
 A tuple is a list, but each element can have a different type
 
 Example:
 
 [ 0, "string", false]
 
 
### Example using variables in a script
resource "aws_instance" "example" {
  ami = lookup(var.AMIS, var.WAS_REGIOS)
  instance_type = "t2.micro"
  
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
  }

}

### Terraform remote states

#### Consul Example
vim backend.tf

terraform {
  backend "consul" {
    address = "demo.consul.io" # hostname of consul cluster
    path = "terraform/myproject"
}


#### S3 Example
vim backend.tf

terraform {
  backend "s3" {
    bucket = "mybucket" 
    key    = "terraform/myproject"
    region = "eu-west2"
  }
}

### Reading from a read-only remote store

data "terraform_remote_state" "aws-state" {
  backend "s3" 
  config {
    bucket     = "terraform-state" 
    key        = "terraform.tfstate"
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
    region     = var.AWS_REGION 
  }
}

###  Use a module from git

module "module-example"{
   source = "github.com/wardviaene/terraform-module-example"
}

###  Use a module from the local folder 

module "module-example"{
   source = "./module-example"
}


### Passing arguments to a module

module "module-example" {
  source       = "./module-example"
  region       = "eu-west-2"
  ip=range     = "10.0.0.0/8" 
  cluster-size = "3"
}


terraform apply -var RDS_PASSWORD=ThisIsATestPassword










