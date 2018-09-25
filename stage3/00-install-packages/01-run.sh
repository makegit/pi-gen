#!/bin/bash -e

on_chroot << EOF
update-alternatives --install /usr/bin/x-www-browser \
  x-www-browser /usr/bin/chromium-browser 86
update-alternatives --install /usr/bin/gnome-www-browser \
  gnome-www-browser /usr/bin/chromium-browser 86
EOF


on_chroot << EOF


echo ' #!/bin/bash

bootsaltmasterfile = "/boot/salt/master"

bootsaltminionid = "/boot/salt/minion_id"

if [ -f "$bootsaltmasterfile" ]
then
	echo "$bootsaltmasterfile found."
	cp $bootsaltmasterfile /etc/salt/master
else
	echo "$bootsaltmasterfile not found."
fi

if [ -f "$bootsaltminionid" ]
then
	echo "$bootsaltminionid ound."
	cp $bootsaltminionid /etc/salt/master
else
	echo "$bootsaltminionid not found and generate new minionid."
	uuid=$(uuidgen)
	echo "raspberry_pi_3_09_2018_${uuid}" > /etc/salt/minion_id
fi

systemctl stop salt-minion
systemctl start salt-minion


' > /etc/init.d/saltminiongenid.sh

chown root:root /etc/init.d/saltminiongenid.sh
chmod +x /etc/init.d/saltminiongenid.sh

EOF
