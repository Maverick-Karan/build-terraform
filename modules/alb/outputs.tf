output "alb_dns" {
    value = aws_lb.application_load_balancer.dns_name
}

output "tg_api_arn" {
    value = aws_lb_target_group.api_target_group.arn
}

output "alb_listener_arn" {
  value = aws_lb_listener.api.arn
}