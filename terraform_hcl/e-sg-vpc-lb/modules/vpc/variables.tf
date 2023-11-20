
variable "vpc_name" {
  description = "name of the vpc is"
  type = string
}
variable "cidr_range" {
  description="define cidr range"
  type = string
}

variable "subnet_range" {
  description="define cidr range"
  type = list(string)
  default = ["172.16.0.0/24","172.16.1.0/24"]
}


variable "subnet_names" {
  description="subnet names"
  type = list(string)
  default = ["public1","public2"]
}