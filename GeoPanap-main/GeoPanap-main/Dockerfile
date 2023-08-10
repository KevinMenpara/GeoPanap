# syntax=docker/dockerfile:1.3-labs
FROM golang:1.20.4-alpine3.18
ARG MIGRATE_VERSION="4.16.0"

RUN apk update && \
    go install github.com/rubenv/sql-migrate/...@latest

COPY database ./

RUN cat <<EOF > ./dbconfig.yaml
production:
    dialect: postgres
    datasource: host=\${POSTGRES_HOST} dbname=\${POSTGRES_DB} user=\${POSTGRES_USER} password=\${POSTGRES_PASSWORD} sslmode=disable
    dir: migrations
EOF

ENTRYPOINT [ "sql-migrate" ]
