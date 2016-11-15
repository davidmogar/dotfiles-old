#!/usr/bin/env bash

PLAYGROUND=~/playground

packages="git i3 i3blocks irssi python python-dbus remmina rxvt-unicode tmux vim zsh"

# Prepare playground

echo "[1] Preparing playground..."

if [ -d "$PLAYGROUND" ]; then
  backup_dir="${PLAYGROUND}.$(date +%s)"
  mkdir "${backup_dir}"
  mv "${PLAYGROUND}"/* "${backup_dir}"
  rm -rf "${PLAYGROUND}"
fi

mkdir -p "${PLAYGROUND}"/git
git clone https://github.com/davidmogar/dotfiles.git "${PLAYGROUND}"/dotfiles
git clone https://github.com/davidmogar/scripts.git "${PLAYGROUND}"/scripts

echo "[1] Done!"

# Get gnome-terminal colors

echo -e "\n[2] Preparing terminal..."

if [ $(ps -A | egrep -i gnome-terminal | wc -l) -gt  0 ]; then
  echo "Gnome terminal found. Fetching terminal colors..."
  git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git "${PLAYGROUND}"/gtcs
  cd "${PLAYGROUND}"/gtcs
  ./install.sh --scheme dark --install-dircolors
  cd ~ && rm -rf "${PLAYGROUND}"/gtcs
fi

echo "[2] Done!"

# Install packages

echo -e "\n[3] Installing packages (Running as su)..."

sudo sh -c "echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" >> /etc/apt/sources.list"
sudo apt-get update
sudo apt-get --allow-unauthenticated install sur5r-keyring
sudo apt-get update
sudo apt-get -y install $packages

echo "[3] Done!"

# Set git globals

echo -e "\n[4] Setting git globals..."

git config --global core.editor vim
git config --global push.default simple
git config --global user.name "David Moreno García"
git config --global user.email david.mogar@gmail.com

echo "[4] Done!"

# Install Oh My Zsh

echo -e "\n[5] Installing Oh My Zsh..."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "[5] Done!"

# Copy dotfiles

echo -e "\n[6] Copying dotfiles..."

mkdir ~/.config

DOTFILES="${PLAYGROUND}"/dotfiles/
cp -R "${DOTFILES}".fehbg ~/.febg               # fehbg
cp -R "${DOTFILES}".i3 ~/.config/i3             # i3
cp -R "${DOTFILES}".i3blocks ~/.config/i3blocks # i3blocks
cp -R "${DOTFILES}".tmux.conf ~                 # tmux
cp -R "${DOTFILES}".vim* ~                      # vim
cp -R "${DOTFILES}".xproperties ~               # xproperties (xrandr)
cp -R "${DOTFILES}".zsh* ~                      # zsh
cp -R "${DOTFILES}".Xdefaults ~                 # Xdefaults (urxvt)

echo "[6] Remember to update ~/.fehbg with the path to your wallpaper"
echo "[6] You will also have to update ~/.xproperties and ~/.config/.i3/config with valid values for your monitors"
echo "[6] Done!"
