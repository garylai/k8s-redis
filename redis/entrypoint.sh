#!/bin/bash
set -m

export PATH=/usr/local/bin:$PATH

conf_path=/user/local/etc/redis
master_host=redis-0.redis
master_port=6379
mode=$1

echo "run on $mode mode..."

if [ $mode == 'redis' ]; then
    redis-server $conf_path/redis.conf&

    echo "wait for local redis-server to start"
    until redis-cli -h 127.0.0.1 ping; do sleep 1; done

    if [ $(hostname | cut -d'-' -s -f2) != 0 ]; then
        echo "to be the slave of $master_host:$master_port"
        redis-cli slaveof $master_host $master_port
    fi

    fg
elif [ $mode == 'sentinel' ]; then
    echo "wait for redis-server on $master_host:$master_port to start"
    until redis-cli -h  $master_host -p $master_port ping; do sleep 1; done
    echo "start sentinel"
    redis-sentinel $conf_path/sentinel.conf
fi
    
