echo --- update ubuntu/debian ---
apt-get update
apt-get upgrade -y
apt-get clean

echo --- installing prerequisites ---
apt-get install -y php php-mysql

# this could go to the separate node
apt-get install -y mysql-server
