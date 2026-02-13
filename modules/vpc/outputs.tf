output "vpc_id" {
  description = "The ID of the VPC"
  value = aws_vpc.this.id
}

output "subnet_id" {
  description = "TheID of the subnet"
  value = aws_subnet.this.id
}

output "private_subnets_id" {
  value = aws_subnet.private.id
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value = aws_internet_gateway.this.id
}

output "route_table_id" {
  description = "The ID of the route table"
  value = aws_route_table.public.id
}