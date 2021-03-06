#####################################################################
# Dockerfile that builds a FoF Gameserver - modified from CS Scrim  #
#####################################################################
FROM cm2network/steamcmd:root

ENV STEAMAPPID 295230
ENV STEAMAPP fof
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

COPY entry.sh ${HOMEDIR}/entry.sh
RUN set -x \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
		echo 'login anonymous'; \
		echo 'force_install_dir '"${STEAMAPPDIR}"''; \
		echo 'app_update '"${STEAMAPPID}"''; \
		echo 'quit'; \
	   } > "${HOMEDIR}/${STEAMAPP}_update.txt" \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" "${HOMEDIR}/${STEAMAPP}_update.txt" \
	&& rm -rf /var/lib/apt/lists/* 
	
ENV SRCDS_PORT=27015
ENV SRCDS_TOKEN=0

USER ${USER}

VOLUME ${STEAMAPPDIR}

WORKDIR ${HOMEDIR}

EXPOSE ${SRCDS_PORT}/udp ${SRCDS_PORT}/tcp

CMD ["bash", "entry.sh"]