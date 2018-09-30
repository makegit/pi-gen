#!/bin/bash -e

on_chroot << EOF
update-alternatives --install /usr/bin/x-www-browser \
  x-www-browser /usr/bin/chromium-browser 86
update-alternatives --install /usr/bin/gnome-www-browser \
  gnome-www-browser /usr/bin/chromium-browser 86
EOF


on_chroot << EOF
mv /etc/salt /etc/_salt_org_bak

mkdir /boot/salt
ln -fs /boot/salt/ /etc/salt

echo 'master: ' > /boot/salt/minion
echo 'raspberrypi' > /boot/salt/minion_id


mkdir /boot/start
echo '#!/bin/bash' > /boot/start/start.sh
chmod u+x /boot/start/start.sh
(crontab -u root -l; echo "@reboot /boot/start/start.sh" ) | crontab -u root -


EOF
