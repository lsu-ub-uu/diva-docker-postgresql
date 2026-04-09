ARG POSTGRESQL_DOCKER_VERSION
FROM cora-docker-postgresql:${POSTGRESQL_DOCKER_VERSION}

USER root

COPY dbfiles/ dbfiles/

RUN chown -R postgres: dbfiles