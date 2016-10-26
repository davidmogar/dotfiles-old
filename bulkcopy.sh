#!/usr/bin/env bash

echo "Let's go for a ride. Select what you want:"

read -p "- tmux? [y/n] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  cp -R .tmux.conf ~
fi

echo
read -p "- vim? [y/n] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  cp -R .vim .vimrc ~
fi

echo -e "\nDone!"
