variable "aws_region" {
  default = "eu-west-1"
}

variable "ec2_stop_cron" {
  default = "cron(0 20 ? * MON-FRI *)"
}

variable "function_prefix" {
  default = ""
}

variable "provider" {
  default = ""
}

variable "hosted_zone_id"{}

variable "domain_name" {}

variable "costsave" {
  default = 1
}