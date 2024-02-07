output "hello-world" {
  description = "Print a Hello World text output"
  value       = "Hello World"
}

output "vpc_id" {
  description = "Output the ID for the primary VPC"
  value       = aws_vpc.vpc.id
}

output "public_ip" {
  description = "Public IP for our Web Server"
  value       = aws_instance.web_server.public_ip
}

output "public2_ip" {
  description = "Public IP for our Web Server"
  value       = aws_instance.Ubuntu_web_server.public_ip
}

output "public_url" {
  description = "Public URL for our Web Server"
  value       = "https://${aws_instance.Ubuntu_web_server.public_ip}:8080/index.html"
}

output "public2_url" {
  description = "Public URL for our Web Server"
  value       = "https://${aws_instance.web_server.public_ip}:8080/index.html"
}

output "vpc_information" {
  description = "VPC Information about Environment"
  value       = "Your ${aws_vpc.vpc.tags.Environment} VPC has an ID of ${aws_vpc.vpc.id}"
}
