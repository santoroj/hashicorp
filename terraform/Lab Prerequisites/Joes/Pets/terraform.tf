terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.84.0"
    }
  }
}

terraform {

  # Example: Of Using local files 
  # backend "local" {
  #   path = "mystate/terraform.tfstate"
  # }

  # Exmaple: Using S3 + Dynamodb
  # backend "s3" {
  #   bucket = "joes-2024"
  #   key    = "prod/aws_infra"
  #   region = "eu-west-2"

  #   dynamodb_table = "joes-2024-terraform-locks"
  #   encrypt = true
  # }

    # Example:  Using Terraform Cloud
    # cloud {
    #   organization = "joes-2024"

    #   workspaces {
    #     name = "getting-started"
    #   }
    # }

  # Example:  Using a http server as the backend
  # backend "http" {
  #   address        = "http://localhost:5000/terraform_state/my_state"
  #   lock_address   = "http://localhost:5000/terraform_lock/my_state"
  #   lock_method    = "PUT"
  #   unlock_address = "http://localhost:5000/terraform_lock/my_state"
  #   unlock_method  = "DELETE"
  # }

}
