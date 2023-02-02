 <h1 align="center">AWS Infrastructure using Terraform</h1> 

![Terraform](https://miro.medium.com/max/1400/1*uROgj7pJBK95JibA-PKDHA.webp)

This repository contains the code for provisioning an AWS infrastructure using Terraform. The infrastructure includes a Virtual Private Cloud (VPC) with private and public subnets, route table associations, an Amazon Relational Database Service (RDS) database on a private subnet, and two web servers.

## Prerequisites
1. - [ ] **Terraform** installed on your machine. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
2. - [ ] An AWS account with sufficient permissions to create and manage resources.
3. - [ ] A valid AWS access key and secret access key.

## Getting Started
1. Open bash terminal and clone the repository to your local machine:
```
git clone https://github.com/melissacharles/AWS-Terraform-Provision
```
2. Navigate to the repository directory:
```
cd aws-infrastructure-terraform
```
3. Create a terraform.tfvars file and define your AWS access key and secret access key:
```
aws_access_key = "your_aws_access_key"
aws_secret_key = "your_aws_secret_key"
```
4. Initialize Terraform:
```
terraform init
```
5. Review the Terraform plan:
```
terraform plan
```
6. If the plan looks good, apply the changes to provision the infrastructure:
```
terraform apply
```
7. Once the infrastructure is provisioned, you can access the web servers using their public IP addresses. The RDS database will be accessible from the web servers using the private IP addresses.

## Architecture
The infrastructure is divided into the following components:

- Virtual Private Cloud (VPC)
- Public Subnets
- Private Subnets
- Route Table Associations
- Amazon Relational Database Service (RDS) database
- Web Servers

The VPC provides a secure and isolated network for the resources. The public subnets are used to host the web servers, while the private subnets are used to host the RDS database. The route table associations ensure that the communication between the public and private subnets is properly routed.

### Cleaning up
To clean up the resources created by Terraform, run:
```
terraform destroy
```

## Conclusion
This repository demonstrates the implementation of an AWS infrastructure using Terraform. The VPC provides a secure, isolated network environment while the subnets allow for proper network segmentation and communication routing. The RDS database instance serves as a scalable, managed database solution and the web servers host the application. This code serves as a foundation for building more complex AWS infrastructures and can be adapted to specific use cases. The Terraform configuration can be easily version controlled and reused for reproducible infrastructure deployments. If you have any questions or issues, feel free to open an issue in the repository.
