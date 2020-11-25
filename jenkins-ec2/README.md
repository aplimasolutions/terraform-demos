# How to install Jenkins LTS on an Ubuntu 18.04 LTS EC2 instance?

## Prerequisites

### AWS
1. AWS Account. 
2. IAM Privileges to provision an EC2 instance.
3. AWS CLI credentials
4. SSH Keypair.

### Terraform
1. Install Terraform v0.12.28 or greater on your local machine.
2. AWS Credentials set as environment variables or as shared credentials under /$YOUR_HOME_DIRECTORY/.aws/credentials

### Jenkins
1. JDK version 8 or 11.
2. Allow Port 8080 for Jenkins UI

## Steps
* Be sure you are in the **jenkins-ec2** directory.
* Create a file named terraform.tfvars.
** Add the following content to this file:
    **ssh_key_name = "<YOUR SSH KEY NAME"**
    **region = "REGION"**
    **instance_type = "INSTANCE_TYPE"**

**NOTE**
*ssh_key_name* is the name of the SSH Key you use to connect to your EC2 instance.
*region* is an AWS region that is closest to you. Example, us-east-1, eu-west-1 etc.
*instance_type* is an AWS EC2 instance type. Example: t2.medium, t2.small etc.

* Run the command *terraform init* to initialize your working directory

* Run the command *terraform apply* and follow the prompts to provision your EC2 Instance.

* To verify if Jenkins is up and running, open a browser of your choice and enter 
http://<PUBLIC_IP_EC2_INSTANCE>:8080

* Follow the prompts to complete the post-installazation wizard steps.

* If you no longer need the EC2 instance, run the command, *terraform destroy*