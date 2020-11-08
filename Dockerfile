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
RUN pip3 install -r requirements.txt \
    && pip3 install .

EXPOSE 8000
WORKDIR /usr/src/inspektor
CMD ["uwsgi", "--emperor", "--ini", "inspektor.ini"]
