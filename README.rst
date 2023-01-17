Initial Setup
==============

::

 cd $HOME
 sudo apt-get install exuberant-ctags silversearcher-ag
 git clone git@github.com:blc56/linux_essentials.git linux_essentials_git
 rm .bashrc
 ln -s linux_essentials_git/bashrc .bashrc
 # mac only
 #ln -s linux_essentials_git/bash_profile_mac .bash_profile
 ln -s linux_essentials_git/screenrc .screenrc
 ln -s linux_essentials_git/ctags .ctags
 ln -s linux_essentials_git/vimrc .vimrc

 source ~/.bashrc

Arch Linux Specifics
========================

NeoVim
------

::

        # get neovim working with system copy/paste clipboard
        yay -S xclip

Ubuntu 20.04 Specifics
========================

NeoVim
------

::

        sudo add-apt-repository ppa:neovim-ppa/unstable
        # linux
        mkdir -p ~/.config/nvim/
        ln -s ~/linux_essentials_git/nvimrc ~/.config/nvim/init.vim
        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
Windows Specifics
========================

NeoVim
------

::

        iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

*Note* Run :PlugInstall in powershell. It will not work from git-bash

Mac
========================
Install an updated version of bash
----------------------------------
https://apple.stackexchange.com/a/400546
::

        brew update && brew install bash fd htop psgrep
        sudo chsh -s /opt/homebrew/bin/bash $(whoami)

Vim
====

Backup files
-------------

::

 mkdir -p ~/.tmp/vim_backups

Bundle Setup
-------------

Follow the instructions here: https://github.com/junegunn/vim-plug

Open vim.

Run this in command mode.

::

 :PluginInstall

Git Tab Completion
------------------
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash

VS Code/ NeoVim
===============

Run neovim with the vscode config file and run ``:PlugInstall``

::
    nvim -u ~/linux_essentials_git/vscode_neovim_rc

Git
===

::

        git config --global core.pager "nvim -R"
        # fix colors in git log, etc https://vi.stackexchange.com/a/16593
        git config --global color.pager no
        # use less as a pager for git branch
        git config --global pager.branch "less -F -X"

        # https://stackoverflow.com/a/44549734
        git config --global merge.tool vscode
        git config --global mergetool.vscode.cmd 'code --new-window --wait $MERGED'
        git config --global diff.tool vscode
        git config --global diff.guitool vscode
        git config --global difftool.vscode.cmd 'COMPARE_FOLDERS=DIFF code --new-window --wait --diff $LOCAL $REMOTE'

