module "vpc" {

  source               = "./modules/vpc"
  vpc_name             = "siva"
  cidr_range           = "172.16.0.0/16"
  public_subnet_range  = ["172.16.4.0/24", "172.16.5.0/24","172.16.10.0/24"]
  private_subnet_range = ["172.16.7.0/24", "172.16.8.0/24","172.16.9.0/24"]
  public_subnet_names  = ["public1", "public2","public3"]
  private_subnet_names = ["private1", "private2","private3"]

}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id

}