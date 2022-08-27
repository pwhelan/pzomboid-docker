#!/bin/bash
# 
# references:
#   * https://pzwiki.net/wiki/Startup_parameters


if [ -f "$APP/start-server.sh" ]; then
	echo -n "Upgrade server? [N/y]: "
	read -r resp
fi

if [ "$resp" == "Y" ] || [ "$resp" == "y" ] || [ ! -f "$APP/start-server.sh" ]; then
	./steamcmd.sh \
		+force_install_dir "$APP" \
		+login anonymous \
		+app_update 380870 validate \
		+quit
fi

python3 /ini.py

"$APP/start-server.sh" \
	-cachedir="$DATA" \
	-adminpassword "$ADMIN_PASSWORD"
