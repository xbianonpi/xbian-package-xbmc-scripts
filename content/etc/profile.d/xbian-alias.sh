#!/bin/sh

[ -d /home/xbian/.kodi ] && nm=kodi || nm=xbmc
alias xl="tailf /home/xbian/.$nm/temp/$nm.log"
alias xll="less /home/xbian/.$nm/temp/$nm.log"
alias xlll="while tailf /home/xbian/.$nm/temp/$nm.log; do :; done"

