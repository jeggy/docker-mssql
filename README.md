# Microsoft SQL Server Docker image

This image is inspired by: https://github.com/Microsoft/mssql-docker/issues/11#issuecomment-452272205

run `docker run -it --rm jeggy/mssql`


All SQL scripts loaded in `/scripts/` will be executed on every boot.


Example docker-compose file: 
```yaml
version: '3.6'

services:
  mssql:
    image: registry.gitlab.com/apurebase/docker/mssql
    volumes:
      - mssql_data:/var/opt/mssql
      - ./sqls:/scripts/
    environment:
      ACCEPT_EULA: Y
      SA_PASSWORD: LongPassword@Developer
      ON_START_SQL: 'CREATE DATABASE CUSTOM_DB;'
    ports:
      - 4444:1433

volumes:
  mssql_data:
```


