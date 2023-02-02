# syntax=docker/dockerfile:1

FROM python:slim

LABEL maintainer="zyobum@5068.info"
ENV REFRESHED_AT 2023-02-02

RUN apt-get update && apt-get -y install apt-utils && apt-get -y install xvfb chromium-driver

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY main.py main.py

VOLUME /output

WORKDIR /output

CMD [ "xvfb-run", "python3", "main.py" ]
