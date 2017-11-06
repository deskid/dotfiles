## dev

### android

#### `asUpdate.sh`

    1. adjust `studio.vmoptions`
    2. add gradle to shell path
    3. remove default File Header

#### `awifi.sh`

    cat android wifi pwd (root needed)

#### `enablelog.sh`

    enable locat on huawei device (root needed)

## tools

### zshrc

    1. Android dev path
    2. JDK path (`/usr/libexec/java_home`)
    3. dotfiles libs path
    4. alias

#### adb

| alias | commond |  desc |
| --- | --- |  --- |
| `adbstart` | `adb shell am start -n "$1"` | start activity |
| `adbpackage` | `adb shell pm list package | grep $1 |sort| head -1| tr -d '\r'| sed 's/package://g'`  |  search app package name |
| `adbapkpath` | `adb shell pm path "${PACKAGE_PATH}"| tr -d '\r'| sed 's/package://g'`  | locate apk path |
| `logcate` | `noglob adb logcat -d -v time AndroidRuntime:E *:S` |  check crash log |
| `showtask` | `adb shell dumpsys activity activities | sed -En -e '\''/Stack #/p'\'' -e '\''/Running activities/,/Run #0/p'\` | check top activity stack |

#### gradle

| alias | commond | desc |
| --- | --- | --- |
| `gbuild` | `./gradlew clean && ./gradlew assembleDebug && ./gradlew installDebug` | build and install |
| `gdeps` | `./gradlew -q $1:dependencies` | check gradle dependencies tree |



#### tools

| alias | commond | desc |
| --- | --- |  --- |
| `proxyoff` | `export http_proxy='';export https_proxy=''` |  turn off proxy |
| `proxyon` | `export http_proxy='http://127.0.0.1:1087';export https_proxy='http://127.0.0.1:1087'` |  turn on proxy |
| `shttp` | `python -m SimpleHTTPServer 8000` |  turn on file http server listen on 8000 |
| `zshconfig` | `vim ~/.zshrc` | edit zsh config |
| `zshreload` | `source ~/.zshrc` |  reload zsh config |


#### git

| alias | commond | desc |
| --- | --- |  --- |
| `gcfix` | `git commit -a --fixup=HEAD` | fixup |
| `ggpushf` | `git push -f origin $(git_current_branch)` | push force |

`zsh git alias` are not listed.

### kcptun

    1. `kcp.sh` config local kcptun and run
    2. `updatekcp.sh` update local kcptun to the latest version

## working

### daily

    `daily.py` auto  create daily report file based on Template

### log

    `glog` generate change log file based on git commit msg
