variable "sg_id" {
    type = list(string)
}
variable "public_subnets_ids" {
  type = list(string)
}
variable "vpc_id" {}

variable "instance_ids" {
  type = list(string)
}