" let Vundle manage Vundle
" required! 
" Bundle 'gmarik/vundle' "This does not work yet with submodules

Bundle 'gmarik/vundle'

" original repos on github
Bundle 'AutoTag'
Bundle 'L9'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Rename'
Bundle 'Tabular'
Bundle 'The-NERD-tree'
Bundle 'YankRing.vim'
Bundle 'closetag.vim'
Bundle 'kana/vim-textobj-user'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'othree/html5.vim'
Bundle 'pix/vim-align'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'sickill/vim-pasta'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-pathogen'
"Bundle 'tpope/vim-rails'
"Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'vlmonk/vim-rspec'
Bundle 'wzzrd/vim-matchit'
Bundle 'spf13/PIV'
Bundle "kana/vim-textobj-entire"
Bundle "kana/vim-textobj-line"
Bundle "tpope/vim-ragtag"
Bundle "nelstrom/vim-visual-star-search"
Bundle "ZoomWin"
Bundle "Gist.vim"
Bundle "sjl/threesome.vim"
Bundle "sjl/vitality.vim"
Bundle "LanguageTool"
Bundle 'stephpy/vim-php-cs-fixer'
Bundle "sudo.vim"
Bundle "panozzaj/vim-autocorrect"
"Bundle "chreekat/vim-paren-crosshairs"
Bundle "majutsushi/tagbar"
Bundle "Arkham/vim-web-indent"
Bundle "ecomba/vim-ruby-refactoring"
Bundle "vim-ruby/vim-ruby"
Bundle "vim-scripts/Tag-Signature-Balloons"
Bundle "tpope/vim-tbone"
Bundle "yueyoum/vim-linemovement"
Bundle "terryma/vim-expand-region"
Bundle "terryma/vim-multiple-cursors"
Bundle "hail2u/vim-css-syntax"
Bundle "csscomb/csscomb-for-vim"

"JAVASCRIPT
Bundle 'leshill/vim-json'
Bundle 'itspriddle/vim-jquery'
Bundle "myhere/vim-nodejs-complete"
"Bundle "teramako/jscomplete-vim" "currently broken with neocomplcach
Bundle "walm/jshint.vim"
Bundle "drslump/vim-syntax-js"
Bundle "pangloss/vim-javascript"
Bundle "marijnh/tern_for_vim"

"AUTOCOMPLETE
Bundle "mattn/emmet-vim"
"Bundle "honza/vim-snippets"
"Bundle "Shougo/neosnippet"
"Bundle "Shougo/neocomplete"
Bundle "Valloric/YouCompleteMe"
Bundle "SirVer/ultisnips"
Bundle "rstacruz/vim-ultisnips-css"

"SYNTAX
Bundle "groenewege/vim-less"
Bundle 'cakebaker/scss-syntax.vim'
"Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
"Bundle 'groenewege/vim-less'
Bundle "digitaltoad/vim-jade"
Bundle "VimClojure"
Bundle "2072/PHP-Indenting-for-VIm"

"COLORSCHEMES
Bundle 'altercation/vim-colors-solarized'
Bundle 'molokai'
Bundle "Lucius"
Bundle "chriskempson/base16-vim"


"Experimental
Bundle "airblade/vim-gitgutter"
Bundle "gavinbeatty/dragvisuals.vim"
"
"
" non github repos

if has("gui_running")
  Bundle "matthias-guenther/hammer.vim"
  Bundle "XDebug-DBGp-client-for-PHP"
endif

" BUNDLES ARCHIVE {{{
"  Bundle 'ervandew/supertab'
"  Bundle "kana/vim-smartinput"
"  Bundle 'ervandew/supertab'
"  Bundle 'vim-stylus'
"  Bundle 'css_color.vim'
"  Bundle 'git://git.wincent.com/command-t.git'
"  Bundle 'c9s/cascading.vim'
"  Bundle 'juvenn/mustache.vim'
"  Bundle 'comment.vim'
" }}}

