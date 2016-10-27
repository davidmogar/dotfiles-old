#!/usr/bin/env bash

CMD_APT_GET=$(which apt-get)
CMD_YUM=$(which yum)
PLAYGROUND=~/playground

# Prepare playground

echo "[1] Preparing playground..."

if [ -d "$PLAYGROUND" ]; then
  backup_dir="${PLAYGROUND}.$(date +%s)"
  mkdir "${backup_dir}"
  mv "${PLAYGROUND}"/* "${backup_dir}"
  rm -rf "${PLAYGROUND}"
fi

mkdir -p ~/"${PLAYGROUND}"/git
git clone https://github.com/davidmogar/dotfiles.git "${PLAYGROUND}"/dotfiles
git clone https://github.com/davidmogar/scripts.git "${PLAYGROUND}"/scripts

echo "[1] Done!"

# Get gnome-terminal colors

echo -e "\n[2] Preparing terminal..."

if [ $(ps -p$PPID | grep gnome-terminal | wc -l) -gt  0 ]; then
  echo "Gnome terminal found. Fetching terminal colors..."
  git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git ~
  cd ~/gnome-terminal-colors-solarized
  ./install.sh
  cd ~ && rm -rf ~/gnome-terminal-colors-solarized
fi

echo "[2] Done!"

# Install packages

echo -e "\n[3] Installing packages (Running as su)..."

while getopts ":i" opt; do
  case $opt in
    i)
      if [[ ! -z $CMD_YUM ]]; then
        su - -c "yum -y install git"
        su - -c "yum -y install python"
        su - -c "yum -y install vim"
        su - -c "yum -y install zsh"
      elif [[ ! -z $CMD_APT_GET ]]; then
        sudo apt-get -y install git
        sudo apt-get -y install python
        sudo apt-get -y install vim
        sudo apt-get -y install zsh
      fi
  esac
done

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

DOTFILES="${PLAYGROUND}"/dotfiles/
cp -R "${DOTFILES}".tmux.conf ~     # tmux
cp -R "${DOTFILES}".vim* ~          # vim
cp -R "${DOTFILES}".zsh* ~          # zsh

echo "[6] Done!"
