#Creates a standard instance for the programming level up project and tags it

import boto3
import botocore
import sys,getopt

#Define Script Parameters
def usage():
    usage = """
    -k --key-name             Key Name on AWS
    """
    print usage

opts, args = getopt.getopt(sys.argv[1:], "k:v", ["key-name" ]);
keyName = '';
for o, a in opts:
	if o == "-v":
		debug = True
	elif o in ("-h", "--help"):
		usage()
		sys.exit()
	elif o in ("-k", "--key-name"):
		keyName = a
	else:
		assert False, "unhandled option: " + o

if (not keyName):
    print "--key-name is a required field"
    usage()
    sys.exit(255)

def wait_for_instance(instance):
	print "Waiting for the instance to enter running state...."
	instance.wait_until_running();
	print "***********************************\n\n"
	print "EC2 instance \x1b[01;33m" + instanceId + "\x1b[00m is now running on \x1b[01;34m" + instance.public_ip_address + "\x1b[00m \n\n";

#MAIN
ec2 = boto3.resource('ec2')
ec2_client = boto3.client('ec2')

isRunning = False;
instanceId = ''
productName = "prg-lvl-up"

#Check to see if the user has any created
instances = ec2.instances.filter(
    Filters=[
    	{'Name': 'key-name', 'Values': [keyName]},
    	{'Name': 'tag:product_name', 'Values': [productName]}
    ]
)

for instance in instances:
	instanceId = instance.id;

	if instance.state["Name"] == "running":
		print "EC2 instance \x1b[01;33m" + instanceId + "\x1b[00m already running on \x1b[01;34m" + instance.public_ip_address + "\x1b[00m \n\n";

	elif instance.state["Name"] == "stopped":

		#restart
		print "EC2 instance \x1b[01;33m" + instanceId + "\x1b[00m was stopped, issuing a start.... \n";
		response = instance.start();
		wait_for_instance(instance)

	elif instance.state["Name"] == "stopping":
		#wait then restart

		print "EC2 instance \x1b[01;33m" + instanceId + "\x1b[00m is currently being stopped.... \n";
		print "Waiting for the instance to enter a stopped state.... \n";
		instance.wait_until_stopped();

		wait_for_instance(instance)
	
	#after checking states, only create if we are still not running
	if instance.state["Name"] == "running":
		isRunning = True;

if isRunning == False:
	print "\n***********************************"
	print "Creating EC2 instance...."

	try:
		createdInstance = ec2_client.run_instances(
			DryRun=False,
			MinCount=1,
			MaxCount=1,
			ImageId="ami-9be6f38c",
			KeyName=keyName,
			SecurityGroupIds=[
		        'sg-ec8ba391',
		    ],
		    InstanceType='t2.micro'
		);

		instanceId = createdInstance["Instances"][0]["InstanceId"];
	 
		print "Instance [" + instanceId + "] created...."

	except botocore.exceptions.ClientError as e:
		print "\n\x1b[01;31mError creating instance\n\n%s" % e + "\x1b[01;34m"

	if instanceId != '':
		instance = ec2.Instance(instanceId);

		wait_for_instance(instance)

		tags = instance.create_tags(
		    Tags=[ 
		    	{
		    		'Key': 'product_name', 
		    		'Value': productName
		    	},
		    	{
		    		'Key': 'business_unit', 
		    		'Value': 'cse'
		    	}
		    ]
		)
