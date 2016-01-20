IP=`boot2docker ip`
CONTAINER_ID=`docker ps -q`

# Native

bootstrap:
	virtualenv env -p python

deps:
	env/bin/pip install -r requirements.txt

start:
	supervisord -l /tmp/supervisord.log -y 100KB -z 0 -e info -j /tmp/supervisord.pid

status:
	supervisorctl status

log:
	tail -f /tmp/supervisord.log
	tail -f /tmp/app_server.log

stop:
	supervisorctl stop
	supervisorctl shutdown

# Docker -> Native

build:
	docker build --tag codeart-benchmarks/benchmark-py27-bjoern-wsgi:v1 .
	docker images

browser:
	open "http://${IP}:8001"

run: browser
	docker run -i -p 8001:8000 codeart-benchmarks/benchmark-py27-bjoern-wsgi:v1
	docker ps -l

dstatus:
	docker exec ${CONTAINER_ID} supervisorctl status

port:
	docker port ${CONTAINER_ID}

ps:
	boot2docker ip
	docker ps

# ELB Local -> Docker -> Native

eb_local_bootstrap:
	eb init

eb_local_run:
	eb local run --port 8000

eb_local_status:
	eb local status

eb_local_browser:
	eb local open

# ELB Production -> Docker -> Native

eb_deploy:
	eb create prod --single --service-role prod
	eb deploy prod
	aws elasticbeanstalk update-environment --environment-name prod --region us-east-1 --option-settings file://./options.txt
	eb status prod
	eb open prod

eb_browser:
	eb open prod

eb_status:
	eb status prod

eb_log:
	eb events prod
	eb logs prod

eb_terminate:
	eb terminate prod
	eb status prod
