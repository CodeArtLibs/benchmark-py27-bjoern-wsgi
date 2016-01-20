codeart-benchmark-toolset
=========================

Usage
-----

    make bootstrap
    make deps
    make start
    make status
    make log
    make stop



Usage with Docker
-----------------

Install Docker: https://docs.docker.com/mac/step_one/ or https://docs.docker.com/linux/step_one/

OSX Docker example:

    boot2docker init
    boot2docker start
    boot2docker ip
    export DOCKER_HOST=tcp://192.168.59.103:2376
    export DOCKER_CERT_PATH=/Users/paulocheque/.boot2docker/certs/boot2docker-vm
    export DOCKER_TLS_VERIFY=1

General:

    make build
    make browser
    make run
    make ps


Usage with AWS-ELB + Docker
---------------------------

Install autoenv:

    pip install autoenv==1.0.0

Install AWS Command Line tools:
http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3.html

    # http://docs.aws.amazon.com/cli/latest/reference/elasticbeanstalk/index.html
    # https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html
    pip install awscli==1.9.21 awsebcli==3.7.2


AWS
---

Settings for *options.txt* file

- Ubuntu Server 14.04 LTS (HVM), SSD Volume Type - ami-fce3c696
- Ubuntu Server 14.04 LTS (PV), SSD Volume Type - ami-b2e3c6d8

- t2.micro
- t2.small
- t2.medium
- m3.medium
- m3.xlarge


Troubleshooting
---------------

OSX:

    sudo chown -R `whoami`:admin /usr/local/share
    sudo chown -R `whoami`:admin /usr/local/bin
    brew link awscli


