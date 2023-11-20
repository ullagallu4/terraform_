module "vpc" {
  source       = "./modules/vpc"
  vpc_name     = "siva"
  cidr_range   = "172.16.0.0/16"
  subnet_range = ["172.16.1.0/24", "172.16.2.0/24"]
  subnet_names = ["public1", "public2"]
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id

}