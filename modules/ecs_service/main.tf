# ECS Service Resource - API
resource "aws_ecs_service" "api_service" {
  name            = "api_service"
  cluster         = var.ecs_cluster
  task_definition = var.api_task
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.public_subnet_az1_id]
    security_groups  = var.sg_fargate
    assign_public_ip = true 
  }

  load_balancer {
    target_group_arn = var.tg_api_arn
    container_name   = "api"
    container_port   = 80
  }

  deployment_controller {
    type = "ECS"
  }

  tags = {
    Name = "api_service"
  }

}

# ECS Service Resource - WEB
resource "aws_ecs_service" "web_service" {
  name            = "web_service"
  cluster         = var.ecs_cluster
  task_definition = var.web_task
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.public_subnet_az1_id]
    security_groups  = var.sg_fargate
    assign_public_ip = true 
  }

  load_balancer {
    target_group_arn = var.tg_web_arn
    container_name   = "web"
    container_port   = 80
  }

  deployment_controller {
    type = "ECS"
  }

  tags = {
    Name = "web_service"
  }

}

