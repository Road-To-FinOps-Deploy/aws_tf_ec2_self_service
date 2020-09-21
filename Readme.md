#Lambda Scheduler
```
The script schedules the start/stop of EC2 instances based on tag.
```
This assumes you have set the "nightly" tag in the EC2 module to 'onoff' or bastion to keep it off unless needed. 
Currently, this is hard coded to the EU-West-1 region, at some point it should be refactored to pull the region from the Lambda location. 

Remmmber this use UCT Time 

Usage:

module "aws_scheduler" {
  source      = ""
  environment_variables = {
    ASGROUP = "${<aws_autoscaling_group_name>}"
  }
}