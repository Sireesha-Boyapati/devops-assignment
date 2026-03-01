provider "aws" {
  region = "eu-west-1"
}

# Security Group
resource "aws_security_group" "web_sg_new" {
  name = "web_sg_new"

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "web" { # Corrected resource type to aws_instance
  ami           = "ami-047bb4163c506cd98"
  instance_type = "t3.micro"
  # Corrected to reference the new security group name
  security_groups = [aws_security_group.web_sg_new.name] 
  key_name      = "devops-key"

  tags = {
    Name = "DevOps-Server"
  }
}
