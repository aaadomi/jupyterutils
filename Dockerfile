# INSTALL PYTHON IMAGE
#FROM python:3.7.7-alpine3.10
FROM python:3.7.7-slim
MAINTAINER Roland <roviol@aaa.com.do>

# INSTALL TOOLS
#RUN apk update
#RUN apk add unzip libaio-dev gcc
#RUN apk add --update python python-dev gfortran py-pip build-base
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install unzip wget libaio-dev

RUN mkdir -p /opt/data
RUN cd /opt/data

WORKDIR /opt/data

RUN wget https://docker-aaa.s3-us-west-2.amazonaws.com/instaladores/oracle/instantclient-basic-linux.x64-12.1.0.2.0.zip \
    && wget https://docker-aaa.s3-us-west-2.amazonaws.com/instaladores/oracle/instantclient-sdk-linux.x64-12.1.0.2.0.zip \
    && unzip instantclient-basic-linux.x64-12.1.0.2.0.zip -d /opt/oracle  \
    && unzip instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /opt/oracle   \
    && rm instantclient-basic-linux.x64-12.1.0.2.0.zip \
    && rm instantclient-sdk-linux.x64-12.1.0.2.0.zip \
    && mv /opt/oracle/instantclient_12_1 /opt/oracle/instantclient  \
    && ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so  \
    && ln -s /opt/oracle/instantclient/libocci.so.12.1 /opt/oracle/instantclient/libocci.so


#RUN pip install cx_Oracle
RUN pip install --upgrade pip
RUN pip install jupyter panda numpy jupyterlab matplotlib seaborn plotly plotly-svg cufflinks scikit-learn zeep requests cx_Oracle

COPY inicia.sh /opt/inicia.sh
RUN chmod u+x /opt/inicia.sh

#COPY requerimientos.txt ./requerimientos.txt
#RUN pip install --no-cache-dir -r requerimientos.txt

ENV ORACLE_HOME=/opt/oracle/instantclient
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME

ENV OCI_HOME=/opt/oracle/instantclient
ENV OCI_LIB_DIR=/opt/oracle/instantclient
ENV OCI_INCLUDE_DIR=/opt/oracle/instantclient/sdk/include
ENV JUPITER_TOKEN=aaa2020

EXPOSE 8888

ENTRYPOINT ["/opt/inicia.sh"]
