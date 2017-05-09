echo --- update ubuntu/debian ---
apt-get update
apt-get upgrade -y
apt-get clean

echo --- installing prerequisites ---
apt-get install -y php php-mysql


# mysql on separate node needs another role
./roles/mysql_local.sh
