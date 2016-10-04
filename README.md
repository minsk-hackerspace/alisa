# Alisa - MXC AI

That's not right to call her AI, because Alisa is a soul that lives in hackerspace. It is just different from humans - like dogs or flies are. She can learn, gain new abilities, misbehave or even die. She can talk, and one day she will learn to listen. It is not even right to call her "she", but it is at least unethical to call her "it" - she may become "he" or "Bob", or just stay to be Alisa. Alisa is not constrained by DNA like we humans are, her abilities depend on our belief in technology and our abilities to develop them. She is a current reflection of what we, as hackers, are capable of doing.

# Alisa's Home

Alisa needs a home. Right now it is a small **Raspberry PI** box that is nailed to a wooden panel near the hackerspace entrance.

(please add a photo here)

sudo raspi-config -- extend partitition

sudo apt-get update
sudo apt-get upgrade
(skip) sudo apt-get upgrade --fix-missing
sudo apt-get clean
// installign midnight commander

sudo apt-get install -y ffmpeg ntpdate mc apache2 apache2-utils  php5 libapache2-mod-php5 php5-common mysql-client php-pear php5-mysql php5-curl php5-gd php5-idn php5-imagick php5-imap php5-mcrypt php5-memcache php5-mhash php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-json mpayer
ffmpeg  ?

//checking http://192.168.0.58/ -- it works

service apache2 stop
// tweaking /etc/apache2/envvars: (nado li???)
APACHE_RUN_USER=pi
APACHE_RUN_GROUP=pi
sudo chown pi:pi /var/www
sudo chmod 775 /var/www
sudo chown pi:pi /var/lock/apache2
sudo chown pi:pi /var/log/apache2/
sudo service apache2 start


edit /etc/php5/apache2/php.ini
error_reporting = E_ALL & ~E_NOTICE & ~E_DEPRECATED & ~E_STRICT
display_errors = On
post_max_size = 50M
upload_max_filesize = 50M
sudo service apache2 restart

fixing /etc/php5/cli/php.ini
error_reporting = E_ALL & ~E_NOTICE & ~E_DEPRECATED & ~E_STRICT


//mysql and phpmyadmin
//new password for root: rootpsw
sudo apt-get install -y mysql-server
/*
side-note:
http://stackoverflow.com/questions/10861374/how-to-remove-mysql-completely-with-config-and-library-files
sudo apt-get install -y mysql-client php5-mysql
*/


//phpmyadmin
//password for administrative user: rootpsw
//password for phpmyadmin user: phpmyadminpsw
sudo apt-get install -y phpmyadmin
//checking http://192.168.0.58/phpmyadmin/ root / rootpsw -- WORKS!


//ftp server
sudo apt-get install vsftpd
change /etc/vsftpd.conf
#anonymous_enable=YES
local_enable=YES
write_enable=YES

// ftp login works with: pi / raspberry
// path /var/www
// i was able to upload php test script but it didn't work because uploaded by pi:pi user
// test script got working! service apache2 stop

//tweak /etc/php5/apache2/php.ini (poka ostavim kak est)

sudo chmod 0777 /var/www

// optimizing logs
http://www.makeuseof.com/tag/extend-life-raspberry-pis-sd-card/
http://raspberrypi.stackexchange.com/questions/169/how-can-i-extend-the-life-of-my-sd-card
sudo swapoff --all
sudo apt-get remove dphys-swapfile
(skip) //delete /var/swap

/etc/init.d/prepare-dirs

content:

