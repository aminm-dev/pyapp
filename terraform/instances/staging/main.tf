# Define the AWS provider
provider "aws" {
  region = var.aws_region
}

# Fetch the existing IAM role by name
data "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "AmazonSSMManagedInstanceCoreInstanceProfile"
}

# Create EC2 Instance in the Public Subnet
resource "aws_instance" "app" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id  # Use the public subnet
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name  # Use the existing key name
  iam_instance_profile   = data.aws_iam_instance_profile.ssm_instance_profile.name

  tags = {
    Name        = "${var.environment}_instance"
    Environment = var.environment
    Tier        = "web"
  }
}


