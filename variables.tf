variable "aws_region" {
  default = "eu-west-1"
}

variable "ec2_stop_cron" {
  default = "cron(0 20 ? * MON-FRI *)"
}

variable "function_prefix" {
  default = ""
}
