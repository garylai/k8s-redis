FROM redis:3.2
LABEL maintainer garylai <garylaiph@gmail.com>
    
COPY redis.conf /user/local/etc/redis/redis.conf
COPY sentinel.conf /user/local/etc/redis/sentinel.conf
    
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
