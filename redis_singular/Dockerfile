FROM redis:3.2
LABEL maintainer garylai <garylaiph@gmail.com>

COPY redis.conf /user/local/etc/redis/redis.conf

ENTRYPOINT ["redis-server"]

CMD ["/user/local/etc/redis/redis.conf"]
