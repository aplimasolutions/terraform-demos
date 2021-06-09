# How to set up a highly available Jenkins master ?
This directory contains terraform configuration files required
to set up a highly available Jenkins master in a single AWS region 
with multiple Availability Zones using: 
- Elastic File System (EFS)
- Default VPC

## What resources will be provisoned?
1. **Elastic File System (EFS)** - This is where JENKINS_HOME data will reside. 
2. **Auto Scaling Group** - To automatically provision a new Jenkins master incase of a failure.
3. **Launch Configuration** - This will be used by the Auto Scaling Group to provision a new Jenkins master
4. **Application Load Balancer (ALB)** - pointing to your Auto Scaling group so that you can find Jenkins master 
   using the load balancer DNS name.
5. **Jenkins Master** - This is the primary Jenkins master
4. **Security Groups** 
   - EFS : Allow port 2049
   - Jenkins : Allow ports 8080, 22, 2049
   - ALB: Allow port 80

## Prerequisites

### AWS
1. AWS Account. 
2. IAM Privileges to provision an EC2 instance.
3. AWS CLI credentials
4. SSH Keypair.

### Terraform
1. Install Terraform v0.14 on your local machine.
2. AWS Credentials set as environment variables or as shared credentials under /$YOUR_HOME_DIRECTORY/.aws/credentials


## Steps
* Be sure you are in the **jenkins-ha** directory.
* Create a file named ***terraform.tfvars***.
- Add the following content to this file:
    - **ssh_key_name = "<YOUR SSH KEY NAME"**
    - **region = "AWS REGION"**
    - **instance_type = "INSTANCE_TYPE"**

    - **NOTE**
        - ***ssh_key_name*** is the name of the SSH Key you use to connect to your EC2 instance.

* Run the command ***terraform init*** to initialize your working directory.

* Run the command ***terraform apply*** and follow the prompts to provision your highly available Jenkins infrastructure.

* If everything runs successfully, terraform will output ALB DNS Name and EFS DNS Name. 
  Enter the ALB DNS Name on a browser. You should see the unlock Jenkins screen. Follow the instructions to set up your 
  Jenkins master.

* Note: Incase your primary Jenkins server goes down, a new one will automatically be provisioned.