# Microsoft SQL Server Docker image

This image is inspired by: https://github.com/Microsoft/mssql-docker/issues/11#issuecomment-452272205

run `docker run -it --rm jeggy/mssql`


All SQL scripts loaded in `/scripts/` will be executed on every boot.


Example docker-compose file: 
```yaml
version: '3.6'

services:
  mssql:
    image: jeggy/mssql
    volumes:
      - mssql_data:/var/opt/mssql
      - ./sqls:/scripts/  # Will execute all SQL scripts within this directory
    environment:
      ACCEPT_EULA: Y
      SA_PASSWORD: LongPassword@Developer
      ON_START_SQL: 'CREATE DATABASE CUSTOM_DB;' # Will execute this upon every boot
    ports:
      - 4444:1433

volumes:
  mssql_data:
```


