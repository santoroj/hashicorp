

# validate terraform code

terraform validate


# format the terraform code
terraform fmt 

# show current state of the resources
terraform show
terraform show -json



terraform  providers

# mirror provides to another directory
terraform providers mirror /tmp/terraform/new_local_file


# print out variables
terraform output


# refresh will modify the statefile but not the resources 
terraform refresh

terraform plan --refresh=false
 

terraform plan

terraform apply


# Generate graph
terraform graph

apt update
apt install graphviz -y
terraform graph | dot -Tsvg > graph.svg






