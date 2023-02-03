# syntax=docker/dockerfile:1

FROM python:slim

LABEL maintainer="zyobum@5068.info"
ENV REFRESHED_AT 2023-02-02
ENV DEBIAN_FRONTEND noninteractive

# Install packages
RUN apt-get update && apt-get -y install apt-utils && apt-get -y install xvfb chromium-driver

# create app user
RUN useradd -m app
USER app
WORKDIR /home/app

# Copy chromedriver for hot-patch
RUN mkdir output
RUN cp /usr/bin/chromedriver .

ENV PATH="/home/app/.local/bin:${PATH}"

# Install requirements
COPY --chown=app:app requirements.txt requirements.txt
RUN pip install --upgrade pip
RUN pip install --user -r requirements.txt

# Install files
COPY --chown=app:app main.py main.py
COPY --chown=app:app start.sh start.sh 
RUN chmod +x start.sh

VOLUME /home/app/output

WORKDIR /home/app/output

CMD [ "bash", "-c", "/home/app/start.sh" ]
