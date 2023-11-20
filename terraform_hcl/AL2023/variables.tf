variable "region" {
  default = "ap-south-1"
}
variable "profile" {
  default = "default"
}


variable "instance_type" {
  default = "t3.micro"
}
variable "ps1" {
  type    = string
  default = "subnet-04b2e5e180d39743a"
}
variable "sg_id" {
  type    = list(string)
  default = ["sg-06ebe1002ddcffb88"]
}
variable "key_name" {
  default = "ansible"
}