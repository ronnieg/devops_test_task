#!/bin/bash

cd /opt/docker_compose/site1
docker-compose build
docker-compose up -d
cd /opt/docker_compose/site2
docker-compose build
docker-compose up -d
cd /opt/docker_compose/site3
docker-compose build
docker-compose up -d
cd /opt/docker_compose/reverse-proxy/
docker-compose build
docker-compose up -d
