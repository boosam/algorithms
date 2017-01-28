#!/usr/bin/python
import boto3
from multiprocessing import Pool, TimeoutError, Queue
import threading
import sys

num_threads = 5
threadlock = threading.Lock()
id = -1

# This block ensures that id's will be unique across threads.
def getid():
    global id
    with threadlock:
        id += 1
        return id


# post the data into local dynamo instance
def post(item_queue):
    session = boto3.session.Session()
    dynamodb = session.resource('dynamodb', region_name='foo', endpoint_url='http://localhost:8000')
    table = dynamodb.Table('WorldCities')
    with table.batch_writer() as batch:
        while item_queue.empty() is not True:
            try:
                line = item_queue.get()
                line.decode('utf-8')
                vals = line.strip('\n').split(',')
                data = { }
                data['ID'] = getid()
                if vals[0] != '' and vals[0] is not None:
                    data['CountryCode'] = str(vals[0])
                if vals[1] != '' and vals[1] is not None:
                    data['ASCIICityName'] = str(vals[1])
                if vals[2] != '' and vals[2] is not None:
                    data['CityName'] = str(vals[2])
                if vals[3] != '' and vals[3] is not None:
                    data['Region'] = str(vals[3])
                if vals[4] != '' and vals[4] is not None:
                    data['Population'] = str(vals[4])
                if (vals[5] != '' and vals[5] is not None) and (vals[6] != '' and vals[6] is not None):
                    data['Latitude'] = vals[5]
                    data['Longitude'] = vals[6]

                batch.put_item(Item=data)

            except UnicodeError:
                print "not utf-8"
            except:
                e = sys.exc_info()[0]
                print e
                print "other error in processing"


f = open('worldcitiespop.txt', 'r')
f.readline()
print "created list from file"
list = f.readlines()

# create thread safe queue
item_queue = Queue()
for i in list:
    item_queue.put(i)

list = None
f.close()

print "created thread safe queue"

# start the worker threads to post to dynamo
for i in range(num_threads):
    t = threading.Thread(target=post, args=(item_queue,))
    t.start()

print "waiting for threads to complete"
