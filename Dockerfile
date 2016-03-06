FROM centos:6
MAINTAINER Jasper Spaans <j@jasper.es>
ENV TERM linux

ADD soltra.repo /etc/yum.repos.d
RUN yum -y update
RUN yum -y install soltra-edge
RUN /opt/soltra/edge/bin/pip install supervisor==3.2.2
RUN mkdir -p /etc/supervisord.d
ADD etc/supervisord.conf /etc
ADD etc/supervisord.d /etc/supervisord.d

# fix mongo config
RUN sed -i "s/fork: true/fork: false/" /opt/soltra/edge/etc/mongod.conf

EXPOSE 80
CMD ["/opt/soltra/edge/bin/supervisord", "-c", "/etc/supervisord.conf"]


