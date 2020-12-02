#
# String Variable
#
variable "region" {
  type    = string
  default = "us-east-1"
}
#
# String Variable
#
variable "ssh_key_name" {
  type = string
}
#
# String Variable
#
variable "instance_type" {
  type    = string
  default = "t2.medium"
}