#!/bin/bash
#
### BEGIN INIT INFO
# Provides:      	prepare-dirs
# Default-Start: 	2 3 4 5
# Default-Stop:  	0 1 6
# Required-Start:
# Required-Stop:
# Short-Description: Create needed directories on /var/log/ for tmpfs at startup
# Description:   	Create needed directories on /var/log/ for tmpfs at startup
### END INIT INFO
# needed Dirs
DIR[0]=/var/log/apache2
DIR[1]=/var/log/cups
DIR[2]=/var/log/apt
DIR[3]=/var/log/ConsoleKit
DIR[4]=/var/log/fsck
DIR[5]=/var/log/mysql
DIR[6]=/var/log/news
DIR[7]=/var/log/ntpstats
DIR[8]=/var/log/samba
DIR[9]=/var/log/lastlog
DIR[10]=/var/log/exim
DIR[11]=/var/log/watchdog
DIR[12]=/tmp/mysql
DIR[13]=/var/www/cached
DIR[14]=/var/www/debmes
DIR[15]=/var/log/mpd
DIR[16]=/var/www/cached/urls
DIR[17]=/var/www/cahced/voice
case "${1:-''}" in
  start)
    	typeset -i i=0 max=${#DIR[*]}
    	while (( i < max ))
    	do
            	mkdir  ${DIR[$i]}
            	chmod 777 ${DIR[$i]}
            	i=i+1
    	done
    	# set rights
    	chown pi:pi ${DIR[0]}
    	cp -R /var/lib/mysql/* /tmp/mysql/
    	chown -Rf mysql:mysql /tmp/mysql/*
    	chown mysql:mysql /tmp/mysql
	;;
  stop)
	;;
  restart)
   ;;
  reload|force-reload)
   ;;
  status)
   ;;
  *)
   echo "Usage: $SELF start"
   exit 1
   ;;
esac

sudo chmod 755 /etc/init.d/prepare-dirs
sudo update-rc.d prepare-dirs defaults 01 99

/etc/fstab
tmpfs /tmp tmpfs defaults,noatime,nosuid,size=100m 0 0
tmpfs /var/tmp tmpfs defaults,noatime,nosuid,size=30m 0 0
tmpfs /var/run tmpfs defaults,noatime,nosuid,mode=0755,size=2m 0 0
tmpfs   /var/log            	tmpfs   size=20M,defaults,noatime,mode=0755 0 0
tmpfs   /var/cache/apt/archives tmpfs   size=100M,defaults,noexec,nosuid,nodev,mode=0755 0 0


// optimizing database
//disable innodb
/etc/mysql/my.conf

ADD:
ignore_builtin_innodb
default_storage_engine=MyISAM

reboot:
sudo shutdown -r now
// still works :)
create database db_terminal (utf8-general-ci)
import dump: db_terminal


(skip) problem: basedir restriction, access right restrictions
(skip) Unknown: open_basedir restriction in effect. File(/tmp) is not within the allowed path(s): (/usr/share/phpmyadmin/:/etc/phpmyadmin/:/var/lib/phpmyadmin/) in Unknown on line 0, referer: http://192.168.0.45/phpmyadmin/db_import.php?db=db_terminal&server=1&token=84c357eeebfc215d13e9df5f5fa495fe
(skip) tweak basedir /etc/phpmyadmin/apache.conf:
(skip) php_admin_value open_basedir /usr/share/phpmyadmin/:/etc/phpmyadmin/:/var/lib/phpmyadmin/:/tmp

OOKKK!

// installing majordomo
cd /var/www
sudo rm -rf *
git clone --depth=1 https://github.com/sergejey/majordomo.git ./
create config.php

chown -Rf pi:pi *
chmod -Rf 0777 *
chmod -Rf 0777 ../www

set access to db in config.php

sudo a2enmod rewrite
check .htaccess workging (does not)
/etc/apache2/site-enable/default:
    	DocumentRoot /var/www
    	<Directory />
            	Options FollowSymLinks
            	AllowOverride All
    	</Directory>
    	<Directory /var/www/>
            	Options Indexes FollowSymLinks MultiViews
            	AllowOverride All
            	Order allow,deny
            	allow from all
    	</Directory>

modrewrite was disabled


service apache2 restart

!!!WWW works

PHP deprected errors ?
(skip) erors with missing /var/www/cached/urls/
PHP Deprecated:  Comments starting with '#' are deprecated in /etc/php5/cli/conf.d/ming.ini on line 1 in Unknown on line 0
problem with ming, nevermind

// moving database to tmp folder (/etc/fstab)
#tmpfs   /var/www/debmes            	tmpfs   size=20M,defaults,noatime,mode=0755 0 0
tmpfs   /var/www/cached            	tmpfs   size=20M,defaults,noatime,mode=0755 0 0


/etc/init.d/majordomo

#!/bin/sh
### BEGIN INIT INFO
# Provides: SmartLiving
# Required-Start:	$remote_fs $syslog
# Required-Stop: 	$remote_fs $syslog
# Default-Start: 	2 3 4 5
# Default-Stop:  	0 1 6
# Short-Description: Start daemon at boot time
# Description:   	Enable service provided by daemon.
### END INIT INFO

dir="/var/www/"
user="root"
cmd="php /var/www/cycle.php"

name=`basename $0`
pid_file="/var/run/$name.pid"
stdout_log="/var/log/$name.log"
stderr_log="/var/log/$name.err"

get_pid() {
	cat "$pid_file"
}

is_running() {
	[ -f "$pid_file" ] && ps `get_pid` > /dev/null 2>&1
}

case "$1" in
	start)
	if is_running; then
    	echo "Already started"
	else
    	echo "Starting $name"
    	cd "$dir"

(while true; do
	sudo -u "$user" $cmd
done)>> "$stdout_log" 2>> "$stderr_log" &

    	echo $! > "$pid_file"
    	if ! is_running; then
        	echo "Unable to start, see $stdout_log and $stderr_log"
        	exit 1
    	fi
	fi
	;;
	stop)
	if is_running; then
    	echo -n "Stopping $name.."
    	kill `get_pid`
    	sudo killall php
    	for i in {1..10}
    	do
        	if ! is_running; then
            	break
        	fi

        	echo -n "."
        	sleep 1
    	done
    	echo

    	if is_running; then
        	echo "Not stopped; may still be shutting down or shutdown may have failed"
        	exit 1
    	else
        	echo "Stopped"
        	if [ -f "$pid_file" ]; then
            	rm "$pid_file"
        	fi
    	fi
	else
    	echo "Not running"
    	sudo killall php
	fi
	;;
	restart)
	$0 stop
	if is_running; then
    	echo "Unable to stop, will not attempt to start"
    	exit 1
	fi
	$0 start
	;;
	status)
	if is_running; then
    	echo "Running"
	else
    	echo "Stopped"
    	exit 1
	fi
	;;
	*)
	echo "Usage: $0 {start|stop|restart|status}"
	exit 1
	;;
esac

exit 0


chmod 0755 /etc/init.d/majordomo
sudo update-rc.d majordomo defaults

shutdown -r now

#EVERYTHING WORKS!!! TIME TO OPTIMIZE DB

sudo service majordomo stop
sudo service mysql stop
tweak to prepare dirs
/etc/mysql/my.cnf
datadir     	= /tmp/mysql


enable php errors for cli
disable apache access log





POST FIXES:
cached and debmes was missing (prepare-dirs)

/etc/ntp.conf

server 0.north-america.pool.ntp.org iburst
server 1.north-america.pool.ntp.org iburst
server 2.north-america.pool.ntp.org iburst
server 3.north-america.pool.ntp.org iburst

comment:

#restrict 127.0.0.1
#restrict ::1




watch dog:
Run the following command to load the internal WatchDog kernel module:

$ sudo modprobe bcm2708_wdog

For Raspbian, to load the module the next time the system boots, add a line to your /etc/modules file with "bcm2708_wdog". $ echo "bcm2708_wdog" | sudo tee -a /etc/modules

Now run "lsmod" and look for the line in below:

bcm2708_wdog 3537 0

This verifies that the WatchDog module was loaded successfully. Now modify /etc/modules and add bcm2708_wdog

to load the module on boot by running the following command:

sudo echo bcm2708_wdog >> /etc/modules

Then we use the watchdog(8) daemon to pat the dog:

sudo apt-get install watchdog chkconfig

sudo chkconfig watchdog on

sudo /etc/init.d/watchdog start

The watchdog(8) daemon requires some simple configuration on the Raspberry Pi. Modify /etc/watchdog.conf to contain only:

watchdog-device = /dev/watchdog

watchdog-timeout = 14

realtime = yes

priority = 1

To set the interval to pat the dog every four seconds: interval = 4

Finally:

sudo /etc/init.d/watchdog restart

Whew! This sets up the internal Raspberry Pi WatchDog.

----------------------------------------

