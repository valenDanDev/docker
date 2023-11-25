# syntax = docker/dockerfile:
FROM ubuntu:23.10
# Update and upgrade OS
RUN apt-get update
RUN apt-get upgrade -y
ENV TZ=America/Bogota
RUN ln - snf /usr/share/zoneinfo/$TZ/ect/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y tzdata
# Install python3, pip package manager
RUN apt-get install -y python3 python3-pip python3-virtualenv
# Create Python Virtual Env
ENV VIRTUAL_ENV=/opt/labfinal/
RUN python -m virtualenv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
# Install jam-py package
RUN python3 -m pip install jam.py
RUN python3 /opt/labfinal/bin/jam-project.py
ENTRYPOINT [ "/opt/labfinal/bin/python3" , "server.py"]