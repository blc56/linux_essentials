Vim 
====

EasyTags
---------

Install jsctags: https://github.com/ramitos/jsctags

First we install nodejs.

::

 cd /tmp
 curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
 sudo bash nodesource_setup.sh
 rm nodesource_setup.sh
 sudo apt-get install nodejs

Finally we can install jsctags

::

 cd ~/.npm/
 sudo chown -R <user>:<user> *
 sudo su -
 umask 022
 npm install -g git+https://github.com/ramitos/jsctags.git

Ubuntu 16.04 Specifics
========================

