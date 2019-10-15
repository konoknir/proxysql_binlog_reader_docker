# Docker container for ProxySQL Binlog Reader

## How to BUILD binary container
> sudo docker build -t proxysql_binlog_reader_dev .

### Run container
> sudo docker run --rm -it --name proxysql-binlog-reader proxysql_binlog_reader_dev /bin/bash

### Copy files (from another shell)
> sudo docker cp proxysql-binlog-reader:/root/proxysql_mysqlbinlog/proxysql_binlog_reader ./prod/proxysql_binlog_reader

## How to RUN binary-only container
> cd prod
> sudo docker build -t proxysql_binlog_reader .

Available ENV options:
- MYSQL_USER (mandatory)
- MYSQL_PASSWORD (mandatory)
- MYSQL_HOST (default: 127.0.0.1)
- MYSQL_PORT (default: 3306)
- LISTEN_ADDR (default: 0.0.0.0)
- LISTEN_PORT (default: 999)

## Usage example

sudo docker run --rm -it --name proxysql-binlog-reader -e MYSQL_USER=root -e MYSQL_PASSWORD=123456 -e MYSQL_PORT=33064 -e LISTEN_PORT=33061 --network=host proxysql_binlog_reader
