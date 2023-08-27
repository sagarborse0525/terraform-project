#------------------------------------------------------------------------------
# AWS ECS SERVICE
#------------------------------------------------------------------------------

resource "aws_ecs_service" "main" {
  count                              = var.create ? 1 : 0
  name                               = "${var.ecs_service_name}-service"
  cluster                            = var.ecs_cluster_arn
  task_definition                    = var.task_definition_arn
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  desired_count                      = var.desired_count
  enable_execute_command             = var.enable_execute_command
  enable_ecs_managed_tags            = var.enable_ecs_managed_tags
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  launch_type                        = var.launch_type
  force_new_deployment               = var.force_new_deployment
  platform_version                   = var.launch_type == "FARGATE" ? var.platform_version : null
  scheduling_strategy                = var.launch_type == "FARGATE" ? "REPLICA" : var.scheduling_strategy
  propagate_tags                     = var.propagate_tags

  dynamic "capacity_provider_strategy" {
    for_each = var.capacity_provider_strategies
    content {
      base              = lookup(capacity_provider_strategy.value, "base", null) //Optional
      weight            = capacity_provider_strategy.value.weight                //Required
      capacity_provider = capacity_provider_strategy.value.capacity_provider

    }

  }

  dynamic "service_registries" {
    for_each = var.service_registries
    content {
      registry_arn   = service_registries.value.registry_arn
      port           = lookup(service_registries.value, "port", null)
      container_port = lookup(service_registries.value, "container_port", null)
      container_name = lookup(service_registries.value, "container_name", null)
    }
  }

  dynamic "ordered_placement_strategy" {
    for_each = var.ordered_placement_strategy
    content {
      type  = ordered_placement_strategy.value.type
      field = lookup(ordered_placement_strategy.value, "field", null)
    }

  }

  dynamic "placement_constraints" {
    for_each = var.placement_constraints
    content {
      type       = placement_constraints.value.type
      expression = lookup(placement_constraints.value, "placement_constraints", null)
    }
  }

  dynamic "load_balancer" {
    for_each = var.load_balancer
    content {
      elb_name         = load_balancer.value.elb_name
      target_group_arn = load_balancer.value.target_group_arn
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
    }
  }

  dynamic "deployment_controller" {
    for_each = var.deployment_controller
    content {
      type = lookup(deployment_controller.value, "type", null)
    }
  }

  network_configuration {
    subnets          = var.assign_public_ip ? var.public_subnets : var.private_subnets
    security_groups  = var.security_group_ids
    assign_public_ip = var.assign_public_ip
  }







}