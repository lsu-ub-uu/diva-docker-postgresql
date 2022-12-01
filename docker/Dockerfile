ARG POSTGRESQL_DOCKER_VERSION
FROM cora-docker-postgresql:${POSTGRESQL_DOCKER_VERSION}

USER root

COPY dbfiles/ dbfiles/
COPY initdb/*.sh docker-entrypoint-initdb.d/

RUN chmod +rx docker-entrypoint-initdb.d/*.sh && chown -R postgres: dbfiles