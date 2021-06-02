Initial Setup
==============

::

 cd $HOME 
 sudo apt-get install exuberant-ctags silversearcher-ag
 git clone git@github.com:blc56/linux_essentials.git linux_essentials
 rm .bashrc
 ln -s linux_essentials/bashrc .bashrc
 ln -s linux_essentials/screenrc .screenrc
 ln -s linux_essentials/ctags .ctags
 ln -s linux_essentials/vimrc .vimrc
 # OR, use this for a non_dev setup
 ln -s linux_essentials/vimrc_non_dev .vimrc

 source ~/.bashrc

Ubuntu 18.04 Specifics
========================

vim 
------------------------

::

 sudo apt-get install vim-gtk3

Ubuntu 20.04 Specifics
========================

NeoVim
------

::

    sudo add-apt-repository ppa:neovim-ppa/unstable
    ln -s ~/linux_essentials/nvimrc ~/.config/nvim/init.vim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

Vim 
====

Backup files
-------------

::

 mkdir -p ~/.tmp/vim_backups

EasyTags
---------

This is not needed for the "non_dev" setup.

Install jsctags: https://github.com/ramitos/jsctags

First we install nodejs.

::

 sudo apt-get install nodejs npm

Finally we can install jsctags

::

 sudo su -
 umask 022
 npm install -g git+https://github.com/ramitos/jsctags.git

Bundle Setup
-------------

::

 cd $HOME
 git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim



Open vim. 

Run this in command mode.

::

 :PluginInstall

DeoComplete
-----------

::

 pip3 install --user pynvim


TagBar
------

This is not needed for the "non_dev" setup.

Get tagbar working with jsctags

::

 cd ~/.vim/bundle/tern_for_vim
 umask 022
 npm install
 umask 077


FZF File Finder
---------------

::

 cd ~/.vim/bundle/fzf
 ./install --all --no-completion

Git Tab Completion
------------------
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash

VS Code/ NeoVim
===============

::

    ln -s ~/linux_essentials_git/vscode/keybindings.json ~/.config/Code/User/
    ln -s ~/linux_essentials_git/vscode/settings.json ~/.config/Code/User/

