# Provider block
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# Creating key-pair on AWS using SSH-public key
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file("/Users/geraldoti/Documents/repos/darey/my-key.pub")

}

# Security group block
resource "aws_security_group" "application_sg" {
  name = "MY-SECURITY-GROUP"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "listenport"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
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

# EC2 instance
resource "aws_instance" "app_server" {
  ami                         = "ami-0953476d60561c955"
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.application_sg.id]
  key_name        = aws_key_pair.deployer.key_name
  associate_public_ip_address = true
  
user_data       = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx

              # get admin privileges
              sudo su

              # install httpd (Linux 2 version)
                yum update -y
                yum install -y httpd.x86_64
              #  Start the httpd service
                systemctl start httpd.service

              # Enable the httpd service

                systemctl enable httpd.service

              # Create index.html with H1 tag in the default apache web directory
                echo "Hello World from $(hostname -f)" > /var/www/html/index.html

    
              # Restart Apache to apply changes
                sudo systemctl restart apache2

              EOF


  tags = {
    Name = var.instance_name
  }
}

