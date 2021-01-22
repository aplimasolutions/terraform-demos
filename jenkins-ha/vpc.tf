provider "aws" {
  region = var.region
}
# Use default VPC
data "aws_vpc" "default" {
  default = true
}
# Fetch subnets for default VPCs
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}