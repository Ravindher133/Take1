provider "aws" {
  region = "eu-west-1"  # Change as needed
}

# Security group allowing inbound SSH (port 22) and HTTP (port 80)
resource "aws_security_group" "web_sg3" {
  name        = "web_sg3"
  description = "Allow SSH and HTTP inbound traffic"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (restrict for production)
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

# Launch EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-06297e16b71156b52"  # Example: Ubuntu Server 20.04 LTS in us-east-1
  instance_type = "t3.micro"
  key_name      = "Ravi"  # Replace with your AWS key pair name
  security_groups = [aws_security_group.web_sg3.name]

  tags = {
    Name = "TerraformWebInstance" 
  }
}