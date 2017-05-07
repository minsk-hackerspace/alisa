echo --- setup PHP ---
cp etc/php.ini /etc/php/7.0/apache2/php.ini
# see changes, it should be
#  * turn off (and not notices, deprecated and strict warnings
#error_reporting = E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED
#display_errors = On
#  * post data > 8M, upload > 2M
#post_max_size = 50M
#upload_max_filesize = 50M
diff -u etc/php.ini-production etc/php.ini

echo --- restarting Apache2 ---
sudo service apache2 restart
