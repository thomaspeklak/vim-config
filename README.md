#VIM Config

##Installation

    git clone https://github.com/thomaspeklak/vim-config.git ~/.vim
    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle
    cd ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    vim +BundleInstall +qall
    cd bundle/command-t
    rvm use 1.8.7     # use the ruby version vim was compiled against
    rake make
    touch ~/.vim/vimrc_local

##Vimrc local

Use the vimrc_local file to override any settings or to configure private information, e.g. Twitter account for TwitVim

##Updating bundles

Use `:BundleInstall!` to update your bundles. Vundle itself is used as a submodule and cannot be updated with this process. To update vundle go into bundle/vundle and enter `git pull origin master`
