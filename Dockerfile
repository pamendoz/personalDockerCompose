FROM nextcloud

RUN apt update && apt install -y \
    supervisor nano \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/log/supervisord /var/run/supervisord

COPY supervisord.conf /etc/supervisor/supervisord.conf


ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord"]