#!/bin/bash
set -e

haproxy_host=$(host -t srv redis-haproxy-stats | awk '{print $1}')
cmd="$1"
description="$2"
role=$(echo $description | awk '{print $1}')

call_curl () {
    echo in call_curl
    scope=$1
    addr=$2
    action=$3    
    host_name=$(curl -s "http://$haproxy_host:8080/;csv?scope=$scope" | \
                       grep $addr | \
                       awk -F, '{print $2}')

    echo $scope $haproxy_host $host_name
    
    curl -s "http://$haproxy_host:8080/?scope=$scope" -o /dev/null \
         --data "s=$host_name&action=$action&b=%234"
    
	return 0
}


[ "$cmd" = "+odown" ] && [ "$role" = "master" ] && \
	call_curl $(echo $description | awk '{print $2}')  $(echo $description | awk '{print $3":"$4}') 'disable'

[ "$cmd" = "+sdown" ] && [ "$role" = "slave" ] && \
    call_curl $(echo $description | awk '{print $6}')  $(echo $description | awk '{print $3":"$4}') 'disable'

[ "$cmd" = "+switch-master" ] && \
    call_curl $(echo $description | awk '{print $1}')  $(echo $description | awk '{print $4":"$5}') 'enable' &&
    call_curl $(echo $description | awk '{print $1}')  $(echo $description | awk '{print $2":"$3}') 'disable'

[ "$cmd" = "-odown" ] && [ "$role" = "master" ] && \
    call_curl $(echo $description | awk '{print $2}')  $(echo $description | awk '{print $3":"$4}') 'enable'

exit 0
