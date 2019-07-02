# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

####################
### 先行読み込み ###
####################
if [ -f /etc/profile.d/bash_completion.sh ]; then
    source /etc/profile.d/bash_completion.sh
elif [ -f ~/.bin/completion/bash_completion.sh ]; then
    source ~/.bin/completion/bash_completion.sh
fi

if [ -f /etc/profile.d/git-prompt.sh ]; then
    source /etc/profile.d/git-prompt.sh
elif [ -f ~/.bin/completion/git-prompt.sh ]; then
    source ~/.bin/completion/git-prompt.sh
fi

if [ -f ~/.bin/completion/git-completion.bash ]; then
    source ~/.bin/completion/git-completion.bash
fi

if [ -f ~/.bin/completion/mvn_completion.sh ]; then
    source ~/.bin/completion/mvn_completion.sh
fi


####################
### Color Define ###
####################
# Reset
Color_Off="\033[0m"       # Text Reset

# Regular Colors
Black="\033[0;30m"        # Black
Red="\033[0;31m"          # Red
Green="\033[0;32m"        # Green
Yellow="\033[0;33m"       # Yellow
Blue="\033[0;34m"         # Blue
Purple="\033[0;35m"       # Purple
Cyan="\033[0;36m"         # Cyan
White="\033[0;37m"        # White

# Bold
BBlack="\033[1;30m"       # Black
BRed="\033[1;31m"         # Red
BGreen="\033[1;32m"       # Green
BYellow="\033[1;33m"      # Yellow
BBlue="\033[1;34m"        # Blue
BPurple="\033[1;35m"      # Purple
BCyan="\033[1;36m"        # Cyan
BWhite="\033[1;37m"       # White

# Underline
UBlack="\033[4;30m"       # Black
URed="\033[4;31m"         # Red
UGreen="\033[4;32m"       # Green
UYellow="\033[4;33m"      # Yellow
UBlue="\033[4;34m"        # Blue
UPurple="\033[4;35m"      # Purple
UCyan="\033[4;36m"        # Cyan
UWhite="\033[4;37m"       # White

# Background
On_Black="\033[40m"       # Black
On_Red="\033[41m"         # Red
On_Green="\033[42m"       # Green
On_Yellow="\033[43m"      # Yellow
On_Blue="\033[44m"        # Blue
On_Purple="\033[45m"      # Purple
On_Cyan="\033[46m"        # Cyan
On_White="\033[47m"       # White

# High Intensty
IBlack="\033[0;90m"       # Black
IRed="\033[0;91m"         # Red
IGreen="\033[0;92m"       # Green
IYellow="\033[0;93m"      # Yellow
IBlue="\033[0;94m"        # Blue
IPurple="\033[0;95m"      # Purple
ICyan="\033[0;96m"        # Cyan
IWhite="\033[0;97m"       # White

# Bold High Intensty
BIBlack="\033[1;90m"      # Black
BIRed="\033[1;91m"        # Red
BIGreen="\033[1;92m"      # Green
BIYellow="\033[1;93m"     # Yellow
BIBlue="\033[1;94m"       # Blue
BIPurple="\033[1;95m"     # Purple
BICyan="\033[1;96m"       # Cyan
BIWhite="\033[1;97m"      # White

# High Intensty backgrounds
On_IBlack="\033[0;100m"   # Black
On_IRed="\033[0;101m"     # Red
On_IGreen="\033[0;102m"   # Green
On_IYellow="\033[0;103m"  # Yellow
On_IBlue="\033[0;104m"    # Blue
On_IPurple="\033[10;95m"  # Purple
On_ICyan="\033[0;106m"    # Cyan
On_IWhite="\033[0;107m"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

############################
### Function definitions ###
############################
function trash() {
    NOWDATE=`date  +"%y%m%d-%H%M%S"`

    if [ ! -d ~/.trash/$NOWDATE ];then
      mkdir -p ~/.trash/$NOWDATE
    fi

    while [ "$1" != "" ];do
        if [ "${1:0:1}" != "-" ];then
            mv "$1" ~/.trash/$NOWDATE && echo "mv "$1" ~/.trash/$NOWDATE"
        fi
        shift
    done
}

function share_history() {  # 以下の内容を関数として定義
    history -a  # .bash_historyに前回コマンドを1行追記
    history -c  # 端末ローカルの履歴を一旦消去
    history -r  # .bash_historyから履歴を読み込み直す
}

function cdls() {
    # cdがaliasでループするので\をつける
    \cd "$@";
    if [ "$?" -eq 0 ];then
        ls --color=auto
    fi
}

function length() {
    echo -n "${#1}"
}

function init_prompt_git_branch() {
    git branch &>/dev/null
    if [ $? -eq 0 ]; then
      echo -ne "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
      if [ "$?" -eq "0" ]; then \
        # @4 - Clean repository - nothing to commit
        echo ""$Green""$(__git_ps1 " (%s)"); \
      else \
        # @5 - Changes to working tree
        echo ""$IRed""$(__git_ps1 " (%s)"); \
      fi) "$BYellow$Color_Off""
    else
      # @2 - Prompt when not in GIT repo
      echo -ne " "$Yellow$Color_Off""
    fi
}

function branch_length()  {
    #length "`echo -ne \"\$(__git_ps1)\"`"
    length "`echo -ne ===2017-06-06T21:58:36===`"
}

function prompt_right_aligned() {
    echo -ne "\e[$[COLUMNS]D\e[$[COLUMNS-$(branch_length)-1]C"
}

