FROM debian
MAINTAINER lgirardi <l@k8s.it>

RUN apt-get -y update && apt-get -yq install \
	iftop \
	python3 \
	cron \ 
	curl 

ENV IFACE=eth0
ENV INFLUX=192.168.1.28:8086

RUN touch /var/log/cron.log
RUN mkdir /code
WORKDIR /code
ADD . /code/
RUN chmod +x /code/cron.sh
COPY crontab /etc/crontab
RUN env > /code/env.sh
RUN crontab /etc/crontab
CMD ["cron", "-f"]
