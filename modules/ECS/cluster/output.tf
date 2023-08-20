output "cluster_arn" {
  value = var.is_create_ecs_cluster ? aws_ecs_cluster.main[0].arn : null
}

output "cluster_name" {
  value = var.is_create_ecs_cluster ? aws_ecs_cluster.main[0].name : null
}