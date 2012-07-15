#VIM Config

##Installation

    git clone https://github.com/thomaspeklak/vim-config.git ~/.vim
    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    cd ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    touch ~/.vim/vimrc_local
    (sudo) gem install github-markup RedCloth
    vim +BundleInstall +qall

##Vimrc local

Use the vimrc_local file to override any settings or to configure private information, e.g. Twitter account for TwitVim

##Updating bundles

Use `:BundleInstall!` to update your bundles. Vundle itself is used as a submodule and cannot be updated with this process. To update vundle go into bundle/vundle and enter `git pull origin master`

##FAQ

__Ctags is missing__  
You need exuberant-ctags installed, otherwise there will be an error. You
can do this with `sudo apt-get install exuberant-ctags`or `brew install
ctags`

__Rake is missing__  
rake is not installed. Install rake with `sudo gem install rake`

__256 colors in terminal__  
For terminal usage, turn on 256 colors with the following code in ~/.profile

    if [ -e /usr/share/terminfo/x/xterm-256color ]; then  
      export TERM='xterm-256color'  
    else  
      export TERM='xterm-color'  
    fi  
