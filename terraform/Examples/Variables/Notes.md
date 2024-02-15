

terraform.tfvars          
*.auto.tfvars
terraform.tfvars.json     
*.auto.tfvars.json


Any of these files are automatically loaded




Variable Definition Precedence


Order of Precedence

  1) Environment Variables
  2) terraform.tfvars
  3) *.auto.tfvars  ( alphabetical order )
  4) -var or -var-file ( command-line flags )


