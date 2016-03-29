FROM gibby/base:centos6
MAINTAINER Chris Gibson <git@twoitguys.com>

RUN \
  yum update -y && \
  yum install -y epel-release && \
  yum install -y iproute python-setuptools hostname inotify-tools yum-utils which && \
  yum clean all && \

  easy_install supervisor

# Add supervisord conf, bootstrap.sh files
ADD container-files /

VOLUME ["/data"]

CMD ["/config/bootstrap.sh"]
