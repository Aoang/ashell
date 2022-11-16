#!/bin/bash

if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d"); then # backup .zshrc
  echo -e "Backed up the current .zshrc to .zshrc-backup-date\n"
fi

mkdir -p ~/.config/ashell # the setup will be installed in here

if [ -d ~/.quickzsh ]; then
  echo -e "\n PREVIOUS SETUP FOUND AT '~/.quickzsh'. PLEASE MANUALLY MOVE ANY FILES YOU'D LIKE TO '~/.config/ashell' \n"
fi

echo -e "Installing oh-my-zsh\n"
if [ -d ~/.config/ashell/oh-my-zsh ]; then
  echo -e "oh-my-zsh is already installed\n"
  git -C ~/.config/ashell/oh-my-zsh remote set-url origin https://github.com/ohmyzsh/ohmyzsh.git
elif [ -d ~/.oh-my-zsh ]; then
  echo -e "oh-my-zsh in already installed at '~/.oh-my-zsh'. Moving it to '~/.config/ashell/oh-my-zsh'"
  export ZSH="$HOME/.config/ashell/oh-my-zsh"
  mv ~/.oh-my-zsh ~/.config/ashell/oh-my-zsh
  git -C ~/.config/ashell/oh-my-zsh remote set-url origin https://github.com/ohmyzsh/ohmyzsh.git
else
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.config/ashell/oh-my-zsh
fi

cp -f .zshrc ~/

mkdir -p ~/.config/ashell/zshrc # PLACE YOUR ZSHRC CONFIGURATIONS OVER THERE
mkdir -p ~/.cache/zsh/          # this will be used to store .zcompdump zsh completion cache files which normally clutter $HOME

if [ -f ~/.zcompdump ]; then
  mv ~/.zcompdump* ~/.cache/zsh/
fi

if [ -d ~/.config/ashell/oh-my-zsh/plugins/zsh-autosuggestions ]; then
  cd ~/.config/ashell/oh-my-zsh/plugins/zsh-autosuggestions && git pull
else
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.config/ashell/oh-my-zsh/plugins/zsh-autosuggestions
fi

if [ -d ~/.config/ashell/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  cd ~/.config/ashell/oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
else
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/ashell/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if [ -d ~/.config/ashell/oh-my-zsh/custom/plugins/zsh-completions ]; then
  cd ~/.config/ashell/oh-my-zsh/custom/plugins/zsh-completions && git pull
else
  git clone --depth=1 https://github.com/zsh-users/zsh-completions ~/.config/ashell/oh-my-zsh/custom/plugins/zsh-completions
fi

if [ -d ~/.config/ashell/oh-my-zsh/custom/plugins/zsh-history-substring-search ]; then
  cd ~/.config/ashell/oh-my-zsh/custom/plugins/zsh-history-substring-search && git pull
else
  git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search ~/.config/ashell/oh-my-zsh/custom/plugins/zsh-history-substring-search
fi

# INSTALL FONTS

echo -e "Installing Nerd Fonts version of Hack, Roboto Mono, DejaVu Sans Mono\n"

wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/

fc-cache -fv ~/.fonts

if [ -d ~/.config/ashell/oh-my-zsh/custom/themes/powerlevel10k ]; then
  cd ~/.config/ashell/oh-my-zsh/custom/themes/powerlevel10k && git pull
else
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/ashell/oh-my-zsh/custom/themes/powerlevel10k
fi

if [ -d ~/.~/.config/ashell/fzf ]; then
  cd ~/.config/ashell/fzf && git pull
  ~/.config/ashell/fzf/install --all --key-bindings --completion --no-update-rc
else
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.config/ashell/fzf
  ~/.config/ashell/fzf/install --all --key-bindings --completion --no-update-rc
fi

if [ -d ~/.config/ashell/oh-my-zsh/custom/plugins/k ]; then
  cd ~/.config/ashell/oh-my-zsh/custom/plugins/k && git pull
else
  git clone --depth 1 https://github.com/supercrabtree/k ~/.config/ashell/oh-my-zsh/custom/plugins/k
fi

if [ -d ~/.config/ashell/marker ]; then
  cd ~/.config/ashell/marker && git pull
else
  git clone --depth 1 https://github.com/jotyGill/marker ~/.config/ashell/marker
fi

if ~/.config/ashell/marker/install.py; then
  echo -e "Installed Marker\n"
else
  echo -e "Marker Installation Had Issues\n"
fi

# if git clone --depth 1 https://github.com/todotxt/todo.txt-cli.git ~/.config/ashell/todo; then :
# else
#     cd ~/.config/ashell/todo && git fetch --all && git reset --hard origin/master
# fi
# mkdir ~/.config/ashell/todo/bin ; cp -f ~/.config/ashell/todo/todo.sh ~/.config/ashell/todo/bin/todo.sh # cp todo.sh to ./bin so only it is included in $PATH
# #touch ~/.todo/config     # needs it, otherwise spits error , yeah a bug in todo
# ln -s ~/.config/ashell/todo ~/.todo
if [ ! -L ~/.config/ashell/todo/bin/todo.sh ]; then
  echo -e "Installing todo.sh in ~/.config/ashell/todo\n"
  mkdir -p ~/.config/ashell/bin
  mkdir -p ~/.config/ashell/todo
  wget -q --show-progress "https://github.com/todotxt/todo.txt-cli/releases/download/v2.12.0/todo.txt_cli-2.12.0.tar.gz" -P ~/.config/ashell/
  tar xvf ~/.config/ashell/todo.txt_cli-2.12.0.tar.gz -C ~/.config/ashell/todo --strip 1 && rm ~/.config/ashell/todo.txt_cli-2.12.0.tar.gz
  ln -s -f ~/.config/ashell/todo/todo.sh ~/.config/ashell/bin/todo.sh # so only .../bin is included in $PATH
  ln -s -f ~/.config/ashell/todo/todo.cfg ~/.todo.cfg                 # it expects it there or ~/todo.cfg or ~/.todo/config
else
  echo -e "todo.sh is already instlled in ~/.config/ashell/todo/bin/\n"
fi

if [[ $1 == "--cp-hist" ]] || [[ $1 == "-c" ]]; then
  echo -e "\nCopying bash_history to zsh_history\n"
  if command -v python &>/dev/null; then
    wget -q --show-progress https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
    cat ~/.bash_history | python bash-to-zsh-hist.py >>~/.zsh_history
  else
    if command -v python3 &>/dev/null; then
      wget -q --show-progress https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
      cat ~/.bash_history | python3 bash-to-zsh-hist.py >>~/.zsh_history
    else
      echo "Python is not installed, can't copy bash_history to zsh_history\n"
    fi
  fi
else
  echo -e "\nNot copying bash_history to zsh_history, as --cp-hist or -c is not supplied\n"
fi

ZDOTDIR="~/.config/ashell/zshrc"
if [ ! -d $ZDOTDIR ]; then
  mkdir -p $ZDOTDIR
fi

# install neofetch
wget -O ~/.config/ashell/bin/neofetch https://github.com/dylanaraps/neofetch/raw/master/neofetch && chmod +x ~/.config/ashell/bin/neofetch

# source ~/.zshrc
echo -e "\nYou Need run those things:\n"
echo -e "\n"
echo "- chsh -s $(grep /zsh$ /etc/shells | tail -1)"
echo "- /bin/zsh -i -c 'omz update'"

#if chsh -s $(grep /zsh$ /etc/shells | tail -1) && /bin/zsh -i -c 'omz update'; then
#    echo -e "Installation Successful, exit terminal and enter a new session"
#else
#    echo -e "Something is wrong"
#fi
exit
