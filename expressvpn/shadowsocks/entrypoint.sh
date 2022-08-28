#!/usr/bin/bash

service shadowsocks-libev restart
exec "$@"
