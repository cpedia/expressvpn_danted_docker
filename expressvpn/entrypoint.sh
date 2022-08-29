#!/usr/bin/bash

cp /etc/resolv.conf /tmp/resolv.conf
su -c 'umount /etc/resolv.conf'
cp /tmp/resolv.conf /etc/resolv.conf
sed -i 's/DAEMON_ARGS=.*/DAEMON_ARGS=""/' /etc/init.d/expressvpn
service expressvpn restart
/usr/bin/expect /tmp/expressvpnActivate.sh
expressvpn preferences set auto_connect true
expressvpn preferences set network_lock off
expressvpn preferences set preferred_protocol $PREFERRED_PROTOCOL
expressvpn preferences set lightway_cipher $LIGHTWAY_CIPHER
expressvpn connect $SERVER

# Add a route for local network to use the proxy
gw=$(ip route | awk '/default/ {print $3}')
ip route add ${LOCAL_NETWORK} via $gw dev eth0

# chmod +x /etc/init.d/danted
# update-rc.d danted defaults
# service danted restart
service shadowsocks-libev restart

exec "$@"
