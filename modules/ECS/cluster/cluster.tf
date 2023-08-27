# AWS ECS Block
resource "aws_ecs_cluster" "main" {
  count = var.is_create_ecs_cluster ? 1 : 0
  name  = var.ecs_cluster_name

  dynamic "setting" {
    for_each = var.ecs_cluster_setting

    content {
      name  = setting.value.name
      value = setting.value.value
    }
  }

  tags = merge(
    {
      "Name" = var.prefix != null && var.created_by != null ? format("%s-%s-%s-%s", var.prefix, var.env, var.ecs_cluster_name, var.created_by) : var.ecs_cluster_name

    },
    var.mandatory_resource_tags,
    var.ecs_cluster_tags,
  )


}


resource "aws_ecs_cluster_capacity_providers" "main" {
  count        = var.is_create_ecs_cluster ? 1 : 0
  cluster_name = aws_ecs_cluster.main[0].name

  capacity_providers = var.ecs_capacity_provider //Use custom (Advanced)

  dynamic "default_capacity_provider_strategy" {
    for_each = var.default_capacity_providers
    iterator = strategy
    content {
      base              = strategy.value.base
      weight            = strategy.value.weight
      capacity_provider = strategy.value.capacity_provider

    }

  }
}