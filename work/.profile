# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -f /etc/xdg/autostart/gnome-keyring-ssh.desktop ]; then
    mkdir -p ~/.config/autostart
    cp /etc/xdg/autostart/gnome-keyring-ssh.desktop ~/.config/autostart/
    sed -i '/NoDisplay=true/d' ~/.config/autostart/gnome-keyring-ssh.desktop
    echo "X-GNOME-Autostart-enabled=false" >> ~/.config/autostart/gnome-keyring-ssh.desktop
fi

## create link to /cloudhome
if ! [ -h /home/${USER}/cloud ]; then
    ln -s /cloudhome/${USER}/ /home/${USER}/cloud
fi

## remove useless files
if [ -f /home/${USER}/Desktop/README.nohome ]; then
    rm /home/${USER}/Desktop/README.nohome
fi
if [ -f /home/${USER}/examples.desktop ]; then
    rm /home/${USER}/examples.desktop
fi

#Creat icon symlink and set theme
#if ! [ -h /usr/share/icons/Faenza ]; then
#    ln -s /cloudhome/bmartin4/startup/Faenza /usr/share/icons/Faenza
#    gsettings set org.gnome.desktop.interface icon-theme 'Faenza'
#fi

GIT=`git --version`
if [ $? -eq 0 ]; then
    git config --global user.email "crhrabal@mix.wvu.edu"
    git config --global user.name "crhrabal"
fi

#COPY WALLPAPER
if [ ! -f /home/crhrabal/pic1.png ]; then
	if [ -f /cloudhome/crhrabal/pic1.png ]; then
		cp /cloudhome/crhrabal/pic1.png /home/crhrabal/
	elif [ -f /media/crhrabal/crhrabal ]; then
		cp /media/crhrabal/crhrabal/pic1.png /home/crhrabal/
	fi
fi

#SSH KEYS
if [ ! -f ~/.ssh]; then
	mkdir ~/.ssh
fi
if [ ! -f ~/.ssh/identity]; then
	ln -s /media/crhrabal/crhrabal/.ssh/identity ~/.ssh/identity
	ssh-add
fi

#DCONF
gsettings set com.canonical.Unity.ApplicationsLens display-available-apps false
gsettings set org.gnome.desktop.background picture-uri file:///home/crhrabal/pic1.png

#LAUNCHER SIZE
dconf write /org/compiz/profiles/unity/plugins/unityshell/icon-size 24

#LAUNCHER FAVORITES
#Add my default apps
gsettings set com.canonical.Unity.Launcher favorites "['unity://expo-icon', 
'application://nautilus.desktop', 
'application://firefox.desktop', 
'application://chromium-browser.desktop', 
'application://thunderbird.desktop', 
'application://gnome-terminal.desktop', 
'application://gedit.desktop', 
'application://libreoffice-writer.desktop', 
'application://eclipse.desktop', 
'application://emacs23.desktop', 
'application://rhythmbox.desktop', 
'application://synaptic.desktop', 
'application://xchat.desktop', 
'application://gnome-system-monitor.desktop', 
'application://gnome-control-center.desktop', 
'unity://devices', 
'unity://running-apps']"
