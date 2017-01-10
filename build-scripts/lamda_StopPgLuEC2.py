# Code for lamdba function to stop all running instances of programming level up

import boto3

def lambda_handler(event, context):

    ec2 = boto3.resource('ec2')
    ec2_client = boto3.client('ec2')
    
    productName = "prg-lvl-up"

    instances = ec2.instances.filter(
           Filters=[
        	{'Name': 'tag:product_name', 'Values': [productName]}
        ]
    )

    for instance in instances:
    	instanceId = instance.id;
    	response = ec2_client.stop_instances(
    		DryRun=False,
    		InstanceIds=[instanceId]
    	);
    	print 'Stopped ' + instanceId
    return True