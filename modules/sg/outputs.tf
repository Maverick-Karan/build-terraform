output "fargate_sg_id" {
  value = aws_security_group.fargate_security_group.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_security_group.id
}

output "rds_sg_id" {
  value = aws_security_group.database_security_group.id
}