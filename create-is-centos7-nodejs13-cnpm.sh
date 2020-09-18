
set -e

BASE_DIR=`pwd`
TMP_DIR_BASE=ttt
TMP_DIR=$BASE_DIR/$TMP_DIR_BASE/m8tmp
mkdir -p $TMP_DIR 

cp install-*.sh $TMP_DIR
cp run $TMP_DIR
cp assemble $TMP_DIR
cp fix-permissions $TMP_DIR
cp node-v13.3.0-linux-x64.tar.gz $TMP_DIR

cat > Dockerfile <<EOF
FROM harbor.ccsyun.club/m8cloud/m8-centos:centos7.20171229
ENV STI_SCRIPTS_PATH=/usr/libexec/s2i STI_SCRIPTS_URL=image:///usr/libexec/s2i 
ENV APP_ROOT=/opt/app-root HOME=/opt/app-root/src
ENV NPM_RUN=start NPM_CONFIG_PREFIX=/opt/app-root/src/.npm-global
ENV NPM_BASE=/opt/node-v13.3.0 PACKAGE_COMMAND="cnpm run build && rm -fr node_modules"
ENV PATH /opt/node-v13.3.0/bin:/opt/app-root/src/.npm-global/bin:$PATH
COPY $TMP_DIR_BASE /tmp/
RUN /bin/sh /tmp/m8tmp/install-root.sh
WORKDIR /opt/app-root/src
USER 1001
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
EXPOSE 8080
LABEL "build-date"=`date "+%Y%m%d"` "name"="m8-is-centos7-nodejs13-cnpm" "vendor"="ccssoft"
LABEL "io.k8s.display-name"="Node.js 13" "io.openshift.s2i.scripts-url"="image:///usr/libexec/s2i" "io.s2i.scripts-url"="image:///usr/libexec/s2i"
EOF

docker build --no-cache -t harbor.ccsyun.club/m8cloud/m8-src-builder-nodejs8-cnpm .
rm -fr $TMP_DIR_BASE
rm -f ./Dockerfile


