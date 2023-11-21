resource "aws_instance" "instane-AL3" {
  for_each = {
    "subnet1" = var.public_subnets_ids[0]
    "subnet2" = var.public_subnets_ids[1]
    "subnet3" = var.public_subnets_ids[2]
    # Add more keys if needed
  }
  ami             = data.aws_ami.amzn2.id
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = each.value
  security_groups = var.sg_id
  availability_zone = data.aws_availability_zones.available.names[index(var.public_subnets_ids, each.value)]
  user_data = file("${path.module}/webserver.sh")
  tags = {
    Name = var.names[each.key]
  }
}





  