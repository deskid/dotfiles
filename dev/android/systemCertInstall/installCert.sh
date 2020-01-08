adb root
adb remount
adb push ac695a8a.0 /system/etc/security/cacerts/
adb shell ls -la /system/etc/security/cacerts/ac695a8a.0
