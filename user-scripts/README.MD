# Running AWS Command Line Wrapper Scripts


## Requirements

* An AWS account on ESPN-CSE-Sandbox
* A keypair set up to pair with your instance
* AWS CLI
* Python

## Setup

### Install the AWS CLI

[http://docs.aws.amazon.com/cli/latest/userguide/tutorial-ec2-ubuntu.html#install-cli]

Non-windows users can install via pip. If you don't have pip yet, run:

```
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
sudo python get-pip.py
```

To install AWS CLI

`sudo pip install awscli `

If you get an error about uninstalling a package called six, run this instead:

`sudo pip install awscli --ignore-installed six`

### Configure the AWS CLI

Run the following command to enter your credentials that you recieved during your account setup

`aws configure`

### Setup Python SDK

`sudo pip install boto3 --ignore-installed six`

### Set up Key Pair

* Make sure there is key pair imported into the region you will be creating instances
* AWS Console -> EC2 -> Network & Security -> Key Pairs
* Import or create a key pair with your CORP username as they key pair name

## Usage

### Create/Run instance

`python ./run-instance.py -k [CORP USERNAME]`

This will create a new instance if none exist under your key name, or restart an instance that has been previously stopped

### Stop instance

`python ./stop-instance.py -k [CORP USERNAME]`

This will stop your instance (it can be restarted above)



