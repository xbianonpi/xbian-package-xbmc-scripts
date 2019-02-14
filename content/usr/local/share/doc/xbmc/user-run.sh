#!/bin/sh

echo "-----------------------------------"
echo "$(date) $0 $@"
echo "-----------------------------------"

case $1 in

	preload)		# Invoked by /etc/init/xbmc-preload.conf
		case $2 in
			start)
				;;
			stop)
				# This should never happen
				;;
		esac
		;;

	xbmc)			# Invoked by /etc/init/xbmc.conf
		case $2 in
			start)
				;;
			stop)
				;;
		esac
		;;
		
	screensaver)		# Invoked by /etc/init/xbmc-screensaver.conf
		case $2 in
			start)
				;;
			stop)
				;;
		esac
		;;

esac

exit 0