function makecolor() {
    LANG=C make $* 2>&1 \
    | while read line ; do
    case $line in
        *error:\ *)
          echo -e "$BIRed"$line"$Color_Off"
          ;;

        *warning:\ *)
          echo -e "$BIYellow"$line"$Color_Off"
          ;;

        *undefined\ reference*)
          echo -e "$BIPurple"$line"$Color_Off"
          ;;

        *)
          echo $line
          ;;

        esac
    done
}

function __show_status() {
    local status=$(echo ${PIPESTATUS[@]})
    local SETCOLOR_SUCCESS="echo -en $Green"
    local SETCOLOR_FAILURE="echo -en $Red"
    local SETCOLOR_WARNING="echo -en $Yellow"
    local SETCOLOR_NORMAL="echo -en $Color_Off"

    local SETCOLOR s
    for s in ${status}; do
        if [ ${s} -gt 100 ] ; then
            SETCOLOR=${SETCOLOR_FAILURE}
        elif [ ${s} -gt 0 ] ; then
            SETCOLOR=${SETCOLOR_WARNING}
        else
            SETCOLOR=${SETCOLOR_SUCCESS}
        fi
    done
    ${SETCOLOR}
    if [ "$SETCOLOR" != "${SETCOLOR_SUCCESS}" ]; then
        echo -ne "(${status// /|})"
    fi
    ${SETCOLOR_NORMAL}
}

######################
### PROMPT_COMMAND ###
######################
function __prompt_command() {
  share_history
  __show_status
}

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES="enable"
GIT_PS1_SHOWUPSTREAM="auto"

function colorize_by_host() {
  local hash=$(hostname | sha256sum | cut -b 1-2)
  local color_fg=$(( $(echo "0x"${hash:0:1}) % 8 ))
  local color_bg=$(( $(echo "0x"${hash:1:1}) % 8 ))
  if [[ $color_fg -eq $color_bg ]]; then
    color_bg=$(( ($color_bg +1) % 8 + 40 ))
  else
    color_bg=$(( ($color_bg +1) % 8 + 40 ))
  fi
  if [[ ${color_fg} -eq 0 ]]; then
    color_fg=$(( ($color_fg +1) % 8 ))
  fi
  color_fg=$(( $color_fg + 30 ))
  #echo "\e[${color_fg}m\e[${color_bg}m\]"
  echo "\e[${color_fg}m\]"
}

PROMPT_COLOR="\033[0;37;100m"
#export PS1="${PROMPT_COLOR}[\u@\h:\w]${Color_Off}\$(init_prompt_git_branch)\$(prompt_right_aligned)${PROMPT_COLOR}===\D{%FT%T}===${Color_Off}\n\$ "
export PS1="${PROMPT_COLOR}[\u@\h:\w]${Color_Off}\$(init_prompt_git_branch)\$(prompt_right_aligned)$(colorize_by_host)===\D{%FT%T}===${Color_Off}\n\$ "
PROMPT_COMMAND=__prompt_command
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME:+$FUNCNAME(): }'

##############
### Custom ###
##############
ulimit -c 10000000
# 履歴のサイズ。新山の場合はこれで半年ぐらい前のやつまで残る。
HISTSIZE=50000
HISTFILESIZE=50000

# 履歴ファイルを上書きではなく追加する。
# 複数のホストで同時にログインすることがあるので、上書きすると危険だ。
shopt -s histappend
# "!"をつかって履歴上のコマンドを実行するとき、
# 実行するまえに必ず展開結果を確認できるようにする。
shopt -s histverify
# 履歴の置換に失敗したときやり直せるようにする。
shopt -s histreedit
# 端末の画面サイズを自動認識。
shopt -s checkwinsize
# "@" のあとにホスト名を補完させない。
shopt -u hostcomplete
# つねにパス名のテーブルをチェックする。
shopt -s checkhash
# 変数を展開する
shopt -s cdable_vars
# なにも入力してないときはコマンド名を補完しない。
# (メチャクチャ候補が多いので。)
shopt -s no_empty_cmd_completion
export HISTCONTROL=ignoreboth
export HISTIGNORE=cd:history:ls:which   #you can use wild cart(*,?)
# Ctrl-dでログアウトしない
set -o ignoreeof
# GUIで認証しない
unset SSH_ASKPASS
# lessでカラー表示
export LESS='--no-init -R --shift 4 --LONG-PROMPT --quit-if-one-screen'

# ターミナル使用時の設定 #
case "$TERM" in
  kterm|*xterm*|sun|screen*)
    # stty
    stty erase '^H'
    stty erase '^?'
    stty werase '^W'
    stty stop undef
    # word delete
    stty werase undef
    if [[ "$-" =~ "i" ]]; then
        # 隠しファイルを補完候補に入れない
        bind 'set match-hidden-files off'
        bind '\C-w:unix-filename-rubout'
    fi
    _termtitle="\h:\w"
    ;;
esac

################
### Complete ###
################
complete -d cd
complete -c man
complete -c h
complete -c wi
complete -v unset

#############
### Alias ###
#############
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'
alias lal='ls -al'
alias cl='clear'
alias rm="trash"
alias Trash="~/.trash"
alias cp="cp -ip"
alias mv='mv -i'
alias scp="scp -p"
alias sc="screen"
alias cd="cdls"
alias gre="grep --color=auto -n -H -i -I"
alias makecolor="makecolor"
alias l='less'
alias vi='vim'
alias v='vim'
alias jutf='export LANG=ja_JP.UTF-8'
alias jeuc='export LANG=ja_JP.euc-jp'
alias t='tmux'

##############
### Export ###
##############
export PATH="$PATH:$HOME/.bin"

##########################
## load local settings ###
##########################
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

:

