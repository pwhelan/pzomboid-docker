#!/bin/bash
# 
# references:
#   * https://pzwiki.net/wiki/Startup_parameters

if [ -d "$APP" ] && [ ! -w "$APP" ]; then
	echo "[!!] Unable to install Project Zomboid to \$APP=${APP}"
	exit 1
fi

if [ ! -d "$DATA" ] || [ ! -w "$DATA" ]; then
	echo "[!!] Unable to write to data directory for Project Zomboid to \$DATA=${DATA}"
	exit 1
fi

if [ -f "$APP/start-server.sh" ]; then
	echo -n "Upgrade server? [N/y]: "
	read -r -t 5 resp
fi

if [ "$resp" == "Y" ] || [ "$resp" == "y" ] || [ ! -f "$APP/start-server.sh" ]; then
	./steamcmd.sh \
		+force_install_dir "$APP" \
		+login anonymous \
		+app_update 380870 validate \
		+quit
fi

if [ ! -f "${DATA}/Server/servertest.ini" ]; then
	echo quit | "$APP/start-server.sh" \
		-cachedir="$DATA" \
		-adminpassword "$ADMIN_PASSWORD"
fi

python3 /ini.py

"$APP/start-server.sh" \
	-cachedir="$DATA" \
	-adminpassword "$ADMIN_PASSWORD"
