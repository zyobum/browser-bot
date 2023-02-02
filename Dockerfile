# syntax=docker/dockerfile:1

FROM python:slim

LABEL maintainer="zyobum@5068.info"
ENV REFRESHED_AT 2023-02-02

RUN apt-get update && apt-get -y install apt-utils && apt-get -y install xvfb chromium-driver

RUN useradd -m app
USER app
WORKDIR /home/app

RUN mkdir output
RUN cp /usr/bin/chromedriver .

ENV PATH="/home/app/.local/bin:${PATH}"

COPY --chown=app:app requirements.txt requirements.txt
RUN pip install --upgrade pip
RUN pip install --user -r requirements.txt

COPY --chown=app:app main.py main.py

VOLUME /home/app/output

WORKDIR /home/app/output

CMD [ "xvfb-run", "python", "/home/app/main.py" ]
