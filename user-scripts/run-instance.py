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

#MAIN
ec2 = boto3.resource('ec2')
ec2_client = boto3.client('ec2')

instanceId = ''

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

	print "Waiting for the instance to enter running state...."

	instance.wait_until_running();

	print "***********************************\n\n"
	print "EC2 instance \x1b[01;33m" + instanceId + "\x1b[00m is now running on \x1b[01;34m" + instance.public_ip_address + "\x1b[00m \n\n";

	tags = instance.create_tags(
	    Tags=[ 
	    	{
	    		'Key': 'Name', 
	    		'Value': 'prg-lvl-up'
	    	}
	    ]
	)
