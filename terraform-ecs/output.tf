output "id" {
  value = aws_vpc.this_vpc_network.id
}
output "aws_ecr_repository_url" {
  value = aws_ecr_repository.this_ecr_image.repository_url
}

output "aws_cluster_name" {
  value = aws_ecs_cluster.this_ecs_cluster.name
}
output "aws_alb_target_group_arn" {
  value = aws_alb_target_group.this_tg.name
}
output "aws_alb_dns" {
  value = aws_lb.this_alb.dns_name
}