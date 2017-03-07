#!/bin/bash

adb shell "su -c 'cat /data/misc/wifi/wpa_supplicant.conf'" | grep network -A 10