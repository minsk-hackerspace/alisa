echo --- checkout sources into /var/www ---
rm -rf /var/www/html/*
rm -rf /var/www/html/.git
git clone --depth=1 https://github.com/sergejey/majordomo.git /var/www/html

echo --- creating config.php ---
cd /var/www/html/
cp config.php.sample config.php
