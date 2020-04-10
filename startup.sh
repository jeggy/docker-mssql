#!/usr/bin/env bash

# Launch MSSQL and send to background
/opt/mssql/bin/sqlservr &

# Wait for it to be available
echo "Waiting for MS SQL to be available ⏳"
/opt/mssql-tools/bin/sqlcmd -l 30 -S localhost -h-1 -V1 -U sa -P ${SA_PASSWORD} -Q "SET NOCOUNT ON SELECT \"YAY WE ARE UP\" , @@servername"
is_up=$?

while [[ ${is_up} -ne 0 ]] ; do
  echo -e $(date)
  /opt/mssql-tools/bin/sqlcmd -l 30 -S localhost -h-1 -V1 -U sa -P ${SA_PASSWORD} -Q "SET NOCOUNT ON SELECT \"YAY WE ARE UP\" , @@servername"
  is_up=$$?
  sleep 5
done

mkdir -p /scripts

# Run any custom defined SQL
echo ${ON_START_SQL} > /scripts/00_custom_on_boot.sql

# Sleep 5 seconds just for safety #https://github.com/Microsoft/mssql-docker/issues/344
sleep 5

# Execute each sql file
for sql in /scripts/*.sql
  do /opt/mssql-tools/bin/sqlcmd -U sa -P ${SA_PASSWORD} -l 30 -e -i ${sql}
done


# So that the container doesn't shut down, sleep this thread
sleep infinity
