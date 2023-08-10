### Database design

We are using postgresql for database.

Database diagram: https://dbdiagram.io/d/646dc334dca9fb07c4aa4537

#### Migration Creation

```shell
# IGNORE IF ALREADY CREATED; Creating a database
docker-compose exec postgres psql -U postgres -w postgres -c 'create database geopanap;'

# Create a new migration file
touch database/migrations/<ORDINAL_NUMBER>_ACTION_TABLE.up.sql

# Applying migration
# building docker file
DOCKER_BUILDKIT=1 docker build -t migrate .

# applying migrations
docker run --net=host \
-e POSTGRES_HOST=localhost \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD=postgres \
-e POSTGRES_DB=geopanap \
migrate up -config=./dbconfig.yaml -env=production
```


