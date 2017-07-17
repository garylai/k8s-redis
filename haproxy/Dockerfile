FROM haproxy:1.7
LABEL maintainer garylai <garylaiph@gmail.com>
    
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY entrypoint.sh ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
