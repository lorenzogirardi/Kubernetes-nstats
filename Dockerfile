FROM debian:stretch-slim
MAINTAINER lgirardi <l@k8s.it>

RUN apt-get -y update && apt-get -yq install \
	iftop \
	python3 \
	cron \ 
	curl 


RUN touch /var/log/cron.log
RUN mkdir /code
WORKDIR /code
ADD . /code/
RUN chmod +x /code/cron.sh
COPY crontab /etc/crontab
RUN crontab /etc/crontab
CMD env > /code/env.sh ; cron -f
