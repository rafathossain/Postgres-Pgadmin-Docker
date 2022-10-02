# Postgres and Pgadmin Docker

Steps to install:
1. Copy the env.example to .env `cp env.example .env`
2. Fill up the following fields in the .env file
```
POSTGRES_PASSWORD=

PGADMIN_DEFAULT_EMAIL=
PGADMIN_DEFAULT_PASSWORD=
```
3. Now run `sh deploy.sh`
4. After the docker container is up, you can access the pgadmin via: {SERVER_IP}:5480
5. Thank you.
