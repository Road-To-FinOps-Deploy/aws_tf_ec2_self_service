#  EC2 Self Service
```
Aws terrafrom module to deploy a lambda which can start ec2s when devs need it and stop them at the end of the day
```



## Usage


module "aws_tf_ec2_self_service" {
  source = "/aws_tf_ec2_self_service"
}

## Optional Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ec2\_stop\_cron | Rate expression for when to run the stop| string | `"cron(0 20 ? * MON-FRI *)"` | no 
| function\_prefix | Prefix for the name of the lambda created | string | `""` | no |
| aws_region| region deployed| string | `"eu-west-1"` | no |
| costsave| count if needed in an evv| string | `"1"` | no |


## Testing 

Configure your AWS credentials using one of the [supported methods for AWS CLI
   tools](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html), such as setting the
   `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables. If you're using the `~/.aws/config` file for profiles then export `AWS_SDK_LOAD_CONFIG` as "True".
1. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
1. Install [Golang](https://golang.org/) and make sure this code is checked out into your `GOPATH`.
cd test
go mod init github.com/sg/sch
go test -v -run TestTerraformAwsExample
