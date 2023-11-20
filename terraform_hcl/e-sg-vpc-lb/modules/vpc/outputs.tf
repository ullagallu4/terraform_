output "vpc_id" {
  value = aws_vpc.myvpc.id
}
output "subnets_ids" {
  value = aws_subnet.subnets.*.id
}