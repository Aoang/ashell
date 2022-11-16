#!/bin/bash

if command -v zsh &>/dev/null && command -v git &>/dev/null && command -v wget &>/dev/null; then
  echo -e "ZSH and Git are already installed\n"
else
  if sudo apt install -y zsh git wget || sudo pacman -S zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || sudo brew install git zsh wget || pkg install git zsh wget; then
    echo -e "zsh wget and git Installed\n"
  else
    echo -e "Please install the following packages first, then try again: zsh git wget \n" && exit
  fi
fi

# Update package manager and install nano git curl wget zsh
case "$1" in
debian | ubuntu)
  sudo apt update -y && sudo apt upgrade -y && sudo apt install -y nano git curl wget zsh
  ;;
arch)
  sudo pacman -Syu && sudo pacman -S nano git curl wget zsh
  ;;
centos)
  sudo yum update -y && sudo yum install -y nano git curl wget zsh
  ;;
macos)
  brew install nano git curl wget zsh
  ;;
*)
  brew install nano git curl wget zsh || sudo yum install -y nano git curl wget zsh ||
    sudo apt install -y nano git curl wget zsh || sudo pacman -S nano git curl wget zsh
  ;;
esac

if [ -d ~/.config/ashell ]; then
  echo -e "???\n"
else
  git clone --depth=1 https://github.com/Aoang/ashell ~/.config/ashell && cd ~/.config/ashell && sudo chmod +x install.sh && bash install.sh
fi
