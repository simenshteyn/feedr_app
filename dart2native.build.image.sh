#!/bin/bash
echo "### Creating dart2native docker image ..."
docker build --pull --rm -f "dart2native/Dockerfile" -t aqueduct_builder:4.0.0-b1 "dart2native"