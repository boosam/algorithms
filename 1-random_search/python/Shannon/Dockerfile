FROM ubuntu

MAINTAINER Shannon Rhodes <shannon.rhodes@espn.com>

RUN echo 'Running Shannon's python for random search'

RUN apt-get update & apt-get install -y python

RUN python ./src/random_search.py
CMD ["python","./src/random_search.py"]
