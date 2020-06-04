#!/bin/bash

# update Gmod server
/opt/steamcmd/steamcmd.sh +login anonymous +force_install_dir /opt/fof +app_update 295230 validate +quit

# run Gmod server
exec /opt/fof/srcds_run -steamdir /opt/steamcmd -port "$FOF_PORT" "$@"
