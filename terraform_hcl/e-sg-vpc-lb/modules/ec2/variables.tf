variable "instance_type" {}
variable "public_subnets_ids" {
  type = list(string)
}
variable "sg_id" {
  type = list(string)
}
variable "key_name" {}
variable "names" {
  type = map(string)
}