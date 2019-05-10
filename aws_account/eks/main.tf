module "eks-cluster" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = "glados"
  subnets      = "${data.terraform_remote_state.vpc.public_subnets}"
  vpc_id       = "${data.terraform_remote_state.vpc.vpc_id}"

  worker_groups = [
    {
      instance_type = "m3.medium"
      asg_max_size  = 2
      bootstrap_extra_args = "--enable-docker-bridge true"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}