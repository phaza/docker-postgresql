# docker-postgresql

PostgreSQL Docker Image with the latest PostgreSQL 9.3 from apt.postgresql.org

## Usage

1. Run this image, e.g.
  `docker build -t postgresql phaza/docker-postgresql`
  `docker run -d -name postgresql postgresql`
2. Connect to it via link or with `psql`:

```
psql -h <containerip> -U docker
docker run -d -link postgresql:db <otherimage>
```
Use `docker` as username and password.
