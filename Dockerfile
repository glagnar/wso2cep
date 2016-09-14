FROM openjdk:7
MAINTAINER thomas.gilbert@alexandra.dk

WORKDIR /tmp

# Unzip and create wso2cep folder
RUN wget -nv https://github.com/wso2/product-cep/releases/download/v4.2.0-rc2/wso2cep-4.2.0-RC2.zip
RUN unzip -q wso*.zip -d /usr/src
RUN rm wso*.zip
RUN mv /usr/src/wso* /usr/src/wso2cep

# Download kafka connector: https://docs.wso2.com/display/CEP410/Supporting+Different+Transports
RUN curl -o kafka.tgz http://mirrors.dotsrc.org/apache/kafka/0.10.0.1/kafka_2.11-0.10.0.1.tgz
RUN tar xvf kafka.tgz
RUN rm kafka.tgz
RUN cp kafka*/libs/kafka_2*.jar /usr/src/wso2cep/repository/components/lib
RUN cp kafka*/libs/kafka-clients-*.jar /usr/src/wso2cep/repository/components/lib
RUN cp kafka*/libs/metrics-core-*.jar /usr/src/wso2cep/repository/components/lib
RUN cp kafka*/libs/scala-library-*.jar /usr/src/wso2cep/repository/components/lib
RUN cp kafka*/libs/scala-parser-combinators_*.jar /usr/src/wso2cep/repository/components/lib
RUN cp kafka*/libs/zkclient-*.jar /usr/src/wso2cep/repository/components/lib
RUN cp kafka*/libs/zookeeper-*.jar /usr/src/wso2cep/repository/components/lib
RUN curl -o /usr/src/wso2cep/repository/conf/security/jaas.conf https://docs.wso2.com/download/attachments/49778136/jaas.conf.txt
RUN rm -rf kafka*

# Download MQTT connector: https://docs.wso2.com/display/CEP410/Supporting+Different+Transports
RUN wget -nv -P /usr/src/wso2cep/repository/components/lib/  http://repo.spring.io/plugins-release/org/eclipse/paho/mqtt-client/0.4.0/mqtt-client-0.4.0.jar

WORKDIR /usr/src/wso2cep/bin

# Expose mount points for persistance - One way or the other
#VOLUME ["/usr/src/wso2cep/repository/deployment/server/eventpublishers",\
#        "/usr/src/wso2cep/repository/deployment/server/eventreceivers", \
#        "/usr/src/wso2cep/repository/deployment/server/eventstreams", \
#        "/usr/src/wso2cep/repository/deployment/server/executionplans"]

RUN mkdir -p /usr/src/code/eventpublishers
RUN mkdir -p /usr/src/code/eventreceivers
RUN mkdir -p /usr/src/code/eventstreams
RUN mkdir -p /usr/src/code/executionplans

RUN rm -rf /usr/src/wso2cep/repository/deployment/server/eventpublishers
RUN rm -rf /usr/src/wso2cep/repository/deployment/server/eventreceivers
RUN rm -rf /usr/src/wso2cep/repository/deployment/server/eventstreams
RUN rm -rf /usr/src/wso2cep/repository/deployment/server/executionplans

RUN ln -s /usr/src/code/eventpublishers /usr/src/wso2cep/repository/deployment/server
RUN ln -s /usr/src/code/eventreceivers /usr/src/wso2cep/repository/deployment/server
RUN ln -s /usr/src/code/eventstreams /usr/src/wso2cep/repository/deployment/server
RUN ln -s /usr/src/code/executionplans /usr/src/wso2cep/repository/deployment/server

VOLUME /usr/src/code

# Port for the webui. Login/password admin/admin
EXPOSE 9443

CMD ["./wso2server.sh"]
