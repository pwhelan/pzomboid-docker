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

with open(os.environ.get("DATA") + "/Server/servertest.ini", "r") as fd:
	for line in fd.readlines():
		(key,val) = line[:-1].split("=")
		settings[key] = val

for (key,val) in os.environ.items():
	parts = key.split('_')
	if len(parts) < 2 or not parts[0] == "PZ":
		continue
	cckey = to_camel_case("_".join(parts[1:]).lower())
	value = val

	settings[cckey] = val

with open(os.environ.get("DATA") + "/Server/servertest.ini", "w+") as fd:
	for (key, val) in settings.items():
		fd.write(key + "=" + val + "\n")
