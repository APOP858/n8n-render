#!/usr/bin/env bash

: ${EXPORT_DIR:="n8n-$(date +%Y%m%d)"}

set -euo

docker run \
    -p 5678:5678 \
    -v /.env \
    -e N8N_ENCRYPTION_KEY \
    -e GENERIC_TIMEZONE \
    -e TZ \
    -e DB_TYPE \
    -e DB_POSTGRESDB_DATABASE \
    -e DB_POSTGRESDB_HOST \
    -e DB_POSTGRESDB_PORT \
    -e DB_POSTGRESDB_USER \
    -e DB_POSTGRESDB_SCHEMA \
    -e DB_POSTGRESDB_PASSWORD \
    -e N8N_DATA_FOLDER=/data/db \
    -v /data/db:/root/.n8n \
    -v $(pwd)/exports:/backup \
    -u node \
    n8nio/n8n n8n export:workflow --backup --output=/backup/$EXPORT_DIR/
 
