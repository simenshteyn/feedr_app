# feedr_app

## Running the Application Locally

Run `aqueduct serve` from this directory to run the application. For running within an IDE, run `bin/main.dart`. By default, a configuration file named `config.yaml` will be used.

To generate a SwaggerUI client, run `aqueduct document client`.

## Building application on local machine

To build client and server application run:
```
docker-compose -f docker-compose.dev.build.yaml up --build
```
The default proccess is to compile executable .aot file for server and static for client. Now you can run application in local docker: 
```
docker-compose -f docker-compose.aot.yaml up -d
```
You can check client app on http://127.0.0.1:80 and backend app on http://127.0.0.1:8080/example. At first run you also need to make all migrations on database for working backend:
```
docker-compose -f docker-compose.migrations.yaml --env-file=data_db.env up
```

## Deploying an Application

