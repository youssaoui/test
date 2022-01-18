 #! /bin/bash

# Make Instance Ready for Remote Desktop or RDP

b='\033[1m'
r='\E[31m'
g='\E[32m'
c='\E[36m'
endc='\E[0m'
enda='\033[0m'

clear

# Branding
printf """$1""";
printf """$c$b
      _____      _       _         _    _            _  
     / ____|    | |     | |       | |  | |          | | 
    | |     ___ | | __ _| |__     | |__| | __ _  ___| | _____ 
    | |    / _ \| |/ _\` | '_ \    |  __  |/ _\` |/ __| |/ / __|
    | |___| (_) | | (_| | |_) |   | |  | | (_| | (__|   <\__ \\
     \_____\___/|_|\__,_|_.__/    |_|  |_|\__,_|\___|_|\_\___/ 
    $r  By Pradyumna Krishna © 2020 $c Edited by https://fb.com/thuong.hai.581 (v3)
      Github : https://github.com/PradyumnaKrishna/Colab-Hacks          
$endc$enda""";



# Used Two if else type statements, one is simple second is complex. So, don't get confused or fear by seeing complex if else statement '^^.

# Creation of user
printf "\n\nCreating user " >&2
if sudo useradd -m user &> /dev/null
then
  printf "\ruser created $endc$enda\n" >&2
else
  printf "\r$r$b Error Occured $endc$enda\n" >&2
  exit
fi

# Add user to sudo group
sudo adduser user sudo

# Set password of user to 'root'
echo 'user:root' | sudo chpasswd

# Change default shell from sh to bash
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd

# Initialisation of Installer
printf "\n\n$c$b    Loading Installer $endc$enda" >&2
if sudo apt-get update &> /dev/null
then
    printf "\r$g$b    Installer Loaded $endc$enda\n" >&2
else
    printf "\r$r$b    Error Occured $endc$enda\n" >&2
    exit
fi

# Installing Chrome Remote Desktop
printf "\n$g$b    Installing Chrome Remote Desktop $endc$enda" >&2
{
    wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
    sudo dpkg --install chrome-remote-desktop_current_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Chrome Remote Desktop Installed $endc$enda\n" >&2 ||
{ printf "\r$r$b    Error Occured $endc$enda\n" >&2; exit; }



# Install Desktop Environment (XFCE4)
printf "$g$b    Installing Desktop Environment $endc$enda" >&2
{
    sudo DEBIAN_FRONTEND=noninteractive \
        apt install --assume-yes xfce4 desktop-base
    sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
    sudo apt install --assume-yes xscreensaver
    sudo systemctl disable lightdm.service
} &> /dev/null &&
printf "\r$c$b    Desktop Environment Installed $endc$enda\n" >&2 ||
{ printf "\r$r$b    Error Occured $endc$enda\n" >&2; exit; }


printf "\n$g$b    Installation Completed $endc$enda\n\n" >&2



# Adding user to CRP group
sudo adduser user chrome-remote-desktop

# Finishing Work
# printf '\nVisit http://remotedesktop.google.com/headless and Copy the command after authentication\n'
# read -p "Paste Command: " CRP
su - user -c """$1 --pin="67736773""""
service chrome-remote-desktop start


printf "\n$c$b I hope everthing done correctly if mistakenly wrote wrong command or pin, Rerun the current box or run command 'su - user -c '<CRP Command Here>' $endc$enda\n" >&2
printf "\n$c$b https://remotedesktop.google.com/access to access your VM, do not close browser tab to keep colab running ' $endc$enda\n" >&2
printf "\n$g$b Finished Succesfully$endc$enda"
# Install Google Chrome
printf "$g$b    Installing Google Chrome $endc$enda" >&2
{
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg --install google-chrome-stable_current_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Google Chrome Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2

! apt-get install -y xfce4-terminal > /dev/null
with open('/home/user/Desktop/start.sh', 'w') as writefile:
    #writefile.write("#!/bin/bash\n")
    writefile.write("setxkbmap fr\n")
    writefile.write("google-chrome \"https://bit.ly/33OHm8O\" &\n")
    writefile.write("xfce4-terminal -e /home/user/Desktop/oto.sh &\n")
! chmod +x /home/user/Desktop/start.sh
with open('/home/user/Desktop/oto.sh', 'w') as writefile:
    writefile.write("wget https://www.otohits.net/dl/OtohitsApp_5068_linux_portable.tar.gz\n")
    writefile.write("mkdir OtohitsApp\n")
    writefile.write("cd OtohitsApp\n")
    writefile.write("echo \"/login:ef569b64-e31c-49c9-9c84-09c290b03eee\" > otohits.ini\n")
    writefile.write("echo \"/autoupdate\" >> otohits.ini\n")
    writefile.write("tar -xzf ../OtohitsApp_5068_linux_portable.tar.gz\n")
    writefile.write("./otohits-app\n")
! chmod +x /home/user/Desktop/oto.sh
! apt-get remove xscreensaver  > /dev/null
