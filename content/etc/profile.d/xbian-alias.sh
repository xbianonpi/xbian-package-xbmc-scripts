#!/bin/sh

[ -x /usr/local/lib/kodi/kodi.bin ] && nm=kodi || nm=xbmc
alias xl="tailf /home/xbian/.$nm/temp/$nm.log"
alias xll="less /home/xbian/.$nm/temp/$nm.log"
alias xlll="while :; do tailf /home/xbian/.$nm/temp/$nm.log; done"

kodi () { if [ "$1" = start -o "$1" = stop -o "$1" = status ]; then sudo $1 xbmc; else echo "usage:"; echo "  kodi start|stop|status"; fi; }
