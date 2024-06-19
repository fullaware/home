# Script to bootstrap my `~` in Fedora

```
# Fix volume level issue with Audio device: [AMD] Family 17h/19h HD Audio Controller
# Insert this block in
sudo vim /usr/share/alsa-card-profile/mixer/paths/analog-output.conf.common

[Element Master]
switch = mute
volume = ignore

# Before this block
[Element PCM]

pulseaudio -k

tar -xvf myssh.tar.gz 
rm .ssh/known_hosts
rm .ssh/known_hosts.old 
rm .ssh/zenrig.pem 
vim .bashrc
sudo dnf install git-core
mkdir projects
# rm myssh.tar.gz 
ssh git@github.com
git config --global user.email "fullaware@@users.noreply.github.com"
git config --global user.name "Full Aware"

cd ~/projects/
sudo dnf config-manager --add-repo https://repository.mullvad.net/rpm/stable/mullvad.repo
# Install the package
sudo dnf install mullvad-vpn
git clone git@github.com:fullaware/asteroids.git
git clone git@github.com:fullaware/watchdog.git
git clone git@github.com:fullaware/hugo-blog.git
git clone git@github.com:fullaware/www.fullaware.com.git
git clone git@github.com:fullaware/asteroidmining.git
git clone git@github.com:fullaware/home.git
sudo dnf install hugo
sudo dnf install alsa-tools
hdajackretask

# Install NVIDIA for Fedora 40 
firefox https://www.nvidia.com/download/index.aspx
chmod +x ~/Downloads/NVIDIA*.run

echo -e "blacklist nouveau\noptions nouveau modeset=0" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf

vim /etc/default/grub
# Replace GRUB_CMDLINE_LINUX with this
GRUB_CMDLINE_LINUX="rhgb quiet rd.driver.blacklist=nouveau nvidia-drm.modeset=1"
sudo dracut --force
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
# Enable CLI
sudo systemctl set-default multi-user.target
sudo reboot
sudo dnf install pkgconf-pkg-config xorg-x11-server-Xwayland-devel xorg-x11-server-Xorg xorg-x11-server-devel
sudo ~/Downloads/NVIDIA*.run
YES ENTER
YES ENTER
YES ENTER
Rebuild initramfs ENTER
YES ENTER

# Enable graphical UI
sudo systemctl set-default graphical.target
sudo reboot

lsmod | grep nvidia
sudo nvidia-smi
sudo nvidia-settings
# Install Steam
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install steam
# Install VS Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install code


```
