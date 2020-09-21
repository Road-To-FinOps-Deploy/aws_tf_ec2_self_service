#import sdk
import boto3
import logging

#logging level to be changed based on env e.g.dev/test: INFO, DEBUG / prod: ERROR
logger = logging.getLogger()
logger.setLevel(logging.INFO)

#define connection
ec2 = boto3.resource('ec2')

def lambda_handler(event, context):
    #filter tag: <<Schedule>> and <<stopped>> EC2 instances
    filters = [{
            'Name': 'tag:nightly', 
            'Values': ['bastion']
        },
        {
            'Name': 'instance-state-name', 
            'Values': ['stopped']
        }
    ]
    
    #create parameter for instance ids of filtered EC2 instances
    filteredID = [instance.id for instance in ec2.instances.filter(Filters=filters)]

    for InstanceIds in filteredID:
        startec2= ec2.instances.start(InstanceIds=filteredID)
        print "Instance %s started" %filteredID

    if filteredID is None:
        print "Started 0 instances"

