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
# public subnets
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_range)
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.public_subnet_range[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
   Name = "${local.vpc_name}-${var.public_subnet_names[count.index]}"
  }
}
# private subnets
resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_range)
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.private_subnet_range[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
   Name = "${local.vpc_name}-${var.private_subnet_names[count.index]}"
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

resource "aws_route_table" "public_rtg" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  
  tags = {
    Name = "${local.vpc_name}-public RTG"
  }
}
# private RTG
resource "aws_route_table" "private_rtg" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = var.cidr_range
    local_gateway_id = "local"
  }
  
  tags = {
    Name = "${local.vpc_name}-private RTG"
  }
}


resource "aws_route_table_association" "public-rtg" {
count = length(var.public_subnet_range)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rtg.id
}

resource "aws_route_table_association" "private-rtg" {
count = length(var.private_subnet_range)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rtg.id
}