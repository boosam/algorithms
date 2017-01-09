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

`pip install boto3 --ignore-installed six`

## Usage

###$ Create instance

python ./run-instance.py -k peand

