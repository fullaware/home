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

# Install hdajackretask to enable bottom speakers
sudo dnf install alsa-tools
hdajackretask
# Check "Show Unconnected pins"
# Change Pin ID 0x1b to Internal Speaker (LFE)
# Change PIN ID 0x1e to Internal Speaker (LFE)

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


# Install Mullvad VPN
sudo dnf config-manager --add-repo https://repository.mullvad.net/rpm/stable/mullvad.repo
sudo dnf install mullvad-vpn

# Prep Projects folder with git repos
cd ~/projects/
git clone git@github.com:fullaware/asteroids.git
git clone git@github.com:fullaware/watchdog.git
git clone git@github.com:fullaware/hugo-blog.git
git clone git@github.com:fullaware/www.fullaware.com.git
git clone git@github.com:fullaware/asteroidmining.git
git clone git@github.com:fullaware/home.git

# Install Hugo
sudo dnf install hugo


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
sudo dnf makecache
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

# Install Docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh
ollama run llama3:8b

# Install open-webui
docker run -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main

# Upgrade open-webui
# docker run --rm --volume /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --run-once open-webui

# Change Ollama API under Admin Settings > Connections to http://localhost:11434
firefox http://localhost:3000

# Install Zoom
wget https://zoom.us/client/6.1.0.198/zoom_x86_64.rpm
sudo dnf install zoom_x86_64.rpm

```
