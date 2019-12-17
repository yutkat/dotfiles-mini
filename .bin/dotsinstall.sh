#!/bin/bash
set -ue


#--------------------------------------------------------------#
##          Functions                                         ##
#--------------------------------------------------------------#

helpmsg() {
  command echo "Usage: $0 [--help | -h]" 0>&2
  command echo ""
}

link_to_homedir() {
  command echo "backup old dotfiles..."
  if [ ! -d "$HOME/.gdotbackup" ];then
    command echo "$HOME/.gdotbackup not found. Auto Make it"
    command mkdir "$HOME/.gdotbackup"
  fi

  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  local dotdir=$(dirname ${script_dir})
  if [[ "$HOME" != "$dotdir" ]];then
    for f in $dotdir/.??*; do
      [[ `basename $f` == ".git" ]] && continue
      if [[ -L "$HOME/`basename $f`" ]];then
        command rm -f "$HOME/`basename $f`"
      fi
      if [[ -e "$HOME/`basename $f`" ]];then
        command mv "$HOME/`basename $f`" "$HOME/.gdotbackup"
      fi
      command ln -snf $f $HOME
    done
  else
    command echo "same install src dest"
  fi
}


#--------------------------------------------------------------#
##          Main                                              ##
#--------------------------------------------------------------#

IS_INSTALL="true"

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    install)
      IS_INSTALL="true"
      ;;
    *)
      ;;
  esac
  shift
done

if [[ "$IS_INSTALL" = true ]];then
  link_to_homedir
  command echo ""
  command echo "#####################################################"
  command echo -e "\e[1;36m $(basename $0) install success!!! \e[m"
  command echo "#####################################################"
  command echo ""
fi

