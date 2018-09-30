#!/bin/bash

function setUmask() {
    # Set umask
    set -e -u
    umask 022
}

function genLocale() {
    # Set locales
    sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
    locale-gen
}

function setTimeZoneAndClock() {
    # Set timezone
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime

    # Set clock to UTC
    hwclock --systohc --utc
}

function configRootUser() {
    # Configure root user
    usermod -s /usr/bin/bash root
    chmod 750 /root
    cp -aT /etc/skel/ /root/
}

function createLiveUser() {
    # Add live user
    useradd -m -G "wheel,audio,network" -s /bin/bash defaultuser
    chown -R defaultuser:users /home/defaultuser/
    chfn -f "Default User" defaultuser
    echo "defaultuser:default" | chpasswd
}

function configureLiveUser() {
    # Configure live user
    mkdir -p /home/defaultuser/Desktop/
    cp /usr/share/applications/calamares.desktop /home/defaultuser/Desktop/
    cp /usr/share/applications/calamares.desktop /home/defaultuser/.config/autostart/
    chmod +x /home/defaultuser/Desktop/calamares.desktop
    chmod +x /home/defaultuser/.config/autostart/calamares.desktop
    rm -rf /home/defaultuser/.config/autostart/welcome-screen.desktop
}

function miscConfigs() {
    # Misc configs
    sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
    sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf
    sed -i '/#TEMPORARY/,$d' /etc/pacman.conf
}

function systemdAntiDumbasseryHack() {
    # systemd anti-dumbassery hack
    echo 'This is systemd anti-dumbassery hack. See systemd-update-done.service(8).' | tee /etc/.updated > /var/.updated
}

function fixHibernate() {
    # Fix hibernate
    sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
    sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
    sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf
}

function enableServices() {
    # Enable services
    systemctl enable pacman-init.service sddm NetworkManager
}

setUmask
genLocale
setTimeZoneAndClock
configRootUser
createLiveUser
configureLiveUser
miscConfigs
systemdAntiDumbasseryHack
fixHibernate
enableServices
