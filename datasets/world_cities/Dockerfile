FROM rdr.prod.internal.geo.espn.com/espnautomation/alpine-jre8-64:latest

COPY load_cities.py /opt/espn/apps/

RUN apk update && apk upgrade && \
  apk add wget python groff less ca-certificates && \ 
  wget https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && \
  pip install awscli && \
  pip install boto3 && \
  chown espn:espn /opt/espn/apps/load_cities.py && \
  chmod 700 /opt/espn/apps/load_cities.py

USER espn

RUN mkdir -p /opt/espn/apps/dynamo && \
  mkdir -p /opt/espn/data/dynamo && \
  cd /opt/espn/apps/dynamo && \
  wget http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz && \
  tar -xzf dynamodb_local_latest.tar.gz  && \
  rm -f dynamodb_local_latest.tar.gz  && \ 
  cd /opt/espn/apps && \
  wget http://download.maxmind.com/download/worldcities/worldcitiespop.txt.gz && \ 
  rm -f get-pip.py && \
  gzip -d worldcitiespop.txt.gz && \
  printf '#!/bin/bash\njava -Xmx5G -Djava.library.path=/opt/espn/apps/dynamo/DynamoDBLocal_lib -jar /opt/espn/apps/dynamo/DynamoDBLocal.jar -sharedDb -dbPath /opt/espn/data/dynamo/ &' > start.sh && \
  chmod 700 start.sh && \
  ./start.sh && \
  mkdir ~/.aws && \
  printf "[default]\naws_access_key_id=foo\naws_secret_access_key=bar" > ~/.aws/credentials && \
  printf "[default]\nregion=no-region\noutput=json" > ~/.aws/config && \
  aws dynamodb create-table --table-name WorldCities --key-schema AttributeName=ID,KeyType=HASH \
      --attribute-definitions AttributeName=ID,AttributeType=N \
      --provisioned-throughput ReadCapacityUnits=100,WriteCapacityUnits=100 \
      --endpoint-url http://localhost:8000 && \
  ./load_cities.py

EXPOSE 8000

ENTRYPOINT ["/opt/espn/apps/start.sh"]



