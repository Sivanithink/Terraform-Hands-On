output "instance_id" {
  value       = aws_instance.nithin_web_server.id
  description = "ID of the EC2 instance"
}

output "public_ip" {
  value       = aws_instance.nithin_web_server.public_ip
  description = "Public IP address of the EC2 instance"
}
