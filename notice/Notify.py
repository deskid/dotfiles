#!/usr/bin/python
# -*- coding: utf-8 -*-
import sys
import subprocess

def notify(title,info_text):
	title = title.replace('"', '\'')
	info_text = info_text.replace('"', '\'')
	cmd = """osascript -e 'display notification  "%s"  with title "%s" sound name "Funk.aiff"'""" % (info_text,title)
	subprocess.call(cmd, shell=True)
