# VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = merge(
    var.tags,
    { name = "${var.vpc_name}" }
  )
}

# Public subnet
resource "aws_subnet" "this" {
  vpc_id = aws_vpc.this.id
  cidr_block = var.public_subnet
  availability_zone = var.availability_zone

  tags = merge(
    var.tags,
    { name = "${var.vpc_name}-subnet" }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    { name = "${var.vpc_name}-igw" }
  )
}

# Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    { name = "${var.vpc_name}-route-table" }
  )
}

# Route
resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
}

# Private subnets
resource "aws_subnet" "private" {
  for_each = toset(var.private_subnets)

  vpc_id = aws_vpc.this.id
  cidr_block = each.value
  availability_zone = var.availability_zone
  tags = merge(
    var.tags,
    { name = "private-subnet-${each.key}" }
  )
}