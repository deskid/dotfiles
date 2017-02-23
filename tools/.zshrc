export ZSH=/Users/zhou/.oh-my-zsh
ZSH_THEME="robbyrussell"

export UPDATE_ZSH_DAYS=1

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git osx autojump)


# Android dev
export PATH=${PATH}:/Users/zhou/Library/Android/sdk/tools:/Users/zhou/Library/Android/sdk/platform-tools
export PATH=${PATH}:/Users/zhou/Library/Android/sdk/build-tools/24.0.2
export PATH=${PATH}:/Applications/Android\ Studio.app/Contents/gradle/gradle-3.2/bin 
export ANDROID_NDK_ROOT=/Users/zhou/Library/Android/sdk/ndk-bundle
export ANDROID_HOME=/Users/zhou/Library/Android/sdk
export PATH=$PATH:$ANDROID_NDK_ROOT

# JDK 
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_91.jdk/Contents/Home
export PATH=${PATH}:${JAVA_HOME}/bin

# Apache
export PATH=${PATH}:/Users/zhou/libs/apache-maven-3.3.9/bin

# User tools
export PATH=${PATH}:/Users/zhou/libs
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
alias zshreload="source /Users/zhou/.zshrc"

# http://{yourIP}:8000
alias shttp="python -m SimpleHTTPServer 8000"

# gradle task
alias gupload="./gradlew uploadArchive"
alias gbuild="./gradlew clean && ./gradlew assembleDebug && ./gradlew installDebug"
alias gstop="./gradlew --stop"

function show_denpendencies(){
	./gradlew -q $1:dependencies 
}
# gdeps {module_name}
alias gdeps="show_denpendencies"

# adb shell 
alias logcate="noglob adb logcat AndroidRuntime:E *:S"
alias showtask="adb shell dumpsys activity activities | sed -En -e '/Stack #/p' -e '/Running activities/,/Run #0/p'"

# system
function free_m(){
	vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f Mi\n", "$1:", $2 * $size / 1048576);'
}
alias free="free_m"


export NVM_DIR="/Users/zhou/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH=${PATH}:/Applications/Android\ Studio.app/Contents/gradle/gradle-3.2/bin
