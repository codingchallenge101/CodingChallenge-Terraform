#Configure VPC
resource "aws_vpc" "this_vpc_network" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_network_name
  }
}

#Configure INTERNET GATEWAY
resource "aws_internet_gateway" "this_ig" {
  vpc_id = aws_vpc.this_vpc_network.id

  tags = {
    Name = var.gateway_name
  }
}

#Configure NAT GATEWAY
resource "aws_nat_gateway" "this_nat_gateway_network" {
  count         = length(var.private_subnets)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.this_public_subnet.*.id, count.index)
  depends_on    = [aws_internet_gateway.this_ig]

  tags = {
    Name = "${var.nat_gateway_name}-${format("%03d", count.index + 1)}"
  }
}


resource "aws_eip" "nat" {
  count = length(var.private_subnets)
  vpc   = true

  tags = {
    Name = "${var.vpc_network_name}-eip-${format("%03d", count.index + 1)}"
  }
}

#Configure Private Subnets
resource "aws_subnet" "this_private_subnet" {
  vpc_id            = aws_vpc.this_vpc_network.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  count             = length(var.private_subnets)

  tags = {
    Name = "${var.vpc_network_name}-private-subnet-${format("%03d", count.index + 1)}"
  }
}
#Configure Public Subnets
resource "aws_subnet" "this_public_subnet" {
  vpc_id                  = aws_vpc.this_vpc_network.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  count                   = length(var.public_subnets)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_network_name}-public-subnet-${format("%03d", count.index + 1)}"
  }
}


resource "aws_route_table" "this_route_table_public" {
  vpc_id = aws_vpc.this_vpc_network.id

  tags = {
    Name = "${var.vpc_network_name}-routing-table-public"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.this_route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this_ig.id
}


resource "aws_route_table" "this_route_table_private" {
  count  = length(var.private_subnets)
  vpc_id = aws_vpc.this_vpc_network.id

  tags = {
    Name = "${var.vpc_network_name}-routing-table-private-${format("%03d", count.index + 1)}"
  }
}


resource "aws_route" "private" {
  count                  = length(compact(var.private_subnets))
  route_table_id         = element(aws_route_table.this_route_table_private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this_nat_gateway_network.*.id, count.index)
}


resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.this_private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.this_route_table_private.*.id, count.index)
}


resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.this_public_subnet.*.id, count.index)
  route_table_id = aws_route_table.this_route_table_public.id
}

resource "aws_flow_log" "logs" {
  iam_role_arn    = aws_iam_role.vpc-flow-logs-role.arn
  log_destination = aws_cloudwatch_log_group.this_log.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.this_vpc_network.id
}


resource "aws_cloudwatch_log_group" "this_log" {
  name = "${var.vpc_network_name}-cloudwatch-log"
}


resource "aws_iam_role" "vpc-flow-logs-role" {
  name = "${var.vpc_network_name}flow-logs-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "vpc-flow-logs-policy" {
  name = "${var.vpc_network_name}-vpc-flow-logs-policy"
  role = aws_iam_role.vpc-flow-logs-role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
