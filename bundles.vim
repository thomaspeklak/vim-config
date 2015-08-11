" let Vundle manage Vundle
" required! 
" Bundle 'gmarik/vundle' "This does not work yet with submodules

Bundle 'gmarik/vundle'

" original repos on github
Bundle 'L9'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Rename'
Bundle 'Tabular'
Bundle 'closetag.vim'
Bundle 'kana/vim-textobj-user'
Bundle 'kien/ctrlp.vim'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'othree/html5.vim'
Bundle 'pix/vim-align'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'sickill/vim-pasta'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'wzzrd/vim-matchit'
Bundle 'spf13/PIV'
Bundle "kana/vim-textobj-entire"
Bundle "kana/vim-textobj-line"
Bundle "tpope/vim-ragtag"
Bundle "nelstrom/vim-visual-star-search"
Bundle "sjl/threesome.vim"
Bundle "sjl/vitality.vim"
Bundle "LanguageTool"
Bundle "sudo.vim"
Bundle "panozzaj/vim-autocorrect"
Bundle "majutsushi/tagbar"
Bundle "Arkham/vim-web-indent"
Bundle "vim-ruby/vim-ruby"
Bundle "tpope/vim-tbone"
Bundle "yueyoum/vim-linemovement"
Bundle "terryma/vim-expand-region"
Bundle "hail2u/vim-css-syntax"
Bundle "csscomb/csscomb-for-vim"

"JAVASCRIPT
Bundle 'leshill/vim-json'
Bundle 'itspriddle/vim-jquery'
Bundle "myhere/vim-nodejs-complete"

Bundle "mattn/jscomplete-vim" 
Bundle "walm/jshint.vim"
Bundle "drslump/vim-syntax-js"
Bundle "pangloss/vim-javascript"
Bundle "marijnh/tern_for_vim"
Bundle "othree/javascript-libraries-syntax.vim"
Bundle "moll/vim-node"
Bundle "tpope/vim-jdaddy"

"AUTOCOMPLETE
Bundle "mattn/emmet-vim"
Bundle "Valloric/YouCompleteMe"
Bundle "sirver/ultisnips"

"SYNTAX
Bundle "groenewege/vim-less"
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'tpope/vim-markdown'
Bundle "digitaltoad/vim-jade"

"COLORSCHEMES
Bundle 'altercation/vim-colors-solarized'
Bundle 'molokai'
Bundle "Lucius"
Bundle "chriskempson/base16-vim"


"Experimental
Bundle "airblade/vim-gitgutter"
Bundle "aklt/plantuml-syntax"
Bundle "tpope/vim-vinegar"
Bundle "AndrewRadev/splitjoin.vim"
Bundle "fatih/vim-go"
Bundle "talek/obvious-resize"
Bundle "losingkeys/vim-niji"
Bundle "bling/vim-airline"
Bundle "jgdavey/tslime.vim"
Bundle "jaxbot/browserlink.vim"
Bundle "heavenshell/vim-jsdoc"
Bundle "editorconfig/editorconfig-vim"
Bundle "jsx/jsx.vim"
Bundle "junegunn/vim-peekaboo"
Bundle "guns/vim-sexp"
Bundle "unblevable/quick-scope"

"Clojure
Bundle "VimClojure"
Bundle "tpope/vim-fireplace"
Bundle "venantius/vim-cljfmt"
Bundle "tpope/vim-leiningen"
Bundle "tpope/vim-projectionist"
Bundle "tpope/vim-dispatch"


" non github repos

if has("gui_running")
  Bundle "matthias-guenther/hammer.vim"
  Bundle "XDebug-DBGp-client-for-PHP"
endif

" BUNDLES ARCHIVE {{{
"Bundle "ryanoasis/vim-devicons"
"  Bundle 'ervandew/supertab'
"  Bundle "kana/vim-smartinput"
"  Bundle 'ervandew/supertab'
"  Bundle 'vim-stylus'
"  Bundle 'css_color.vim'
"  Bundle 'git://git.wincent.com/command-t.git'
"  Bundle 'c9s/cascading.vim'
"  Bundle 'juvenn/mustache.vim'
"  Bundle 'comment.vim'
"  Bundle 'kien/rainbow_parentheses.vim'
"  Bundle 'Lokaltog/vim-powerline'
"  Bundle 'YankRing.vim'  This currently completly broken c-p does not work,
"Bundle 'AutoTag'
"Bundle 'The-NERD-tree'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-cucumber'
"Bundle 'tpope/vim-pathogen'
"Bundle 'tpope/vim-rails'
"Bundle 'tpope/vim-rake'
"Bundle 'vlmonk/vim-rspec'
"Bundle "ZoomWin"
"Bundle "Gist.vim"
"Bundle 'stephpy/vim-php-cs-fixer'
"Bundle "chreekat/vim-paren-crosshairs"
"Bundle "ecomba/vim-ruby-refactoring"
"Bundle "vim-scripts/Tag-Signature-Balloons"
"Bundle ahayman/vim-nodejs-complete 
"Bundle "venantius/vim-eastwood"
"Bundle "wellle/tmux-complete.vim"
"Bundle "gavinbeatty/dragvisuals.vim"
"Bundle 'tpope/vim-haml'
"Bundle "honza/vim-snippets"
"Bundle "Shougo/neosnippet"
"Bundle "Shougo/neocomplete"
"Bundle "rstacruz/vim-ultisnips-css"
"Bundle "terryma/vim-multiple-cursors"
"Bundle "2072/PHP-Indenting-for-VIm"
"  overwrites @...
" }}}

