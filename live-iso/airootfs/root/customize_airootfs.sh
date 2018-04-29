#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

useradd -m -G "wheel,audio,network" -s /bin/bash defaultuser

usermod -s /usr/bin/bash root
cp -aT /etc/skel/ /home/defaultuser/
chmod 700 /root
chown -R defaultuser:users /home/defaultuser/
chfn -f "Default User" defaultuser
echo "defaultuser:default"|chpasswd

#sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

sed -i '/#TEMPORARY/,$d' /etc/pacman.conf

cd /usr/share/sddm/themes/
rm -rf Elarun Maldives maya
cd /
pacman -Rs linux
systemctl enable pacman-init.service choose-mirror.service sddm NetworkManager systemd-timesyncd
