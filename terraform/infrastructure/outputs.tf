# Outputs for VPC ID, Subnet IDs, and Security Group ID
output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID for the environment"
}

output "public_subnet_id" {
  value       = aws_subnet.public_subnet.id
  description = "Public Subnet ID for the environment"
}

output "private_subnet_id" {
  value       = aws_subnet.private_subnet.id
  description = "Private Subnet ID for the environment"
}

output "security_group_id" {
  value       = aws_security_group.web_sg.id
  description = "Security Group ID for the environment"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.main.id
  description = "Internet Gateway ID for the environment"
}

output "public_route_table_id" {
  value       = aws_route_table.public_rt.id
  description = "Public Route Table ID for the environment"
}