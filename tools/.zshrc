export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

export UPDATE_ZSH_DAYS=1

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git osx autojump)


# Android dev
export PATH=${PATH}:$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/platform-tools
export PATH=${PATH}:$HOME/Library/Android/sdk/build-tools/24.0.2
export ANDROID_NDK_ROOT=$HOME/Library/Android/sdk/ndk-bundle
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_NDK_ROOT
export ANDROID_HVPROTO=ddm

# JDK
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_91.jdk/Contents/Home
export PATH=${PATH}:${JAVA_HOME}/bin

# User tools
export PATH=${PATH}:$HOME/libs
export PATH=${PATH}:/usr/local/bin

# homebrew mirror
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

# Ruby dev
export RBENV_ROOT=/usr/local/var/rbenv

source $ZSH/oh-my-zsh.sh

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"

export EDITOR='vim'

# color man page
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline


# For a full list of active aliases, run `alias`.
# zsh
alias zshconfig="vim ~/.zshrc"
alias zshreload="source $HOME/.zshrc"

# http://{yourIP}:8000
alias shttp="python -m SimpleHTTPServer 8000"

# gradle task
alias gupload="./gradlew uploadArchive"
alias gbuild="./gradlew clean && ./gradlew assembleDebug && ./gradlew installDebug"
alias gstop="./gradlew --stop"

# gdeps {module_name}
function gdeps(){
	./gradlew -q $1:dependencies
}

# adb shell
alias logcate="noglob adb logcat AndroidRuntime:E *:S"
alias showtask="adb shell dumpsys activity activities | sed -En -e '/Stack #/p' -e '/Running activities/,/Run #0/p'"

function adbpackage(){
	adb shell pm list package | grep $1 |sort| head -1| tr -d '\r'| sed 's/package://g'
}

function adbapkpath(){
	PACKAGE_PATH=$(adbpackage $1)
	adb shell pm path "${PACKAGE_PATH}"| tr -d '\r'| sed 's/package://g'
}

function adbstart(){
	adb shell am start -n "$1"
}

# system

alias proxyon="export http_proxy='http://127.0.0.1:1087';export https_proxy='http://127.0.0.1:1087'"
alias proxyoff="export http_proxy='';export https_proxy=''"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
