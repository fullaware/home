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


```
