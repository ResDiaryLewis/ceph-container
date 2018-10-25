FROM python:3.7-slim-stretch

RUN apt-get -q update
RUN apt-get -qy install curl

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.12.1/bin/linux/amd64/kubectl \
&& chmod +x ./kubectl \
&& mv ./kubectl /usr/local/bin/kubectl

RUN apt-get -qy install uuid-runtime
RUN pip install pyyaml
RUN pip install jinja2-cli

RUN apt-get -qy clean

ADD . /usr/k8s/
