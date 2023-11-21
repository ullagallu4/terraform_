output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_subne_ids" {
  value = module.vpc.public_subnets_ids
}
output "private_subnet_ids" {
  value = module.vpc.private_subnets_ids
}
output "sg_id" {
  value = module.sg.sg_id
}
output "ssh-commands" {
  value = module.ec2.ssh_command
}
output "instance_ids" {
  value = module.ec2.instance_ids
}
output "alb_dns" {
  value = module.lb.alb-dns
}