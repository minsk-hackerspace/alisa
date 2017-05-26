echo --- checkout sources into /var/www ---
rm -rf /var/www/html/*
rm -rf /var/www/html/.git
# alpha branch is the greatest
git clone --depth=1 --branch alpha https://github.com/sergejey/majordomo.git /var/www/html

echo --- creating config.php ---
cd /var/www/html/
cp config.php.sample config.php
