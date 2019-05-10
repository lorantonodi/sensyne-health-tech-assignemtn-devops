module "eks-cluster" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = "glados"
  subnets      = "${data.terraform_remote_state.vpc.private_subnets}"
  vpc_id       = "${data.terraform_remote_state.vpc.vpc_id}"

  worker_groups = [
    {
      instance_type = "t2.micro"
      asg_max_size  = 2
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}