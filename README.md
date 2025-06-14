# Terraform-Hands-On
#  Terraform AWS Web Server Infrastructure(Class)

This project demonstrates how to provision a **fully functional web server on AWS** using **Terraform Infrastructure as Code (IaC)** principles. It includes the creation of a custom Virtual Private Cloud (VPC), complete networking setup, and launching an EC2 instance with a pre-installed Apache web server.


---

##  Features

✅ Built using **modular Terraform structure** with variables and outputs  
✅ Provisioned a **custom VPC** instead of using default VPC  
✅ Created a **public subnet** with Internet Gateway and proper routing  
✅ Configured a **Security Group** with:
- Port 80 (HTTP) open to all
- Port 22 (SSH) open to all (for demonstration; restrict in production)

✅ Deployed an **EC2 instance** inside the subnet  
✅ Installed and started Apache via **user data script**  
✅ Displayed a custom page: `"Hello World from Terraform!"`  
✅ Used `variables.tf` for easy customization  
✅ Used `outputs.tf` to retrieve the **public IP** of the instance

---

## Project Structure

<pre>
terraform-getting-started/
├── main.tf         # Main Terraform configuration (VPC, Subnet, EC2, Security Group)
├── variables.tf    # All configurable inputs for flexibility
├── outputs.tf      # Output values like the public IP
├── provider.tf     # AWS provider configuration
</pre>


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

