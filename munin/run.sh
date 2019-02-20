#!/bin/bash

# timezone settings
TZ=${TZ:="America/New_York"}
echo $TZ > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# change cron setting for updates
CRONDELAY=${CRONDELAY:=5}
sed -i "s/\*\/5/\*\/$CRONDELAY/g" /etc/cron.d/munin

# configure default node name
THISNODENAME=${THISNODENAME:="munin"}
sed -i "s/^\[localhost\.localdomain\]/\[$THISNODENAME\]/g" /etc/munin/munin.conf

# generate node list
NODES=${NODES:-}
for NODE in $NODES
do
    NAME=`echo $NODE | cut -d ':' -f1`
    HOST=`echo $NODE | cut -d ':' -f2`
    grep -q $HOST /etc/munin/munin.conf || cat << EOF >> /etc/munin/munin.conf
[$NAME]
    address $HOST
    use_node_name yes

EOF
done

# placeholder html to prevent permission error
if [ ! -f /var/cache/munin/www/index.html ]; then
    cat << EOF > /var/cache/munin/www/index.html
<html>
  <head>
    <title>Munin</title>
  </head>
  <body>
    Munin has not run yet.  Please try again in a few moments.
  </body>
</html>
EOF
    chown -R munin: /var/cache/munin/www/index.html
fi

# start cron
/usr/sbin/cron &

# start local munin-node
/usr/sbin/munin-node > /dev/null 2>&1 &

# confirm nodes
echo "Using the following munin nodes:"
echo " $THISNODENAME"
echo " $NODES"

# Link installed plugins
for file in `ls /usr/share/munin/plugins/ | grep -v "_$"`
do
    ln -sf /usr/share/munin/plugins/${file} /etc/munin/plugins/${file}
done

# start apache
/usr/sbin/apache2ctl start

# display logs
touch /var/log/munin/munin-update.log
tail -f /var/log/munin/munin-*.log
