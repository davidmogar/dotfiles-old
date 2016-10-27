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

if [[ ! -z $CMD_YUM ]]; then
  su - -c "yum -y install vim"
  su - -c "yum -y install zsh"
elif [[ ! -z $CMD_APT_GET ]]; then
  sudo apt-get -y install vim
  sudo apt-get -y install zsh
fi

echo "[3] Done!"

# Install Oh My Zsh

echo -e "\n[4] Installing Oh My Zsh..."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "[4] Done!"

# Copy dotfiles

echo -e "\n[5] Copying dotfiles..."

DOTFILES="${PLAYGROUND}"/dotfiles/
cp -R "${DOTFILES}".tmux.conf ~     # tmux
cp -R "${DOTFILES}".vim* ~          # vim

echo "[5] Done!"
