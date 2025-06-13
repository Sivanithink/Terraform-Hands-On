provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}


resource "aws_vpc" "nithin_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "nithin_public_subnet" {
  vpc_id            = aws_vpc.nithin_vpc.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "nithin_igw" {
  vpc_id = aws_vpc.nithin_vpc.id
}

resource "aws_route_table" "nithin_route_table" {
  vpc_id = aws_vpc.nithin_vpc.id
}

resource "aws_route" "nithin_internet_route" {
  route_table_id         = aws_route_table.nithin_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.nithin_igw.id
}

resource "aws_route_table_association" "nithin_route_assoc" {
  subnet_id      = aws_subnet.nithin_public_subnet.id
  route_table_id = aws_route_table.nithin_route_table.id
}

resource "aws_security_group" "nithin_web_sg" {
  name        = "nithin-web-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.nithin_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "my_web_server" {
  source = "./modules/ec2_instance"

  instance_type      = var.instance_type
  ami_id             = var.web_server_ami
  subnet_id          = aws_subnet.nithin_public_subnet.id
  security_group_ids = [aws_security_group.nithin_web_sg.id]
  tags = {
    Name = "nithin-web-server"
  }
}
