# Web Server EC2
resource "aws_instance" "web_server" {
  ami           = "ami-0c02fb55956c7d316" # Replace with a valid AMI ID
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnets[0]
  key_name      = var.key_pair_name
  security_groups = [
    aws_security_group.web_server_sg.id
  ]

  tags = {
    Name = "web-server"
  }
}

# Database Server EC2
resource "aws_instance" "db_server" {
  ami           = "ami-0c02fb55956c7d316" # Replace with a valid AMI ID
  instance_type = var.instance_type
  subnet_id     = module.vpc.private_subnets[0]
  key_name      = var.key_pair_name
  security_groups = [
    aws_security_group.db_server_sg.id
  ]

  tags = {
    Name = "db-server"
  }
}

