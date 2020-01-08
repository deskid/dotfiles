export ZSH=$HOME/.oh-my-zsh
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)

export UPDATE_ZSH_DAYS=1

# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git osx autojump colorize fzf navi)


# Android dev
export PATH=${PATH}:$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/platform-tools
export PATH=${PATH}:$HOME/Library/Android/sdk/build-tools/28.0.3
export ANDROID_NDK_ROOT=$HOME/Library/Android/sdk/ndk-bundle
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_NDK_ROOT
export ANDROID_HVPROTO=ddm

# JDK
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=${PATH}:${JAVA_HOME}/bin


# node global node_moduls
# todo update this when you update node version
export PATH=${PATH}:/usr/local/Cellar/node/13.5.0/bin

# User tools
export PATH=${PATH}:$HOME/libs
export PATH=${PATH}:/usr/local/bin

# homebrew mirror
# export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

# Ruby dev
export RBENV_ROOT=/usr/local/var/rbenv

# disable autocompletes escape character paste
DISABLE_MAGIC_FUNCTIONS=true

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

# git alias
alias gcfix="git commit -a --fixup=HEAD"
alias ggpushf='git push -f origin "$(git_current_branch)"'
alias gsizetop='git rev-list --objects --all | grep "$(git verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | tail -5 | awk '"'"'{print$1}'"'"' ) "'

# gradle task
alias gupload="./gradlew uploadArchive"
alias gbuild="./gradlew clean && ./gradlew assembleDebug && ./gradlew installDebug"
alias gstop="./gradlew --stop"

# gdeps {module_name}
function show_denpendencies() {
	./gradlew -q $1:dependencies
}
alias gdeps="show_denpendencies"

# gdebug {taskname} debug gradle task
function debug_groovy_task() {
	./gradlew $1 -Dorg.gradle.debug=true  --no-daemon
}
alias gdebug="debug_groovy_task"

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
# system
function free_m() {
	vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f Mi\n", "$1:", $2 * $size / 1048576);'
}
alias free="free_m"

alias find=gfind

alias proxyon="export https_proxy=http://127.0.0.1:7890;export http_proxy=http://127.0.0.1:7890;export all_proxy=socks5://127.0.0.1:7891"
alias proxyoff="export http_proxy='';export https_proxy='';export all_proxy=''"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#alias for cnpm
alias cnpm="npm --registry=https://registry.npm.taobao.org \
  --cache=$HOME/.npm/.cache/cnpm \
  --disturl=https://npm.taobao.org/dist \
  --userconfig=$HOME/.cnpmrc"
