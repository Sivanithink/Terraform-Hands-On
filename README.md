# Terraform-Hands-On
#  Terraform AWS Web Server Infrastructure(Class)


---

##  Features

Built using **modular Terraform structure** with variables and outputs  
Provisioned a **custom VPC** instead of using default VPC  
Created a **public subnet** with Internet Gateway and proper routing  
Configured a **Security Group** with:
- Port 80 (HTTP) open to all
- Port 22 (SSH) open to all (for demonstration; restrict in production)

Deployed an **EC2 instance** inside the subnet  
Installed and started Apache via **user data script**  
Displayed a custom page: `"Hello World from Terraform!"`  
Used `variables.tf` for easy customization  
Used `outputs.tf` to retrieve the **public IP** of the instance

---

---

##  Setup Instructions

These are the steps I followed to build and verify the infrastructure:

### 1. Prepare Your Working Directory

Create a folder for your project and place the `.tf` files (`main.tf`, `variables.tf`, `outputs.tf`) inside:

```bash
mkdir terraform-aws-webserver
cd terraform-aws-webserver

```

### 2. Initialize Terraform

This downloads the AWS provider and prepares the environment.

```bash
terraform init
```

### 3. Review the Execution Plan

Before applying changes, inspect what Terraform intends to create:

```bash
terraform plan
```

### 4. Apply and Deploy

Run this to actually create the infrastructure on AWS:

```bash
terraform apply
```

When prompted, type `yes` to confirm and provision all resources.

---

##  Access the Web Server

Once the apply is successful, get the public IP using:

```bash
terraform output instance_public_ip
```

Copy the IP, open your browser, and visit:

```
http://43.205.255.52
```

You should see the message:  
**Hello World from Terraform!**

This confirms that your EC2 instance is running, Apache is installed, and the networking is correctly configured.
![Screenshot (102)](https://github.com/user-attachments/assets/1b5b9a65-4942-49a7-8a54-e0c61d86f94c)

![alt text](../Terraform-Hands-On/screenshots/Screenshot%202025-06-12%20233707.png)


---


---

##  Clean Up Resources

To avoid AWS charges, destroy all resources when done:

```bash
terraform destroy
```

This will clean up:
- EC2 instance
- VPC and subnet
- Route tables, internet gateway
- Security group








---


# Assignment 01 – Deploy a Static Website on AWS S3 Using Terraform

This assignment demonstrates how to provision and host a static website on AWS S3 using Terraform. It is part of a DevOps hands-on project aimed at strengthening Infrastructure as Code (IaC) skills using real AWS resources.

- Creates an **S3 bucket** with a globally unique name  
- Configures the bucket for **public access** and **static website hosting**  
- Uploads a local `index.html` file to the bucket  
- Outputs the public website URL after provisioning  

##  How to Deploy

### Step 1: Customize Variables

In `variables.tf`, set your AWS region and specify a unique bucket name:


![Screenshot (105)](https://github.com/user-attachments/assets/435c7bd4-ee0f-4e9d-af3c-5ba468ef4fae)


To override from CLI:  
```bash
terraform apply
```

### Step 2: Initialize Terraform

```bash
terraform init
```

### Step 3: Review the Plan

```bash
terraform plan
```

### Step 4: Apply and Deploy

```bash
terraform apply
```

Approve with `yes` when prompted.

### Step 5: Access the Website

After successful deployment, Terraform will display the public website endpoint:  
Example:
```
website_endpoint = http://nithin-kamisetty-website-7613.s3-website.ap-south-1.amazonaws.com

```
Visit the URL to verify your static site is live.
![Screenshot (104)](https://github.com/user-attachments/assets/90477a56-e1c9-4966-a26d-eb5919a41365)


![Screenshot (107)](https://github.com/user-attachments/assets/af09bad6-a7f6-4081-9f9c-8a8b0c0b17fa)
![Screenshot (106)](https://github.com/user-attachments/assets/757318a5-4f25-441f-8b77-eac130790e13)
## What I Learned

- How to configure an S3 bucket for static site hosting  
- How to upload files via `aws_s3_object` in Terraform  
- How to write modular, readable Terraform code  
- How to output the hosted URL via `outputs.tf`  
- How to structure Terraform code using variables and remote state  


---
# Terraform AWS Assignments – Reusable Module and Two-Tier Architecture



##  Assignment 02 – Reusable EC2 Web Server Module

###  Assignment Is About

In this task, the goal is to convert a normal EC2 instance configuration into a reusable **Terraform module**. That means, instead of hardcoding the EC2 setup every time, we can just use this module and pass values like AMI ID, instance type, etc., to create multiple EC2 instances easily.

###  This Setup Contains

- A **module folder** was created for the EC2 logic. It contains:
  - `main.tf`: where the EC2 resource is defined
  - `variables.tf`: all dynamic values like AMI, subnet, instance type, etc.
  - `outputs.tf`: exposes things like instance ID and public IP
  
- In the **main root folder** (outside the module), the rest of the infrastructure is handled:
  - VPC
  - Subnet
  - Internet gateway
  - Route table
  - Security group
  - And finally, the module is called with required values.


- How **Terraform modules** work and why they are useful
- How to **separate compute and networking** cleanly
- How to design a **secure two-tier network** with public and private subnets
- When to use an **internet gateway vs NAT gateway**
- How to properly write **security group rules**
- Importance of using **variables and outputs** in Terraform
![alt text](../Terraform-Hands-On/screenshots/terraform%202nd%201.png)
![alt text](../Terraform-Hands-On/screenshots/terraform%202nd%202.png)
---



