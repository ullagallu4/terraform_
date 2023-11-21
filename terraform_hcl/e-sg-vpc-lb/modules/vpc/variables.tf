
variable "vpc_name" {
  description = "name of the vpc is"
  type = string
}
variable "cidr_range" {
  description="define cidr range"
  type = string
}

variable "public_subnet_range" {
  description="define cidr range"
  type = list(string)
}

variable "private_subnet_range" {
  description="define cidr range"
  type = list(string)
}


variable "public_subnet_names" {
  description="subnet names"
  type = list(string)
}

variable "private_subnet_names" {
  description="subnet names"
  type = list(string)
}