FROM mcr.microsoft.com/mssql/server:2017-latest

COPY startup.sh /startup.sh

RUN chmod u+x /startup.sh

EXPOSE 1433

HEALTHCHECK --interval=10s --timeout=3s --start-period=10s --retries=10 \
    CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -Q "SELECT 1" || exit 1

CMD ["/bin/bash", "-c", "/startup.sh"]
