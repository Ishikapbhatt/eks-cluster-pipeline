provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"
  name    = "eks-vpc"
  cidr    = "10.0.0.0/16"
  azs     = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway = true
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-eks-cluster"
  cluster_version = "1.28"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_types = ["t3.medium"]
    }
  }
}
