#!/usr/bin/env python3
# 
# *** Script to overwrite INI entries ***
#
# This scripts takes all environment variables with the PZ_
# prefix and transforms them from UPPERCASE_UNDERSCORE to
# UpperCamelCase, baring a few exceptions and overwrites
# the values in the original servertest.ini file.

import os
import sys

def to_camel_case(text):
	s = text.replace("-", " ").replace("_", " ")
	s = s.split()
	if len(text) == 0:
		return text
	return ''.join(i.capitalize() for i in s)

settings = {}

try:
	with open(os.environ.get("DATA") + "/Server/servertest.ini", "r") as fd:
		for line in fd.readlines():
			if line[0] == '#':
				next
			if not line.find("="):
				print("ERROR: bad ini line", line)
				next
			try:
				(key,val) = line[:-1].split("=")
				settings[key] = val
			except:
				print("ERROR: bad ini line=", line)
except:
	os.mkdir(os.environ.get("DATA") + "/Server")

for (key,val) in os.environ.items():
	parts = key.split('_')
	if len(parts) < 2 or not parts[0] == "PZ":
		continue
	cckey = to_camel_case("_".join(parts[1:]).lower())
	if cckey[0:4] == "Upnp":
		cckey = "UPnP" + cckey[4:]
	elif cckey == "SteamVac":
		cckey = "SteamVAC"
	elif cckey == "NightLengthModifier":
		cckey = "nightlengthmodifier"
	elif cckey[0:3] == "Pvp":
		cckey = "PVP" + cckey[3:]
	elif cckey == "RconPort":
		cckey = "RCONPort"
	elif cckey == "RconPassword":
		cckey = "RCONPassword"
	elif cckey == "Voice3d":
		cckey = "Voice3D"
	elif cckey == "ServerBrowserAnnouncedIp":
		cckey = "server_browser_announced_ip"
	elif cckey == "UseTcpForMapDownloads":
		cckey = "UseTCPForMapDownloads"
	value = val

	settings[cckey] = val

with open(os.environ.get("DATA") + "/Server/servertest.ini", "w+") as fd:
	for (key, val) in settings.items():
		fd.write(key + "=" + val + "\n")
