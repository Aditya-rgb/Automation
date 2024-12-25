output "web_server_ip" {
  value = aws_instance.web_server.public_ip
  description = "Public IP of the web server instance"
}

output "db_server_private_ip" {
  value = aws_instance.db_server.private_ip
  description = "Private IP of the database server instance"
}

