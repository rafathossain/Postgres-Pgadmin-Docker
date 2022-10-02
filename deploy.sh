#!/bin/bash

echo "Deploying Postgres Database and Pgadmin"
echo "========================================="
echo "Prepared by Md. Rafat Hossain"
echo "Date: 02 October 2022"
echo "========================================="

echo -n "Cleaning up existing postgres docker containers..."

docker stop $(docker ps -a -q --filter "name=postgres_db") >/dev/null 2>&1
docker kill $(docker ps -q --filter "name=postgres_db") >/dev/null 2>&1
docker rm $(docker ps -a -q --filter "name=postgres_db") >/dev/null 2>&1
docker rmi $(docker images -q --filter "name=postgres_db") >/dev/null 2>&1

docker stop $(docker ps -a -q --filter "name=postgres_admin") >/dev/null 2>&1
docker kill $(docker ps -q --filter "name=postgres_admin") >/dev/null 2>&1
docker rm $(docker ps -a -q --filter "name=postgres_admin") >/dev/null 2>&1
docker rmi $(docker images -q --filter "name=postgres_admin") >/dev/null 2>&1

docker system prune -a -f >/dev/null 2>&1
docker volume prune -f >/dev/null 2>&1
docker builder prune -a -f >/dev/null 2>&1

shopt -s extglob

systemctl restart docker

echo "COMPLETE"

echo -n "Creating docker data directory..."

mkdir -p /home/docker-storage/postgresql >/dev/null 2>&1
mkdir -p /home/docker-storage/pgadmin >/dev/null 2>&1
chmod 777 /home/docker-storage/pgadmin

echo "COMPLETE"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

echo -n "Bringing up docker container..."

docker-compose -f "$SCRIPT_DIR/docker-compose.yml" up -d

docker system prune -a -f >/dev/null 2>&1

echo "COMPLETE"

cp -n "$SCRIPT_DIR/env.example" "$SCRIPT_DIR/.env"

echo "Deployment completed successfully."
echo "========================================="
