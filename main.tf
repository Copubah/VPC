provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "MyWebServerVPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "MyWebServerIGW"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                   = aws_vpc.my_vpc.id
  cidr_block               = "10.0.1.0/24"
  availability_zone        = "us-east-1a"
  map_public_ip_on_launch  = true
  tags = {
    Name = "PublicSubnet"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

resource "aws_route_table_association" "public_route_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Security Group
resource "aws_security_group" "web_sg" {
  name        = "WebServerSG"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your IP for better security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebServerSG"
  }
}

# EC2 Instance
resource "aws_instance" "web_server" {
  ami                    = "ami-0a91cd140a1fc148a" # Amazon Linux 2023 (Free Tier Eligible)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  security_groups        = [aws_security_group.web_sg.name]
  key_name               = var.key_pair_name

  user_data = <<EOF
#!/bin/bash
yum update -y
yum install httpd -y
echo "<h1>Welcome to My Web Server!</h1>" > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd
EOF

  tags = {
    Name = "MyWebServerInstance"
  }
}
