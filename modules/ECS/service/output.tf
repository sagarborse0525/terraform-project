output "service_id" {
  description = "The Amazon Resource Name (ARN) that identifies the service."
  value       = var.create ? aws_ecs_service.main[0].id : null
}
output "service_name" {
  description = "The name of the service."
  value       = var.create ? aws_ecs_service.main[0].name : null
}
output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of cluster which the service runs on."
  value       = var.create ? aws_ecs_service.main[0].cluster : null
}