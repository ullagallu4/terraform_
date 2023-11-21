module "vpc" {

  source               = "./modules/vpc"
  vpc_name             = "siva"
  cidr_range           = "172.16.0.0/16"
  public_subnet_range  = ["172.16.4.0/24", "172.16.5.0/24", "172.16.10.0/24"]
  private_subnet_range = ["172.16.7.0/24", "172.16.8.0/24", "172.16.9.0/24"]
  public_subnet_names  = ["public1", "public2", "public3"]
  private_subnet_names = ["private1", "private2", "private3"]

}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id

}

module "ec2" {
  source             = "./modules/ec2"
  instance_type      = "t3.micro"
  public_subnets_ids = module.vpc.public_subnets_ids
  sg_id              = [module.sg.sg_id]
  key_name           = "ugl"
  names = {
    "subnet1" = "webserver1"
    "subnet2" = "webserver2"
    "subnet3" = "webserver3"
  }

}

module "lb" {
  source             = "./modules/lb"
  sg_id              = [module.sg.sg_id]
  public_subnets_ids = module.vpc.public_subnets_ids
  vpc_id             = module.vpc.vpc_id
  instance_ids       = module.ec2.instance_ids
}