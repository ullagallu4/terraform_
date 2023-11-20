output "vpc_id" {
  value = module.vpc.vpc_id
}
output "subnet-ids" {
  value = module.vpc.subnets_ids
}

output "sg_id" {
  value = module.sg.sg_id
}