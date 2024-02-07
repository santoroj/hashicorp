output "hello-world" {
  description = "Print a Hello World text output"
  value       = "Hello World"
}

output "vpc_id" {
  description = "Output the ID for the primary VPC"
  value       = aws_vpc.vpc.id
}

# output "main_public_ip" {
#   description = "Public IP for our Web Server"
#   value       = aws_instance.web_server.public_ip
# }

# output "main_public2_ip" {
#   description = "Public IP for our Web Server"
#   value       = aws_instance.Ubuntu_web_server.public_ip
# }

# output "main_public_url" {
#   description = "Public URL for our Web Server"
#   value       = "https://${aws_instance.Ubuntu_web_server.public_ip}:8080/index.html"
# }

# output "main_public2_url" {
#   description = "Public URL for our Web Server"
#   value       = "https://${aws_instance.web_server.public_ip}:8080/index.html"
# }

output "main_vpc_information" {
  description = "VPC Information about Environment"
  value       = "Your ${aws_vpc.vpc.tags.Environment} VPC has an ID of ${aws_vpc.vpc.id}"
}


# output "server_public_ip" {
#   value = module.server.public_ip
# }

# output "server_public_dns" {
#   value = module.server.public_dns
# }


# output "modules_public_ip_server_ubuntu_server" {
#   value = module.ubuntu_server.public_ip
# }

# output "modules_public_dns_server_ubuntu_server" {
#   value = module.ubuntu_server.public_dns
# }

output "modules_public_ip_server_ubuntu_server" {
  value = module.ubuntu_webserver.public_ip
}

output "modules_public_dns_server_ubuntu_server" {
  value = module.ubuntu_server.public_dns
}

output "ubuntu_server_size" {
  value = module.ubuntu_server.size
}

output "server_public_ip" {
  value = module.ubuntu_server.server_public_ip
}

output "asg_group_size" {
  value = module.autoscaling.autoscaling_group_max_size
}
