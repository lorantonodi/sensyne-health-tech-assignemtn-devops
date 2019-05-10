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
- Download and install AWS CLI, terraform (v0.11.3), kubectl and aws-iam-authenticator. Setup AWS access keys
- Create an S3 bucket to store the terraform remote state (since it's an s3 bucket the name must be unique) in eu-west-1
- Run the following command in the aws_account/vpc directory:

`terraform init -backend=true -backend-config="bucket=sensyne-health-tech-assignment-devops" -backend-config="key=vpc/terraform.tfstate" -backend-config="region=eu-west-1" -reconfigure -get=true -get-plugins=true -force-copy=true -input=false`

This will setup terraform to use a remote state file

- Run `terraform plan` and `terraform apply` in the aws_account/vpc directory

- Run the following command in the aws_account/dns directory:

`terraform init  -backend=true -backend-config="bucket=sensyne-health-tech-assignment-devops" -backend-config="key=dns/terraform.tfstate" -backend-config="region=eu-west-1" -reconfigure -get=true -get-plugins=true -force-copy=true -input=false`

- Run `terraform plan` and `terraform apply` in the aws_account/dns directory

- Run the following command in the aws_account/eks directory:

`terraform init  -backend=true -backend-config="bucket=sensyne-health-tech-assignment-devops" -backend-config="key=eks/terraform.tfstate" -backend-config="region=eu-west-1" -reconfigure -get=true -get-plugins=true -force-copy=true -input=false`

- Run `terraform plan` and `terraform apply` in the aws_account/eks directory

- Update the KUBECONFIG env variable: `export KUBECONFIG=$PWD/kubeconfig_glados`

- Update the configmap needed for aws auth on the cluster: `kubectl apply -f ./config-map-aws-auth_glados.yaml`

- Build the container for the flask-sample app in the project root dir `make container-build`
- Push the image to the dockerhub repository (it my own, so the push will fail)

- Deploy mongodb to the EKS cluster

- In the {project root}/k8s directory deploy mongodb to the cluster: `kubectl apply -f ./mongo.yml`

- get the MongoDB IP with the following command: `kubectl get service mongo`

- In the flask-app-deployment.yml DB_PORT_27017_TCP_ADDR env variable value with the mongo clusterIP address

- Deploy the flask-sample service: `kubectl apply -f ./flask-app-deployment.yml`

- Wait until the ELB is created, get the external address with the following command `kubectl get service flask-sample-service -o wide`

- Access the service on the ELB address via http


## Considerations:

Mongo will loose all data if the container is terminated for any reason, a persistent volume should be added if we want to keep the data (outside of AWS free tier) 

Mongo does not have a password, this is bad practice, however it is only accessible from inside the cluster.

Adding the mongo DB address manually to the flask-app-deployment is not an optimal solution, this should be automated

Whoever created this tech assigment, did not bothered to check if it is possible to do it using only AWS free tier resources considering the fact that if you don't use EKS, the minimum recommended ec2 instance size for master nodes are m3.medium. If you use normal t2.micro (the only free tier) instance as worker nodes, nothing can be scheduled on them, since the instance has only 1 GB of memory. EKS is outside free tier.

