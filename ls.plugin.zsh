#!/usr/bin/env zsh


if ! =gls --version >/dev/null 2>&1 ; then
  echo Please install GNU ls
  return -1
fi



_LS=(=ls)

if (( $+commands[gls] )); then
  _LS=(=gls)
fi

if [[ -z $SSH_CONNECTION ]] && $_LS --hyperlink >/dev/null 2>&1 ; then
  _HYPERLINK='--hyperlink'
fi

_LS=($_LS -hF  --group-directories-first --time-style=+%Y-%m-%d\ %H:%M)

function _is_ls_colored(){
  if [[ "$CLICOLOR" = 1 ]]; then
    echo "--color $_HYPERLINK"
  fi
}

if (( $+commands[grc] )); then
  _GRC=("grc" "--config=${${(%):-%x}:a:h}/conf.ls" )
fi

function ls(){
  $_LS $(_is_ls_colored) -C $@
}
compdef ls=ls

function l(){
  if [[ "$CLICOLOR" = 1 ]]; then
    $_GRC  $_LS $(_is_ls_colored) -lA $@
  else
    $_LS -lA $@
  fi
}
compdef l=ls

function la(){
  $_LS $(_is_ls_colored)  -C -A $@
}
compdef la=ls

function ll(){
  if [[ "$CLICOLOR" = 1 ]]; then
    $_GRC  $_LS $(_is_ls_colored) -l $@
  else
    $_LS -l $@
  fi
}
compdef ll=ls
