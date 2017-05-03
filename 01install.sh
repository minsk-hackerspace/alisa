echo --- update ubuntu/debian ---
apt-get update
apt-get upgrade -y
apt-get clean

echo --- installing prerequisites ---
apt-get install php -y
