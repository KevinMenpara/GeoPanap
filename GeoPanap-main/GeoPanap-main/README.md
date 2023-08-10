### GeoPanap Portal

### Installation
1. Make sure have docker, and docker-compose has install on your machine.
2. Rename `example.env` to `.env`.
```shell
mv example.env .env
```
3. Start the application
```shell
docker-compose up
```
4. Above mentioned step start the tooljet service in [http://localhost:8082](http://localhost:8082) port.

    5. Create a database for geopanap.
```shell
docker-compose exec postgres psql -U postgres -w postgres -c 'create database geopanap;'
```

6. Create the schema migration using below command, and inside write the query for database table.
```shell
touch database/migrations/<ORDINAL_NUMBER>_ACTION_TABLE.up.sql
```

7. Commit change and create a Pull Request.

### Workspace variables
We are using client side secret in tooljet. Make sure all environment variable have prefix `GEOPANAP_`.

1. `GEOPANAP_ENCRYPTION_KEY`: Encryption key is used for encrypt the password (00d973ed37077399cafae3cc9a951cf4efe00d7028493c65ed07a9b732966ff2).
2. `GEOPANAP_S3_BUCKET`: Where all object documents are store.

Note: In ToolJet you cannot create same environment variable in different workspace.
