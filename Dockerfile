FROM busybox
RUN yum update -y
RUN yum install ansible -y
RUN yum install git vim -y