![Screenshot (101)](https://github.com/user-attachments/assets/69c1c168-1e07-42d0-b00a-91c7e36d74f8)

In the screenshot above, the web server returns a **"401 - Unauthorized"** message. This happened because the user data script tried to access the EC2 instance metadata (like instance ID) **without using the required authentication token**.

AWS now uses **IMDSv2 (Instance Metadata Service v2)**, which requires a session token to access metadata. Since the script used the older method (IMDSv1), the request was denied with a 401 Unauthorized response.

📌 **Note:** This is expected behavior when trying to access EC2 metadata without a token.  The EC2 instance, VPC, subnet, security group, and web server were successfully provisioned.


---

##  Configuration Options (variables.tf)

You can easily tweak your setup using variables. For example:

```hcl
variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "instance_type" {
  default = "t2.micro"
}
```

Change the instance type or region without modifying `main.tf`.

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

Also remember to manually delete:
- Any S3 bucket or DynamoDB table if used for remote backend

---

##  What I Learned 

- Real-world VPC networking: subnetting, routing, public IPs
- Writing clean, reusable, and modular Terraform code
- Automating provisioning of compute and network resources
- Using user data for EC2 initialization (Apache setup)
- Following DevOps best practices for infra as code
- Clear separation of logic: inputs, logic, outputs

---





---


# Assignment 01 – Deploy a Static Website on AWS S3 Using Terraform

This assignment demonstrates how to provision and host a static website on AWS S3 using Terraform. It is part of a DevOps hands-on project aimed at strengthening Infrastructure as Code (IaC) skills using real AWS resources.

## 📁 Folder Structure

assignment-01-s3-static-website/  
├── main.tf  
├── variables.tf  
├── outputs.tf  
├── index.html  
├── .terraform/                 # Ignored in Git  
├── .terraform.lock.hcl  
├── terraform.tfstate*         # Ignored in Git  
├── terraform.tfstate.backup*  # Ignored in Git  

## 🌐 What This Project Does

- Creates an **S3 bucket** with a globally unique name  
- Configures the bucket for **public access** and **static website hosting**  
- Uploads a local `index.html` file to the bucket  
- Outputs the public website URL after provisioning  

## 🛠 Technologies Used

- **Terraform** – for infrastructure provisioning  
- **AWS S3** – for static website hosting  
- **HTML** – to render basic content  

## 🚀 How to Deploy

### Step 1: Customize Variables

In `variables.tf`, set your AWS region and specify a unique bucket name:

```hcl
variable "aws_region" {
  default = "ap-south-1" # or your desired region
  type = string
}

variable "bucket_name" {
  default = "nithin-kamisetty-website-7613"
  type       = string

}

variable "aws_profile" {
   default = "AdminAccess-644608486460"
   type = string
}

```
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

## 📄 Sample HTML File (index.html)

```html
<!DOCTYPE html>
<html>
<head>
  <title>My First Terraform Website</title>
</head>
<body>
  <h1>This website was deployed using Terraform!</h1>
  <p>Assignment 1 is a success.</p>
</body>
</html>


```
![Screenshot (107)](https://github.com/user-attachments/assets/af09bad6-a7f6-4081-9f9c-8a8b0c0b17fa)
![Screenshot (106)](https://github.com/user-attachments/assets/757318a5-4f25-441f-8b77-eac130790e13)
## ✅ What I Learned

- How to configure an S3 bucket for static site hosting  
- How to upload files via `aws_s3_object` in Terraform  
- How to write modular, readable Terraform code  
- How to output the hosted URL via `outputs.tf`  
- How to structure Terraform code using variables and remote state  

## 🧹 .gitignore (Root)

```gitignore
# Ignore Terraform state files
*.tfstate
*.tfstate.backup

# Ignore Terraform lock file (optional, include if you want reproducible providers)
.terraform.lock.hcl

# Ignore the .terraform directory (provider binaries/modules)
.terraform/

# Ignore any temporary override config
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Ignore sensitive variable files
*.auto.tfvars
*.tfvars

# Ignore credentials or secrets (if any)
*.pem
*.key
.env

```
---
# Terraform AWS Assignments – Reusable Module and Two-Tier Architecture



##  Assignment 02 – Reusable EC2 Web Server Module

###  What This Assignment Is About

In this task, the goal is to convert a normal EC2 instance configuration into a reusable **Terraform module**. That means, instead of hardcoding the EC2 setup every time, we can just use this module and pass values like AMI ID, instance type, etc., to create multiple EC2 instances easily.

### What This Setup Contains

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

###  Why This Matters

- This kind of setup makes the code **reusable** and **clean**.
- You don’t need to repeat EC2 logic everywhere — just call the module.
- Changes can be made in one place, and used across multiple environments.

---

##  Assignment 03 – Two-Tier Architecture (Web + DB)

###  What This Assignment Is About

Here, the goal is to build a more **realistic and secure** infrastructure setup — something that you’d actually use in production. It’s a **two-tier architecture** where the frontend (web server) is in a public subnet, and the backend (database) is in a private subnet.

###  What This Setup Contains

- **VPC** with two subnets:
  - Public subnet → for EC2 web server
  - Private subnet → for RDS database

- **Internet gateway** for public subnet (so EC2 can be accessed from the internet)

- **NAT gateway** in public subnet → used so that private resources (like RDS) can reach the internet **only for updates**, but cannot be accessed from outside

- **Route tables**:
  - Public subnet routes through internet gateway
  - Private subnet routes through NAT gateway

- **Security groups**:
  - Web server SG → allows SSH (22) and HTTP (80) from internet
  - DB SG → allows traffic only from EC2’s SG, and only on MySQL port (3306)

- **EC2 instance** in public subnet
- **RDS MySQL database** in private subnet
- **Sensitive variables** used for storing DB credentials securely

###  How Security Is Handled

- Only the EC2 instance can talk to the database.
- Database is not exposed to the public at all.
- This follows the best practice of **least privilege** access.

---

##  What This Helped Me Understand


- How **Terraform modules** work and why they are useful
- How to **separate compute and networking** cleanly
- How to design a **secure two-tier network** with public and private subnets
- When to use an **internet gateway vs NAT gateway**
- How to properly write **security group rules**
- Importance of using **variables and outputs** in Terraform

---

##  Final Summary

- Write reusable Terraform code using modules
- Design real-world cloud architectures
- Handle networking, security, and routing properly
- Structure Terraform code in a clean and manageable way

