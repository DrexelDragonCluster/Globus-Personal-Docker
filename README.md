# Globus-Personal-Docker

This repository contains a Dockerfile for building a Docker image that can be used to run a personal Globus Connect Server. The image is based on the [globus/globus-connect-server](https://hub.docker.com/r/globus/globus-connect-server) image, and adds a script that can be used to configure the server with a personal endpoint.

## Building the container

To build the container, run the following command:

```bash
docker build -t globus .
```

## Running the container

You need to start by running the container and doing the initial configuration. The following command will start the container and mount the necessary volumes:

```bash
DataPath=/home/ferroelectric/Globus-Personal-Docker-2/data
ConfigPath=/home/ferroelectric/Globus-Personal-Docker-2/config
docker run -e DataPath=$DataPath \
           -e ConfigPath=$ConfigPath \
           -v "$ConfigPath":/home/gridftp/globus_config \
           -v "$DataPath":/home/gridftp/data \
           -it globus
```

## Once the Setup is complete the endpoint can be started using the following command:

```bash
docker run -e DataPath="$DataPath"  \
           -e ConfigPath="$ConfigPath" \
           -e START_GLOBUS="true" \
           -v "$ConfigPath":/home/gridftp/globus_config \
           -v "$DataPath":/home/gridftp/data \
           -- entrypoint /bin/bash \
           -it globus
```
