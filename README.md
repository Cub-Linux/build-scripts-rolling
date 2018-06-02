## Build Scripts
Get the "aur-archlinux" Keyring:  
```
wget https://repo.itmettke.de/aur/aur-archlinux/aurarchlinux-keyring.pkg.tar.xz 
pacman -U aurarchlinux-keyring.pkg.tar.xz 
```
  
Then copy a script:  
```
cp mkarchiso to /bin/
```
  
To build an ISO Image execute:
```
sudo ./build.sh -v" in the live-iso folder.
```
  
You can change the OS Version in these files:  
 - live-iso/airootfs/etc/os-release  
 - live-iso/airootfs/etc/xdg/kcm-about-distrorc  
 - live-iso/build.sh  
   
   
TODO:  
 - Automatic Version Change  
