FROM zennoe/steamcmd:latest

# switch to steam user
USER steam

# Gmod port
ENV FOF_PORT=27015

ENV LD_LIBRARY_PATH=/opt/fof/bin

# add docker-entrypoint.sh and fix permissions
COPY docker-entrypoint.sh /usr/local/bin/
USER root
RUN chmod 777 /usr/local/bin/docker-entrypoint.sh && \
    mkdir /opt/fof
USER steam


VOLUME /opt/fof
EXPOSE ${FOF_PORT}/udp ${FOF_PORT}/tcp

# entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["-game", "fof", "+maxplayers", "20", "+map", "fof_fistful"]
