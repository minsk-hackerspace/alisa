echo --- checkout sources into /var/www ---
rm -rf /var/www/html/*
git clone --depth=1 https://github.com/sergejey/majordomo.git /var/www/html
