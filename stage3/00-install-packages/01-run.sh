#!/bin/bash -e

on_chroot << EOF
update-alternatives --install /usr/bin/x-www-browser \
  x-www-browser /usr/bin/chromium-browser 86
update-alternatives --install /usr/bin/gnome-www-browser \
  gnome-www-browser /usr/bin/chromium-browser 86
EOF


on_chroot << EOF
echo '#!/bin/bash

file="/etc/salt/minion_id"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "$file not found."
	uuid=$(uuidgen)
	echo "raspberry_pi_3_09_2018_${uuid}" > /etc/salt/minion_id
fi' > /saltminiongenid1.sh

mkdir /etc/salt
echo "master: HOSTNAME" > /etc/salt/minion
EOF
