FROM python:3.8-slim

RUN apt-get update \
&& apt-get install gcc -y \
&& apt-get clean

# set work directory
WORKDIR /usr/src/

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1


COPY ./ /usr/src/
RUN pip install -r requirements.txt
RUN pip install inspektor


CMD ["uwsgi --socket 0.0.0.0:5000 --protocol=http --ini inspektor.ini"]
