Initial Setup
==============

::

 cd $HOME 
 sudo apt-get install exuberant-ctags
 git clone git@github.com:blc56/linux_essentials.git linux_essentials
 rm .bashrc
 ln -s linux_essentials/bashrc .bashrc
 ln -s linux_essentials/screenrc .screenrc
 ln -s linux_essentials/ctags .ctags
 ln -s linux_essentials/vimrc .vimrc
 # OR, use this for a non_dev setup
 ln -s linux_essentials/vimrc_non_dev .vimrc

 source ~/.bashrc

Ubuntu 16.04 Specifics
========================

vim with pyton2 support
------------------------

::

 sudo apt-get install vim-nox-py2

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

 cd /tmp
 # for debian
 curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
 # for redhat
 curl -sL https://rpm.nodesource.com/setup_6.x -o nodesource_setup.sh
 # set umask or else /etc/apt/sources.list.d/nodesource.list will not be readable by "o" and apt will complain
 sudo bash -c 'umask 022 && nodesource_setup.sh'
 rm nodesource_setup.sh
 sudo apt-get install nodejs

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

 :BundleInstall

YouCompleteMe
--------------

This is not needed for the "non_dev" setup.

From: https://valloric.github.io/YouCompleteMe/#ubuntu-linux-x64

::

 sudo apt-get install build-essential cmake python-dev python3-dev
 cd ~/.vim/bundle/YouCompleteMe
 ./install.py --clang-completer


TagBar
------

This is not needed for the "non_dev" setup.

Get tagbar working with jsctags

::

 cd ~/.vim/bundle/tern_for_vim
 umask 022
 npm install
 umask 077

Git Tab Completion
------------------
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash


