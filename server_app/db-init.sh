#!/bin/bash
echo "### Creating DB structure ..."
docker exec -it feedr_app_server-app_1 pub run aqueduct db upgrade --connect postgres://feedr_user:abc807@postgres_database_feedr:5432/feedr_db