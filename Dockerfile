# inspired by cloudesire/activemq, but with jdk>7
# Use latest jboss/base-jdk:8 image as the base
FROM jboss/base-jdk:11
USER root

ENV ACTIVEMQ_VERSION 5.15.8
ENV ACTIVEMQ apache-activemq-$ACTIVEMQ_VERSION
ENV ACTIVEMQ_HOME /opt/activemq
COPY ./activemq.sh /

RUN \
    chmod +x /activemq.sh && \
#    yum check-update && \
    yum -y install -y wget && \
    wget -nv http://archive.apache.org/dist/activemq/$ACTIVEMQ_VERSION/$ACTIVEMQ-bin.tar.gz && \
#    yum clean all && \
    mkdir -p /opt && \
    tar xf $ACTIVEMQ-bin.tar.gz -C /opt/ && \
    rm -rf $ACTIVEMQ-bin.tar.gz && \
    ln -s /opt/$ACTIVEMQ $ACTIVEMQ_HOME

WORKDIR $ACTIVEMQ_HOME
EXPOSE 61616 8161

ENTRYPOINT ["/activemq.sh"]
