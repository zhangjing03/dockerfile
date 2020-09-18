FROM harbor.ccsyun.club/m8cloud/m8-centos:centos7.20171229
RUN cp ./run /opt
WORKDIR /opt/app-root/src
EXPOSE 8080