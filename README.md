rm Infrastructure Setup for AWS**

## **Introduction**
This project uses Terraform to provision AWS infrastructure, including a VPC, subnets, EC2 instances, security groups, and IAM roles. The infrastructure is configured to host a MERN application with separate web and database servers.

## **Features**
- Automated infrastructure provisioning using Terraform.
- Secure VPC setup with public and private subnets.
- EC2 instance creation for web and database servers.
- Security Groups for controlled network access.
- IAM roles for EC2 instances with required permissions.
- Outputs critical resource details (e.g., public IP of the web server).

## **Prerequisites**
1. **AWS Account**: Ensure you have an active AWS account.
2. **Terraform**: Install Terraform on your system. [Download Terraform](https://www.terraform.io/downloads.html)
3. **AWS CLI**: Configure the AWS CLI with your credentials.
   ```bash
   aws configure
4. **SSH Key Pair**: Create an SSH key pair to access EC2 instances.


## **Terraform Execution Flow** 

This guide provides a step-by-step explanation of how to execute Terraform commands to provision and manage infrastructure.

---

## **1. Initialize the Terraform Project**

```bash
terraform init
```
- **What it does:**
  - Downloads required provider plugins (e.g., AWS) and initializes the Terraform project.

- **When to run:**
  - Execute this command once after creating your scripts or whenever you add/modify modules or providers.


