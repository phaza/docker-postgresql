# PostgreSQL

FROM phaza/docker-base
MAINTAINER Peter Haza <peter.haza@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update
RUN apt-get -yqq upgrade
RUN apt-get -yqq install wget ca-certificates
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet --no-check-certificate -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get -qq update
RUN apt-get -yqq install postgresql-9.3 postgresql-contrib-9.3 postgresql-9.3-postgis-2.1 \
  && echo "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" | su postgres -c psql \
  && su postgres -c "createdb -O docker docker"

ADD supervisor.conf /etc/supervisor/conf.d/postgresql.conf
ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf
ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf

VOLUME ["/var/lib/postgresql"]
EXPOSE 5432

CMD ["/usr/bin/supervisord"]
