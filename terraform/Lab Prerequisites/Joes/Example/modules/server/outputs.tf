output "public_ip" {
  value = aws_instance.ubuntu.public_ip
}

output "public_dns" {
  value = aws_instance.ubuntu.public_dns
}

output "size" {
  description = "Size of server built with Server Module"
  value       = aws_instance.ubuntu.instance_type
}

output "server_public_ip" {
  description = "Public IP for our Web Server"
  value       = aws_instance.ubuntu.public_ip
}

