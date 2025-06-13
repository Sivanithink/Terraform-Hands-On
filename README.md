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
![Screenshot (102)](https://github.com/user-attachments/assets/031ef173-3228-4c86-bc9c-44bf2864f6bc)

![Screenshot (101)](https://github.com/user-attachments/assets/00fd54bb-3b4a-4f53-81d4-52d59decd99b)
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

