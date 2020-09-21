import boto3
import logging

#logging level to be changed based on env e.g.dev/test: INFO, DEBUG / prod: ERROR
logger = logging.getLogger()
logger.setLevel(logging.INFO)

#define connection
ec2 = boto3.resource('ec2')

def lambda_handler(event, context):
    #filter tag: <<Schedule>> and <<running>> EC2 instances
    filters = [{
            'Name': 'tag:nightly',
            'Values': ['bastion']
        },
        {
            'Name': 'instance-state-name', 
            'Values': ['running']
        }
    ]

  #create parameter for instance ids of filtered EC2 instances
    filteredID = [instance.id for instance in ec2.instances.filter(Filters=filters)]

    #perform stop
    for InstanceIds in filteredID:
        startec2= ec2.instances.stop(InstanceIds=filteredID)
        print "Instance %s stopped" %filteredID

    if filteredID is None:
        print "stopped 0 instances"
