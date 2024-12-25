
## **Introduction**
This project uses Terraform to provision AWS infrastructure, including a VPC, subnets, EC2 instances, security groups, and IAM roles. The infrastructure is configured to host a MERN application with separate web and database servers.

# **Part 1: Configuration and Deployment with Terraform**

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


## Project Structure
```bash
├── main.tf                # Main Terraform configuration
├── variables.tf           # Variable definitions
├── outputs.tf             # Resource outputs
├── modules/
│   ├── vpc/               # VPC and network configurations
│   ├── ec2/               # EC2 instance setup
│   ├── security_groups/   # Security group definitions
│   ├── iam/               # IAM roles and policies

```

## Terraform Scripts Flow

### 1. AWS Setup and Terraform Initialization

**Scripts Involved:**
- `main.tf`: Configures the AWS provider.
- `variables.tf`: Defines variables like AWS region and credentials.

**Actions:**
- Manually configure AWS CLI for authentication (outside Terraform).
- Run `terraform init` to initialize the project with the AWS provider.

---

### 2. VPC and Network Configuration

**Scripts Involved:**
- `modules/vpc/main.tf`: Defines the VPC, subnets, Internet Gateway, NAT Gateway, and route tables.
- `modules/vpc/outputs.tf`: Exports subnet IDs and VPC ID for use in other modules.

**Actions:**
- Creates:
  - VPC with one public and one private subnet.
  - Internet Gateway for external access to the public subnet.
  - NAT Gateway for private subnet internet access.
  - Route Tables to link subnets and gateways.

---

### 3. EC2 Instance Provisioning

**Scripts Involved:**
- `modules/ec2/main.tf`: Launches EC2 instances using AMIs, instance types, and subnet details.
- `modules/vpc/outputs.tf`: Supplies subnet IDs for instance placement.

**Actions:**
- Launches:
  - One EC2 instance in the public subnet (web server).
  - One EC2 instance in the private subnet (database server).
- Configures SSH key pairs and ensures access control:
  - Public instance accessible only from your IP.
  - Private instance accessible only from the public instance (bastion host setup).

---

### 4. Security Groups and IAM Roles

**Scripts Involved:**
- `modules/security_groups/main.tf`: Configures security groups for the web server and database.
- `modules/iam/main.tf`: Creates IAM roles for EC2 with permissions for AWS services.

**Actions:**
- **Security Groups:**
  - Web server: Allows HTTP, HTTPS, and SSH (from your IP only).
  - Database server: Allows connections only from the web server.
- **IAM Roles:**
  - Assign roles with required permissions for EC2 instances.

---

### 5. Resource Output

**Scripts Involved:**
- `outputs.tf`: Outputs the public IP of the web server and other key details.

**Actions:**
- Displays the public IP of the web server EC2 instance.
- Outputs other resources (e.g., VPC ID, subnet IDs) as needed.

---

## Execution Flow

These steps are strictly followed when:
- You run `terraform apply`.
- The modules and configurations in the scripts align with the required sequence.

# **Part 2: Configuration and Deployment with Ansible**

This section covers the setup and configuration of the web and database servers using Ansible for the deployment of a MERN application.

---

### **1. Ansible Configuration**

- **What it does:**
  - Configure Ansible to communicate with the AWS EC2 instances that were provisioned using Terraform.
  - You need to have the public IP of the EC2 instances (retrieved from the Terraform output) and ensure that your SSH key pair is correctly configured for secure access.

- **Steps:**
  1. Set up the `inventory` file to include the public IP of the EC2 instance.
  2. Configure your SSH key for secure communication with the EC2 instances.

- **Example `inventory` file:**

  ```ini
  [web_servers]
  18.191.30.78 ansible_ssh_private_key_file=~/.ssh/your_key.pem

  [database_servers]
  18.191.30.79 ansible_ssh_private_key_file=~/.ssh/your_key.pem
  ```
### **2. Web Server Setup**

### What it does:
- Writes an Ansible playbook to install Node.js and NPM on the web server.
- Clones the MERN application repository and installs all necessary dependencies.

### Steps:
1. Install Node.js and NPM.
2. Clone the MERN repository and install dependencies.

### Ansible playbook web_server_setup.yml :
```bash

- hosts: web_servers
  become: yes
  tasks:
    - name: Install Node.js
      apt:
        name: nodejs
        state: present

    - name: Install npm
      apt:
        name: npm
        state: present

    - name: Clone MERN application repository
      git:
        repo: 'git@github.com:UnpredictablePrashant/TravelMemory.git'
        dest: /home/ubuntu/mern-app

    - name: Install dependencies
      command: npm install
      args:
        chdir: /home/ubuntu/mern-app
```

### Command to run the playbook:
```bash
ansible-playbook -i inventory web_server_setup.yml
```


## 3. Database Server Setup

### What it does:
- Installs and configures MongoDB on the database server.
- Secures the MongoDB instance and creates necessary users and databases.

### Steps:
1. Install MongoDB.
2. Configure MongoDB with necessary settings.
3. Create a user and database for the MERN application.

### Ansible playbook (database_server_setup.yml): :
```bash
---
- hosts: database_servers
  become: yes
  tasks:
    - name: Install MongoDB
      apt:
        name: mongodb
        state: present

    - name: Start MongoDB service
      service:
        name: mongodb
        state: started
        enabled: yes

    - name: Create MongoDB database and user
      command: mongo admin --eval "db.createUser({user: 'mernuser', pwd: 'securepassword', roles: [{role: 'readWrite', db: 'mern'}]})"

```

### Command to run the playbook:
```bash
ansible-playbook -i inventory database_server_setup.yml
```

### **4. Application Deployment**

- **What it does:**
  - Configures environment variables and starts the backend Node.js application on the private subnet EC2 instance.
  - Deploys the frontend on the public subnet EC2 instance by navigating to the frontend folder and running the appropriate commands.

- **Steps:**
  1. Set environment variables and start the backend Node.js application in the private subnet.
  2. On the public subnet EC2 instance, navigate to the frontend folder, install the dependencies, and start the React application.

- **Ansible playbook (`app_deployment.yml`):**

  ```yaml
  ---
  - hosts: database_servers
    become: yes
    tasks:
      - name: Set environment variables for backend
        lineinfile:
          path: /home/ubuntu/mern-app/backend/.env
          line: "DB_URL=mongodb://your_mongo_db_host:27017/mern"

      - name: Start the backend Node.js application
        command: npm install && node index.js
        args:
          chdir: /home/ubuntu/mern-app/backend

  - hosts: web_servers
    become: yes
    tasks:
      - name: Navigate to frontend folder and install dependencies
        command: npm install
        args:
          chdir: /home/ubuntu/mern-app/frontend

      - name: Start the frontend React application
        command: npm start
        args:
          chdir: /home/ubuntu/mern-app/frontend

  ```
