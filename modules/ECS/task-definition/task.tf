resource "aws_ecs_task_definition" "service" {
  count                    = var.create ? 1 : 0
  family                   = var.prefix != "" && var.created_by != "" ? format("%s-%s-%s-%s", var.prefix, var.env, var.task_definition_name, var.created_by) : "demo-DF"
  container_definitions    = jsonencode("${var.container_definition}")
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role_arn
  network_mode             = var.network_mode
  cpu                      = var.task_cpu_units
  memory                   = var.task_memory_size
  requires_compatibilities = var.task_definition_launch_type_compatibilities

  runtime_platform {
    operating_system_family = var.runtime_platform_operating_system_family
    cpu_architecture        = var.runtime_platform_cpu_architecture
  }

  tags = merge(
    {
      "Name" = var.prefix != "" && var.created_by != "" ? format("%s-%s-%s-%s", var.prefix, var.env, var.task_definition_name, var.created_by) : "demo-DF"
    },
    var.mandatory_resource_tags,
    var.task_definition_tags
  )

  dynamic "proxy_configuration" {
    for_each = var.proxy_configuration
    content {
      container_name = proxy_configuration.value.container_name
      properties     = lookup(proxy_configuration.value, "properties", null)
      type           = lookup(proxy_configuration.value, "type", null)
    }
  }

  dynamic "placement_constraints" {
    for_each = var.placement_constraints
    content {
      expression = lookup(placement_constraints.value, "expression", null)
      type       = placement_constraints.value.type
    }

  }

  dynamic "volume" {
    for_each = var.volume
    content {
      name      = volume.value.name
      host_path = lookup(volume.value, "host_path", null)

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          scope         = lookup(docker_volume_configuration.value, "scope", null)
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
        }

      }
    }
  }

  lifecycle {
    prevent_destroy = false //To avoid destroy operations for specific resources to set true.
  }
}