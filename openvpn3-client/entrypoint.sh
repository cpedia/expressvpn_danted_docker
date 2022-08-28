#!/usr/bin/bash

service danted restart
service openvpn3-autoload restart
exec "$@"
