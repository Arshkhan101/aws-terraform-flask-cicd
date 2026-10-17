terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.69.1"
    }
  }
}
provider "aws" {
  region = "eu-north-1" # Aap apni pasand ki region bhi rakh sakte hain (jaise ap-south-1 Mumbai)
}

# 1. Default VPC ka reference lena taaki extra charge ya complex setup na ho
data "aws_vpc" "default" {
  default = true
}

# 2. Security Group banana (SSH aur HTTP allow karne ke liye)
resource "aws_security_group" "flask_sg" {
  name   = "flask-ec2-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
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

  tags = {
    Name = "Flask-SG"
  }
}

# 3. Free-tier eligible Ubuntu t2.micro EC2 Instance provision karna
resource "aws_instance" "web_server" {
  ami           = "ami-xxxxxxxx" # Ubuntu 
  instance_type = "t3.micro"
  key_name      = "your-key-name" # Yahan apne AWS Key Pair ka naam dalna

  vpc_security_group_ids = [aws_security_group.flask_sg.id]

  tags = {
    Name = "AWS-Flask-CI-CD-Server"
  }
}

# 4. Output mein EC2 ka Public IP print karna
output "ec2_public_ip" {
  value       = aws_instance.web_server.public_ip
  description = "Public IP address of the EC2 instance"
}