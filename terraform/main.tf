# Provider Configuration
provider "aws" {
  region = "us-east-1" # Replace with your preferred AWS region
}

# Module for VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name                 = "terraform-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = ["us-east-1a", "us-east-1b"]
  public_subnets       = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets      = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Terraform   = "true"
    Environment = "Dev"
  }
}

# EC2 Instances
module "ec2_instances" {
  source = "./modules/ec2"
}

