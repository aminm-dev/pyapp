# Variables for environment and region
variable "environment" {
  description = "The environment for the deployment (staging or production)"
  type        = string
}

variable "aws_region" {
  description = "The AWS region for the environment"
  type        = string
}
