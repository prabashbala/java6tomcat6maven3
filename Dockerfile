FROM ubuntu:16.04
EXPOSE 4403 8000 8080 9876 22

LABEL che:server:8080:ref=tomcat8 che:server:8080:protocol=http che:server:8000:ref=tomcat8-debug che:server:8000:protocol=http che:server:9876:ref=codeserver che:server:9876:protocol=http

ENV MAVEN_VERSION=3.3.9 \
    JAVA_HOME=/usr/lib/jvm/java-6-oracle \
    TOMCAT_HOME=/home/user/tomcat6 \
    TERM=xterm
ENV M2_HOME=/home/user/apache-maven-$MAVEN_VERSION
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

# Install java
RUN apt-get update
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN apt-get -y install oracle-java6-installer oracle-java6-set-default

RUN mkdir /home/user/tomcat6 /home/user/apache-maven-$MAVEN_VERSION && \
    wget -qO- "http://apache.ip-connect.vn.ua/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" | tar -zx --strip-components=1 -C /home/user/apache-maven-$MAVEN_VERSION/ && \
    wget -qO- "http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.24/bin/apache-tomcat-8.0.24.tar.gz" | tar -zx --strip-components=1 -C /home/user/tomcat6 && \
    rm -rf /home/user/tomcat6/webapps/* && \
    echo "export MAVEN_OPTS=\$JAVA_OPTS" >> /home/user/.bashrc