FROM centos:7

RUN yum update -y 

RUN yum install -y make cmake gcc gcc-c++ epel-release git wget zlib-devel openssl-devel boost-system boost-devel https://dev.mysql.com/get/mysql80-community-release-el7-2.noarch.rpm

ARG MYSQL_VERSION="5.7.27"

RUN yum --disablerepo=mysql80-community --enablerepo=mysql57-community \
	install -y "mysql-community-libs-compat-$MYSQL_VERSION-1.el7" "mysql-community-common-$MYSQL_VERSION-1.el7" "mysql-community-libs-$MYSQL_VERSION-1.el7" "mysql-community-devel-$MYSQL_VERSION-1.el7"

RUN cd /usr/include/mysql/ \
	&& wget https://raw.githubusercontent.com/mysql/mysql-server/mysql-$(rpm -qa | grep mysql-community-devel | awk -F'-' '{print $4}')/include/hash.h

RUN cd \
	&& git clone -b listen_interface https://github.com/konoknir/proxysql_mysqlbinlog.git && cd proxysql_mysqlbinlog \
	&& cd libslave/ \
	&& 	cmake . && make \
	&& cd .. \
	&& ln -s /usr/lib64/mysql/libmysqlclient.a /usr/lib64/libmysqlclient.a \
	&& make

RUN yum clean all && \
    rm -rf /var/cache/yum

