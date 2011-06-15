#VIM Config

##Installation

    git clone https://github.com/thomaspeklak/vim-config.git ~/.vim
    cd ~/.vim
    git submodule init
    git submodule update
    ln -s vimrc ~/.vimrc
    cd bundle/command-t
    rvm use 1.8.7     # use the ruby version vim was compiled against
    rake make

##Updating bundles

Go to <https://github.com/thomaspeklak/VIM-Bundles-Update/blob/master/vim_bundles_update> and run the script.
