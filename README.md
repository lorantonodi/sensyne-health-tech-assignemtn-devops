# DevOps Engineer - Tech Test
## Instructions
We believe in `infrastructure as code` and automation of deployments. We would like you to demonstrate your understanding and use of modern automated infrastructure and sysadmin. To demonstrate this, your goal is to provision a simple web application of your choice that has a backend and database store (write a simple app or use an off-the-shelf set of Docker images). Create an orchestrated cluster of nodes using any provisioning tool of your choice and deploy the application using an orchestration layer (e.g. Docker Swarm, Kubernetes, etc) to scale the application.
## Solution notes
- In the solution please provide clear instructions that allow us to replicate the solution from scratch. 
- As an infrastructure provider, please use GCP or AWS. 
- Commit often to show work in progress rather than one big push. Trial-and-error is allowed and encouraged. 
- The web application does not have to delivery any particular functionality. What we are testing is the ability to compose an application and database layer in a correct fashion, even if they do not talk to each other in any interesting way.
## Submitting
- Put your solution in a public Github repo and send a link. Include a clear README with installation instructions.

# Instructions

## AWS account setup

- Create a new AWS account
- Setup 2FA for your root user
- Setup a new IAM user with Programmatic access and AWS Management Console access (admin access)
- Setup 2FA for the new user
- Download and install AWS CLI and terraform and setup AWS access keys
- Create an S3 bucket to store the terraform remote state (since it's an s3 bucket the name must be unique) in eu-west-1
- Run the following command in the aws_account/vpc directory:
`terraform init \
  -backend=true \
  -backend-config="bucket=sensyne-health-tech-assignment-devops" \
  -backend-config="key=vpc/terraform.tfstate" \
  -backend-config="region=eu-west-1" \
  -reconfigure \ 
  -get=true -get-plugins=true -force-copy=true -input=false`
This will setup terraform to use a remote state file

- Run `terraform plan` and `terraform apply` in the aws_account/vpc directory
