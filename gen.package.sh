#!/bin/sh

rm_size() {
	cat ./content/DEBIAN/control | grep -v "Installed-Size:" > ./content/DEBIAN/control.new
	mv ./content/DEBIAN/control.new ./content/DEBIAN/control
	rm -f ./size.txt
}

str='strip'
strargs='--strip-unneeded'
tot=0

if ! dpkg-architecture -iarmhf; then
    arm-linux-gnueabihf-strip > /dev/null 2>&1
    [ $? -eq '127' ] && { echo "please install binutils-arm-linux-gnueabihf"; str=''; true; } || str='arm-linux-gnueabihf-strip'
fi

package=$(cat ./content/DEBIAN/control | grep Package | awk '{print $2}')
version=$(cat ./content/DEBIAN/control | grep Version | awk '{print $2}')

# calculate size dynamically. remove first any entry, then add the actual 
rm_size

cd content
find ./ -type f -print0 | xargs -0 -L1 printf "%s\n" | while read f; do [ -z "$str" ] || $str $strargs "$f" 2>/dev/null; s=$(stat -c %s "$f"); tot=$((tot + (s/1024)+1)); echo $tot > ../size.txt; done
printf "Installed-Size: %u\n" $(cat ../size.txt) >> ./DEBIAN/control
sleep 5
find ./ -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P\0' | sort -z| xargs --null md5sum > DEBIAN/md5sums
cd ..
fakeroot dpkg-deb -b ./content "${package}""${version}".deb
# remove the size again, because on different filesystems du will return different size
rm_size
#rm -f ./content/etc/default/*.default
