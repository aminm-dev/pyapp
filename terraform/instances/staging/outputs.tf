# Outputs
output "instance_dns" {
  value       = aws_instance.app.public_dns
  description = "The public DNS of the instance"
}

output "instance_id" {
  value       = aws_instance.app.id
  description = "The ID of the instance"
}
