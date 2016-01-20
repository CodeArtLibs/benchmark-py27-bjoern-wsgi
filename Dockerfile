FROM ubuntu:14.04

# Installing Linux packages

RUN apt-get -y update
RUN apt-get install -y build-essential


# Installing Python
RUN apt-get -y install python-dev python-pip


# Installing Python packages
RUN pip install supervisor==3.2.0 virtualenv==14.0.0


###############################################################################
# Benchmark configuration

# Configuring OS
# ENV TIME_WAIT_MS 300
# ENV FIRST_PORT_NUMBER 10152
# ENV MAX_SOCKETS 65536
# ENV MAX_OPEN_FILES 65536
# ENV MAX_OPEN_FILES_PER_PROC 65536

# Network
# Update TIME_WAIT length
#RUN sysctl -w net.inet.tcp.msl=$TIME_WAIT_MS
# Number of ephemeral ports = last (65536) - first
#RUN sysctl -w net.inet.ip.portrange.first=$FIRST_PORT_NUMBER

# Kernel
#RUN sysctl -w kern.ipc.somaxconn=$MAX_SOCKETS
#RUN sysctl -w kern.maxfiles=$MAX_OPEN_FILES
#RUN sysctl -w kern.maxfilesperproc=$MAX_OPEN_FILES_PER_PROC
# Reuse TCP sockets
# echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
# echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle
#RUN sh -c ulimit -HSn $MAX_OPEN_FILES
# max number of open file descriptors
#RUN ulimit -n $MAX_OPEN_FILES

ENV WORKERS 5
ENV KEEP_ALIVE 120
ENV CC gcc
ENV N_SECONDS 0.0001
ENV RECREATE_DB True

# Code
RUN apt-get -y install libev-dev
COPY requirements.txt /src/requirements.txt
COPY run.py /src/run.py
COPY supervisord.conf /src/supervisord.conf
WORKDIR /src
RUN virtualenv env -p python
RUN env/bin/pip install -r requirements.txt

# CMD ["supervisord", "-z", "0", "-c", "/src/supervisord.conf"]
CMD ["/src/env/bin/python", "-OO", "/src/run.py"]

###############################################################################
# Information

WORKDIR /src
RUN env/bin/python -c 'import struct ; import sys ; print("Python %s\n%sbits" % (sys.version, 8 * struct.calcsize("P")))'
RUN env/bin/python -c 'import sys ; print(sys.maxunicode)'
