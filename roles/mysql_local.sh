# Local MySQL role enables TCP connections from root@localhost
# (by default root@localhost connects over local socket)

echo "--- applying role mysql_local ---"

DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server
mysql << EOF
UPDATE mysql.user SET plugin='mysql_native_password' WHERE user='root' AND host ='localhost';
FLUSH PRIVILEGES;
EOF
