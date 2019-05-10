output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

output "private_subnets" {
	description = "List of private subnet ids"
	value = "${module.vpc.private_subnets}"
}