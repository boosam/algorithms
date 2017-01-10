#Stops a programming level up EC2 instance by key name

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
		print "EC2 instance \x1b[01;33m" + instanceId + "\x1b[00m is running on \x1b[01;34m" + instance.public_ip_address + "\x1b[00m \n\n";
		print "Stopping instance...."
		response = ec2_client.stop_instances(
			DryRun=False,
			InstanceIds=[instanceId]
		);
		instance.wait_until_stopped();
		print "EC2 instance \x1b[01;33m" + instanceId + "\x1b[00m has been stopped \n\n";
