if [[ `command -v tput` && `tput setaf 1 2>/dev/null` ]]; then
  COLOR_RED=`tput setaf 1`
  COLOR_GREEN=`tput setaf 2`
  COLOR_YELLOW=`tput setaf 3`
  COLOR_BLUE=`tput setaf 4`
  COLOR_RESET=`tput sgr0`
fi

if [ ! -f ./phase1.phase ];
then
    echo -e "${COLOR_RED}Beginning Phase 1${COLOR_RESET}"
    echo -e "${COLOR_GREEN}Install NVIDIA for Fedora 40 - GeForce RTX 3050 6GB Laptop GPU${COLOR_RESET}"
    firefox https://www.nvidia.com/download/index.aspx
    read -p "Proceed to https://www.nvidia.com/download/index.aspx to download driver for RTX 3050 Laptop GPU"
    chmod +x ~/Downloads/NVIDIA*.run
    echo -e "blacklist nouveau\noptions nouveau modeset=0" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
    # Replace GRUB_CMDLINE_LINUX with this
    sudo sed -i '/GRUB_CMDLINE_LINUX/c\GRUB_CMDLINE_LINUX="rhgb quiet rd.driver.blacklist=nouveau nvidia-drm.modeset=1"' /etc/default/grub
    # Prepare to install NVIDIA driver
    sudo dnf makecache
    sudo dnf install pkgconf-pkg-config xorg-x11-server-Xwayland-devel xorg-x11-server-Xorg xorg-x11-server-devel -y

    sudo dracut --force
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg

    # Enable CLI
    sudo systemctl set-default multi-user.target
    
    touch ./phase1.phase 
    sudo reboot
    exit 0
else
    if [ ! -f ./phase2.phase ];
    then
        echo -e "${COLOR_RED}Beginning Phase 2${COLOR_RESET}"
        
        echo "YES ENTER"
        echo "YES ENTER"
        echo "YES ENTER"
        echo "Rebuild initramfs ENTER"
        echo "YES ENTER"
        read -p " --> Press any key to continue <--"
        sudo ~/Downloads/NVIDIA*.run

        # Enable graphical UI
        sudo systemctl set-default graphical.target
        
        touch ./phase2.phase
        sudo reboot 
        exit 0
    else
        if [ ! -f ./phase3.phase ];
        then
            echo -e "${COLOR_RED}Beginning Phase 3${COLOR_RESET}"
            lsmod | grep nvidia
            # Verify NVIDIA driver install successful
            sudo nvidia-smi
            sudo nvidia-settings

            # Fix volume level issue with Audio device: [AMD] Family 17h/19h HD Audio Controller
            sudo sed -i.bak '/\[Element PCM\]/i [Element Master]\nswitch = mute\nvolume = ignore \n ' /usr/share/alsa-card-profile/mixer/paths/analog-output.conf.common

            # Install hdajackretask to enable bottom speakers
            sudo dnf install alsa-tools -y
            echo "Check 'Show Unconnected pins'"
            echo "Change Pin ID 0x1b to Internal Speaker (LFE)"
            echo "Change PIN ID 0x1e to Internal Speaker (LFE)"
            echo "Apply Now"
            echo "Install boot override"
            read -p " --> Press any key to continue <--"
            hdajackretask
            touch ./phase3.phase
            sudo reboot
            exit 0
        else
            if [ ! -f ./phase4.phase ];
            then
                echo -e "${COLOR_RED}Beginning Phase 4${COLOR_RESET}"
                # Mount SMB share and copy myssh.tar.gz
                sudo mkdir /mnt/4TB
                sudo chown fullaware:fullaware /mnt/4TB
                echo -e "${COLOR_GREEN}Enter password for SMB mount${COLOR_RESET}"
                sudo mount -t cifs //mouse.home.fullaware.com/4TB /mnt/4TB -o username=home
                cp /mnt/4TB/myssh.tar.gz ~
                cd ~
                tar -xvf myssh.tar.gz 
                rm ~/myssh.tar.gz 

                # Configure Git
                sudo dnf install git-core -y
                ssh -o StrictHostKeyChecking=accept-new git@github.com
                git config --global user.email "fullaware@@users.noreply.github.com"
                git config --global user.name "Full Aware"

                # Prep Projects folder with git repos
                mkdir ~/projects
                cd ~/projects/
                git clone git@github.com:fullaware/asteroids.git
                git clone git@github.com:fullaware/watchdog.git
                git clone git@github.com:fullaware/hugo-blog.git
                git clone git@github.com:fullaware/www.fullaware.com.git
                git clone git@github.com:fullaware/asteroidmining.git
                git clone git@github.com:fullaware/home.git

                # Modify .bashrc and .vimrc
                cd ~/projects/home
                cat .bashrc >> ~/.bashrc
                cat .vimrc >> ~/.vimrc
                source ~/.bashrc

                # Install RPMFusion
                sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

                # Install Hugo
                sudo dnf install hugo -y

                # Install Mullvad VPN
                sudo dnf config-manager --add-repo https://repository.mullvad.net/rpm/stable/mullvad.repo
                sudo dnf install mullvad-vpn -y

                # Install Steam (requires RPMFusion)
                sudo dnf install steam -y

                # Install VS Code
                sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
                echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
                dnf check-update
                sudo dnf install code -y

                # Install Docker
                sudo dnf -y install dnf-plugins-core
                sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
                sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
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
                firefox http://localhost:8080
                read -p "Proceed to http://localhost:8080 to modify Ollama API"

                # Install Zoom 
                firefox https://zoom.us/download?os=linux
                read -p "Proceed to the zoom.us website and choose the latest .rpm"
                wget https://zoom.us/client/6.1.0.198/zoom_x86_64.rpm
                sudo dnf install zoom_x86_64.rpm -y

                # Install VS Code
                sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
                echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
                dnf check-update
                sudo dnf install code -y

                # Install INSYNC
                sudo rpm --import https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key
                echo -e "[insync]\nname=insync repo\nbaseurl=http://yum.insync.io/fedora/\$releasever/\nenabled=1\ngpgcheck=1\ngpgkey=https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key\nenabled=1\nmetadata_expire=120m" | sudo tee /etc/yum.repos.d/insync.repo > /dev/null
                sudo dnf update
                sudo dnf install insync -y

                # Install Joplin
                wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

                # Install kubectl
                sudo dnf install kubernetes-client -y

                # Install k9s
                wget https://github.com/derailed/k9s/releases/download/v0.32.5/k9s_linux_amd64.rpm
                sudo dnf install k9s_linux_amd64.rpm -y

                # Install helm
                curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
                chmod 700 get_helm.sh
                ./get_helm.sh

                # Install MongoDB Compass
                wget https://downloads.mongodb.com/compass/mongodb-compass-1.43.1.x86_64.rpm
                sudo dnf install mongodb-compass*.rpm -y
                
                # Install DBeaver
                wget https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm
                sudo dnf install dbeaver-ce-latest-stable*.rpm -y
                
                # Install Java
                sudo dnf install java-11-openjdk java-11-openjdk-devel -y
                sudo dnf install icedtea-web -y
                
                # Install and configure AWS CLI

                # Install and configure Azure CLI

                

                touch ./phase4.phase
                exit 0
            else
                echo "All phases completed"
            fi
        fi
    fi
fi











