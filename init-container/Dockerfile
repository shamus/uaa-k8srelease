FROM ubuntu:xenial
COPY build_keystore.sh /var/run/scripts/
COPY build_truststore.sh /var/run/scripts/
RUN apt-get update && apt-get install -y ca-certificates default-jdk
RUN update-ca-certificates
