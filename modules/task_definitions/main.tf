resource "aws_ecs_task_definition" "api_task_definition" {
  family                   = "api"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512" # 0.5 vCPU = 512 CPU units
  memory                   = "1024" # 1GB memory
  execution_role_arn       = var.exec_role  
  task_role_arn            = var.exec_role

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

  container_definitions = jsonencode([
    {
      name  = "api"
      image = var.api_image
      cpu   = 0

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]

      essential = true

      environment = [
        {
          name  = "DBUSER"
          value = "postgres"
        },
        {
          name  = "DBHOST"
          value = var.rds_endpoint
        },
        {
          name  = "DB"
          value = "mydatabase"
        },
        {
          name  = "DBPORT"
          value = "5432"
        },
        {
          name  = "DBPASS"
          value = "password123"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/api"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}
