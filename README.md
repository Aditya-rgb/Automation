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

## **2. Validate the Terraform Configuration**

```bash
terraform validate
```
- **What it does:**
  - Validates the syntax and configuration of your Terraform scripts.
  - Checks that there are no errors or issues in the code and that all resources are correctly defined.
  - Does not modify any resources; it only verifies the configuration.

- **When to run:**
  - Run this command after modifying your Terraform scripts or adding new resources.
  - It's a good practice to validate your code before planning or applying changes to ensure everything is correctly set up.


 ## **3. Plan the Infrastructure**

```bash
terraform plan -out=tfplan
```
- **What it does:**
  - Generates an execution plan that outlines the changes Terraform will make to the infrastructure.
  - Shows a preview of resources to be created, updated, or destroyed.
  - Saves the plan to a file (e.g., tfplan) for safe application in the next step.
 

## **4. Apply the Terraform Configuration**

```bash
terraform apply tfplan
```
- **What it does:**
  - Applies the changes specified in the tfplan file to provision or modify resources in your AWS account.
  - Terraform will create, update, or destroy resources as outlined in the plan.
  - The command confirms the changes before proceeding, giving you a final chance to approve or cancel.

- **When to run:**
  - Run this command after reviewing the terraform plan output and confirming that the infrastructure changes are correct.
  - Use this command to actually provision the infrastructure on AWS based on the plan.
 
- **OUTPUT:**
```bash
Terraform will perform the following actions:

# aws_instance.web_server will be created
+ resource "aws_instance" "web_server" {
    ...
}

Plan: 5 to add, 0 to change, 0 to destroy.

Do you want to perform these actions? 
Terraform will perform the actions described above.

Enter a value: yes

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
```


## **5. View the Terraform Outputs**

```bash
terraform output
```
- **What it does:**
  - Displays the values of outputs defined in your Terraform configuration (e.g., public IP of the web server).
  - Useful for retrieving key information about your infrastructure once the apply process is complete.

- **When to run:**
  - Run this command after applying the configuration to see the results (e.g., public IP of your EC2 instance).
  - Helpful to fetch dynamic outputs such as IP addresses, instance IDs, etc.
- **OUTPUT:**
```bash
web_server_public_ip = "18.191.30.78"
```








