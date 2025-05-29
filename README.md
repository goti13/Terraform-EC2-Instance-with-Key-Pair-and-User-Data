# Terraform-EC2-Instance-with-Key-Pair-and-User-Data

# Terraform-EC2-Instance-with-Key-Pair-and-User-Data

This mini project demostartes the use Terraform to automate the launch of an EC2 instance on AWS. The project includes the generation of a downloadable key pair for the instance and the execution of a user data script to install and configure Apache HTTP server.

Objectives:

1. Terraform Configuration:

- Learn how to write Terraform code to launch an EC2 instance with specified configurations.

2. Key Pair Generation:

- Generate a key pair and make it downloadable after EC2 instance creation.

3. User Data Execution:

- Use Terraform to execute a user data script on the EC2 instance during launch.

Project Tasks:

Task 1: Terraform Configuration for EC2 Instance

1. Create a new directory for your Terraform project (e.g., ' terraform-ec2-keypair').

2. Inside the project directory, create a Terraform configuration file (e.g., 'main. tf*).

3. Write Terraform code to create an EC2 instance with the following specifications:

- Instance type: 't2 micro'

- Key pair: Generate a new key pair and make it downloadable.

- Security group: Allow incoming traffic on port 80.

1. Initialize the Terraform project using the command: 'terraform init'.

2. Apply the Terraform configuration to create the EC2 instance using the command: 'terraform apply.

```
#main.tf file

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
  



  tags = {
    Name = var.instance_name
  }
}


```


```

#variable.tf file

variable "key_name" {
  description = "The name of the existing EC2 Key Pair"
  default     = "deployer-key" # Replace this with your real key pair name
}

variable "instance_name" {
  description = "Value of the name tag for the instance"
  type = string
  default = "Terraform_server"

}

variable "instance_type" {
  description = "AWS ec2 instance type"
  type = string
  default = "t2.micro"
}


```

![image](https://github.com/user-attachments/assets/bf1f3856-4e66-41a9-b123-476e7a4b1417)

![image](https://github.com/user-attachments/assets/9ee2fd76-f81f-4cbb-b47f-faac8a6f3da3)

![image](https://github.com/user-attachments/assets/718d751c-74a9-443e-830f-8690ab9b4eaf)

![image](https://github.com/user-attachments/assets/578dc1df-4c08-411d-8538-18b9762f15e0)

![image](https://github.com/user-attachments/assets/cb0dc6c0-a131-4b89-a854-1bf126f3672b)

![image](https://github.com/user-attachments/assets/5f02bc0b-8e54-4aee-9478-74c0d988ab0f)

![image](https://github.com/user-attachments/assets/cbbce70a-3f93-44bb-82ad-e85e5cc062d3)


![image](https://github.com/user-attachments/assets/f3c71be1-341d-48d5-a035-23c924847456)

![image](https://github.com/user-attachments/assets/0d41507f-0469-4063-8d1f-e51c4f297683)

<img width="1326" alt="image" src="https://github.com/user-attachments/assets/6a58a20b-c754-4dd2-88bb-eac8b6084b6d" />

<img width="1331" alt="image" src="https://github.com/user-attachments/assets/5138bf31-30fa-4a78-bbdb-2b8e70bdba89" />


<img width="1329" alt="image" src="https://github.com/user-attachments/assets/a77762ca-a82b-4969-8d72-d2e8edeb5015" />


<img width="808" alt="image" src="https://github.com/user-attachments/assets/a1c57402-5085-4a0b-bd78-3416d788c558" />

Task 2: User Data Script Execution

1. ﻿﻿﻿Extend your Terraform configuration to include the execution of the provided user data script.
   
2. ﻿﻿﻿Modify the user data script to install and configure Apache HTTP server.
   
3. ﻿﻿﻿Apply the updated Terraform configuration to launch the EC2 instance with the user data script using the command: 'terraform apply'.

```

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


```

![image](https://github.com/user-attachments/assets/f88c0553-8f9d-498d-bf7a-906edb501b51)

![image](https://github.com/user-attachments/assets/aea8e868-ee92-404b-93b9-e93296edb9a6)

![image](https://github.com/user-attachments/assets/dbf2b52b-a131-4570-91f3-c5a25515899c)

![image](https://github.com/user-attachments/assets/d3dd8e6d-1ae2-499e-909c-f2282f114e4e)

![image](https://github.com/user-attachments/assets/e8d258d3-8360-49d9-91cf-b73781f2c28e)

<img width="1333" alt="image" src="https://github.com/user-attachments/assets/1cc55b8b-0850-4791-bb25-7987e441b3cb" />

   
Task 3: Accessing the Web Server
1. ﻿﻿﻿After the EC2 instance is created and running, access the Apache web server by using its public IP address.
2. ﻿﻿﻿Verify that the web server displays the "Hello World" message generated by the user data script.


<img width="1333" alt="image" src="https://github.com/user-attachments/assets/2d41dc1d-cf2b-42ce-835d-77a147bca364" />


![image](https://github.com/user-attachments/assets/c9496f29-bf43-493b-ae8b-35e733d6b974)
















