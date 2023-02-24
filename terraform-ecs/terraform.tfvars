vpc_network_name = "virtual_network"

cidr = "10.0.0.0/16"

gateway_name = "t_gateway"

nat_gateway_name = "n_gateway"

public_subnets = ["10.0.16.0/20", "10.0.48.0/20", "10.0.80.0/20"]

private_subnets = ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]


availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]

ecr_image_name = "acx-web-app"

cluster_name = "acxd_cluster"


container_cpu = "256"

container_memory = "1024"

container_name = "web-acxd"

container_port = 80

region = "eu-central-1"


ecs_service_name = "web-ecs-application"

task_definition_name = "web-app-definations"




service_desired_count = 1


ecs_service_security_groups = ["sg-054469c7da96be5a6"]

alb_security_groups = ["sg-054469c7da96be5a6"]

health_check_path = "/"

aws_alb_target_group_arn = "web-tg"

domain_name = "acxd.io"