output "api_task_definition_arn" {
  value = aws_ecs_task_definition.api_task_definition.arn
}

output "web_task_definition_arn" {
  value = aws_ecs_task_definition.web_task_definition.arn
}