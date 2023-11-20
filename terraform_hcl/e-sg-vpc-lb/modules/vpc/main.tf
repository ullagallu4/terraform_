# VPC BLock
locals {
  vpc_name = var.vpc_name

}

resource "aws_vpc" "myvpc" {
  cidr_block       = var.cidr_range
  instance_tenancy = "default"

  tags = {
    Name = local.vpc_name
  }
}

# Subnets Blocks

resource "aws_subnet" "subnets" {
  count = length(var.subnet_range)
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.subnet_range[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
   Name = "${local.vpc_name}-${var.subnet_names[count.index]}"
  }
}

# iGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "${local.vpc_name}-IGW"
  }
}

# Public RTG

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  
  tags = {
    Name = "${local.vpc_name}-public RTG"
  }
}

resource "aws_route_table_association" "public-rtg" {
count = length(var.subnet_range)
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.example.id
}