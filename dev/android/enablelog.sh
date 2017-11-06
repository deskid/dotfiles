#!/bin/sh
# for huawei device, enable logcat 
adb shell "su -c 'chmod 777 /dev/hwlog_switch; echo 1 > dev/hwlog_switch;'"
