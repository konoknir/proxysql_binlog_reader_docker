FROM centos:7

ARG MYSQL_VERSION="5.7.27"

RUN yum update -y \
	&& yum install -y boost-system https://dev.mysql.com/get/mysql80-community-release-el7-2.noarch.rpm \
	&& yum --disablerepo=mysql80-community --enablerepo=mysql57-community install -y \
		"mysql-community-libs-compat-$MYSQL_VERSION-1.el7" \
		"mysql-community-common-$MYSQL_VERSION-1.el7" \
		"mysql-community-libs-$MYSQL_VERSION-1.el7" \
	&& yum clean all && rm -rf /var/cache/yum

COPY ./proxysql_binlog_reader /bin/proxysql_binlog_reader

CMD /bin/proxysql_binlog_reader \
  -h "${MYSQL_HOST:-127.0.0.1}" \
  -u "${MYSQL_USER}" \
  -p "${MYSQL_PASSWORD}" \
  -P "${MYSQL_PORT:-3306}" \
  -i "${LISTEN_ADDR:-0.0.0.0}" \
  -l "${LISTEN_PORT:-999}" \
  -f

EXPOSE $LISTEN_PORT