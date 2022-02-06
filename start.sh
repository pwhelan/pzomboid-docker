#!/bin/bash
# 
# references:
#   * https://pzwiki.net/wiki/Startup_parameters

python3 /ini.py

$APP/start-server.sh \
	-cachedir=$DATA \
	-adminpassword $ADMIN_PASSWORD
