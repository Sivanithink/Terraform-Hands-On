variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "web_server_ami" {
  default = "ami-0c55b159cbfafe1f0" # Replace with latest Amazon Linux 2 AMI for your region
}
