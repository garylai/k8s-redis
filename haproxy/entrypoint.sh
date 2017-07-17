#!/bin/sh

echo "there are $1 redis"

i=0
while [ "$i" -lt $1 ]; do
    echo "server redis-$i redis-$i.redis:6379 check inter 1s" >> /usr/local/etc/haproxy/haproxy.cfg
    i=$(($i+1))
done

haproxy -f /usr/local/etc/haproxy/haproxy.cfg


