
# Configure the AWS provider
provider "aws" {
  region = var.aws_region  # Referencing the variable from variables.tf
}

# Define the EC2 instance resource
resource "aws_instance" "example" {
  ami           = var.ami_id      # Referencing the variable for AMI ID
  instance_type = var.instance_type  # Referencing the variable for instance type

  # Optional: Add a name tag to the instance
  tags = {
    Name = var.instance_name
  }

  # Optional: Enable SSH access by opening port 22 in the security group
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  # Optional: Automatically assign a public IP address
  associate_public_ip_address = true
}

# Define a security group to allow inbound SSH traffic
resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from any IP (can restrict for better security)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}

resource "aws_key_pair" "example" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)  # Path to your local public SSH key
}
