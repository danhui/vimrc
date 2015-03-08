###About

For easy access to my vim configuration on both Windows and Linux.

###Dependencies

1. Exuberent Ctags
2. Git for plugin managers

###Installation instructions

To install on Linux:

    $ cd ~
    $ git clone https://github.com/danhui/vimrc.git .vim
    $ echo "runtime vimrc" > .vimrc
    $ vim +q


To install on Windows:

    $ cd %USERPROFILE%
    $ git clone https://github.com/danhui/vimrc.git vimfiles
    $ echo "runtime vimrc" > .vimrc
    $ vim +q

What these commands do:  
1. Switch to the home directory  
2. Clone from github  
3. Create a .vimrc and just point it towards vimrc  
4. Run vim once to setup the plugin manager and plugins and then quit  
