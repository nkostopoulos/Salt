debconf-utils:
  pkg.installed

# requirement to run commands
python-mysqldb:
  pkg.installed

# Install mysql server and client
mysql-server:
  pkg.installed

mysql-client:
  pkg.installed

# Enable and restart mysql service
mysql:
  service.running:
    - enable: True
    - reload: True

# Run mysql_secure_installation and disable socket authentication
query1:
  mysql_query.run:
    - database: mysql
    - query: "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost','127.0.0.1','::1');"

query2:
  mysql_query.run:
    - database: mysql
    - query: "DELETE FROM mysql.user WHERE User='';"

query3:
  mysql_query.run:
    - database: mysql
    - query: "DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';"

query4:
  mysql_query.run:
    - database: mysql
    - query: "DROP DATABASE IF EXISTS test;"

query5:
  mysql_query.run:
    - database: mysql
    - query: "UPDATE mysql.user SET plugin=null WHERE user='root';"

query6:
  mysql_query.run:
    - database: mysql
    - query: "FLUSH PRIVILEGES;"

query7:
  mysql_query.run:
    - database: mysql
    - query: "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('XXXX');"


