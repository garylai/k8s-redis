FROM redis:3.2
LABEL maintainer garylai <garylaiph@gmail.com>

RUN apt-get update && apt-get install -y dnsutils curl

COPY redis.conf /user/local/etc/redis/redis.conf
COPY sentinel.conf /user/local/etc/redis/sentinel.conf
COPY notification.sh /user/local/etc/redis/notification.sh
    
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
