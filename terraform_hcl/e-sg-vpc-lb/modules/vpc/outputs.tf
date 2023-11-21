output "vpc_id" {
  value = aws_vpc.myvpc.id
}
output "public_subnets_ids" {
  value = aws_subnet.public_subnets.*.id
}
output "private_subnets_ids" {
  value = aws_subnet.private_subnets.*.id
}