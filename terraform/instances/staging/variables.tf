variable "aws_region" {
  description = "The AWS region for the environment"
  type        = string
}

variable "environment" {
  description = "The environment for the deployment (staging or production)"
  type        = string
}

variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use"
  type        = string
}

variable "public_subnet_id" {
  description = "The Public Subnet ID"
  type        = string
}

variable "private_subnet_id" {
  description = "The Private Subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "The Security Group ID"
  type        = string
}

variable "key_name" {
  description = "The Key Pair name"
  type        = string
}