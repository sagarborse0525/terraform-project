resource "aws_ecs_task_definition" "service" {
  family                   = "task-def-tf"
  container_definitions    = file("${path.module}/container-definition.json")
  task_role_arn            = "arn:aws:iam::108040610828:role/ecsTaskExecutionRole"
  execution_role_arn       = "arn:aws:iam::108040610828:role/ecsTaskExecutionRole"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  cpu    = 1024
  memory = 2048
}