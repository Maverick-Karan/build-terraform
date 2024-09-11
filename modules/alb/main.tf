# create application load balancer
resource "aws_lb" "application_load_balancer" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_alb]
  subnets            = [var.public_subnet_az1_id, var.public_subnet_az2_id]
  enable_deletion_protection = false
}

# create API target group
resource "aws_lb_target_group" "api_target_group" {
  name        = "api-tg"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id 

  health_check {
    enabled             = true
    interval            = 60
    path                = "/api/status"
    timeout             = 15
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  lifecycle {
    create_before_destroy = true
  }
}

# create a listener on port 3000 with redirect action for API
resource "aws_lb_listener" "api" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_target_group.arn
    }
}

# create WEB target group
resource "aws_lb_target_group" "web_target_group" {
  name        = "api-web"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id 

  health_check {
    enabled             = true
    interval            = 60
    path                = "/"
    timeout             = 15
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  lifecycle {
    create_before_destroy = true
  }
}

# create a listener on port 5000 with redirect action for WEB
resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 5000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_target_group.arn
    }
}