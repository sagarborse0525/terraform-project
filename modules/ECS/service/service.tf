#------------------------------------------------------------------------------
# AWS ECS SERVICE
#------------------------------------------------------------------------------

resource "aws_ecs_service" "mongo" {
  name            = "${var.ecs_service_name}-service"
  cluster         = var.ecs_cluster_arn
  deployment_maximum_percent = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  desired_count = var.desired_count
  enable_execute_command = var.enable_execute_command
  enable_ecs_managed_tags = var.enable_ecs_managed_tags
  health_check_grace_period_seconds = var.health_check_grace_period_seconds
  launch_type = var.launch_type 
  force_new_deployment = force_new_deployment

  
}