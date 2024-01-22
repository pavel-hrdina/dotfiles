[//]: ###### (Documentation for me, when I need to install my system again. Pavel Hrdina)

<div align="center">
    <h1>Hyprland dotfiles</h1>
    <h3></h3>
</div>

![desktop](https://images2.imgbox.com/f0/6c/Wbog0c5Z_o.png)

## Installation

The script is made for openSUSE Tumbleweed. I didn't include Nvidia support. (I still need to create a script, but I don't have time for that right now, it'll be done when it's done.)

> [!CAUTION]
> Examine the script thoroughly before executing it on your system, as it may cause harm to your system.
> I have not tested this configuration on Linux distributions other than openSUSE Trumbleweed, so use it
> with caution, but it should work. 

> [!NOTE]
> I am using GNU Stow, because it requires the least hustle to use, if you never used it before I recommend reading about it [here](https://www.gnu.org/software/stow/).

Install openSUSE Tumbleweed as a server or a desktop environment with GNOME or KDE, both should work with the script. using it on previously 
installed desktop should work but will change whatever you currently have (gtk/qt theming, shell, sddm, grub, etc) and is at your own risk.

Clone and execute -

```shell
screen
sudo -vvv zypper up
git clone https://github.com/Pavel-Hrdina/dotfile.git ~/.dotfiles
# TODO: Create an installation script
```

> [!TIP]
> Don't hesitate to modify the script


