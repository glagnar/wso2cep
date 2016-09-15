# IoT Platform CEP

[![Twitter: @thomasbjgilbert](https://img.shields.io/badge/contact-@thomasbjgilbert-blue.svg?style=flat)](https://twitter.com/thomasbjgilbert)
[![Language: Swift](https://img.shields.io/badge/Container-Docker-red.svg)](https://docker.alexandra.dk/)
[![License: Mit](https://img.shields.io/badge/license-AGPL-lightgrey.svg?style=flat)](http://opensource.org/licenses/AGPL-3.0)

## What is IoT Platform CEP?
The Alexandra Institutes IoT Platform is a micro-service platform for the Internet of Things. The communication backbone is the [Kafka Message System](http://kafka.apache.org) which all other components use for inter-service communication. This repository is a [Complex Event Processing](https://www.quora.com/How-is-stream-processing-and-complex-event-processing-CEP-different) engine, that can be used in the context of the IoT Platform, or as a standalone component.

The image is maintained by [Thomas Gilbert](https://alexandra.dk/dk/om_os/medarbejdere/thomas-gilbert). You can reach me at [thomas.gilbert@alexandra.dk](mailto://thomas.gilbert@alexandra.dk) for help or if you have a comment about the image.

## Features
- Dockerized version of the [WSO2CEP](http://wso2.com/products/complex-event-processor/)
- For **beginners**
- Can be used for creating [ad-hoc queries](https://docs.wso2.com/display/CEP410/SiddhiQL+Guide+3.0) or deploying [C-App](https://docs.wso2.com/display/CEP420/Packaging+Artifacts+as+C-App+Archive) packages
- Supports both MQTT and Kafka
- WebUI for configuration and monitoring
- Queries can be modified on the fly - either through the UI or the filesystem.
- Supports distribution with Storm

## [Docker](https://www.docker.com)
### Build
1. Install [Docker](https://www.docker.com/products/overview)
2. In the terminal for example:
   * `docker build -t docker.alexandra.dk/wso2cep:latest -t docker.alexandra.dk/wso2cep:1.0.0 .`
   * `docker build -t glagnar/wso2cep:0.0.1 .`
3. Upload to either hub.docker.com or your own Nexus `docker push docker.alexandra.dk/wso2cep`

### Run
There are several ways to run the program:
- Mount a pre-made folder with example code
  * `docker run --rm -it -p 9443:9443 -v $PWD/src/server:/usr/src/code --name myCeP docker.alexandra.dk/wso2cep`
- Mount with individual mount points for each of the four relevant folders
  * eventpublishers
  * eventreceivers
  * eventstreams
  * executionplans
- Create your own docker image based on this one. ( See below )

### Create your own
To create your own image, containing your own queries you need to create your own [Dockerfile](https://docs.docker.com/engine/reference/builder/). Below is an example, and the source code for it is in [BitBucket](https://bitbucket.alexandra.dk/projects/SWI/repos/kortdagecep).
```bash
FROM docker.alexandra.dk/wso2cep
MAINTAINER thomas.gilbert@alexandra.dk

COPY ./src/server /usr/src/code

WORKDIR /usr/src/wso2cep/bin

CMD ["./wso2server.sh"]
```

## TODO
- Add mountpoints etc. for persistance of C-App's.

## Thanks
This could not be possible if it were'nt for the guy's behind [Siddhi](https://github.com/wso2/siddhi) and [WSO2](http://wso2.com)
