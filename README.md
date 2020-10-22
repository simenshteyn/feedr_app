# feedr_app

## Running the Application Locally

Run `aqueduct serve` from this directory to run the application. For running within an IDE, run `bin/main.dart`. By default, a configuration file named `config.yaml` will be used.

To generate a SwaggerUI client, run `aqueduct document client`.

## Building application on local machine

Fist time building should start with creating dart2native docker image.

Linux:
```
chmod +x dart2native.build.image.sh
./dart2native.build.image.sh
```

Windows:
```
docker build --pull --rm -f "dart2native\Dockerfile" -t aqueduct_builder:4.0.0-b1 "dart2native"
```

Then to build client and server application run:
```
docker-compose -f docker-compose.dev.build.yaml up --build
```

The default proccess is to compile executable .aot file for server and static for client. Now you can run application in local docker: 
```
docker-compose up -d
```
You can check client app on http://127.0.0.1 and backend app on http://127.0.0.1/api/example. At first run you also need to make all migrations on database for working backend:

```
docker-compose -f docker-compose.migrations.yaml --env-file=data_db.env up
```

## Deploying an Application on Working Server

```
cd ~
git clone https://github.com/simenshteyn/feedr_app.git
cd feedr_app
vi data/nging/app.conf   //setup your domain name your.site.com
chmod +x init-ssl-certbot.sh
./init-ssl-certbot.sh your.site.com //your domain name as an argument
docker-compose up -d
docker-compose -f docker-compose.migrations.yaml --env-file=data_db.env up -d
```
### Deploying at a Low Memory SSD servers
If your server is 512MB of RAM, this can cause difficulties while precompiling migrations. That's because of Out-Of-Memory issues, to prevent them the best way is to enable swap. Great article here: https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-16-04

```
sudo swapon --show
free -h
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
free -h
```

