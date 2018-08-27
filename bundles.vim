" let Vundle manage Vundle
" required! 
" Plug 'gmarik/vundle' "This does not work yet with submodules

call plug#begin('~/.vim/plugged')

" original repos on github
Plug 'vim-scripts/L9'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-scripts/Rename'
Plug 'vim-scripts/Tabular'
Plug 'vim-scripts/closetag.vim'
Plug 'kana/vim-textobj-user'
Plug 'kien/ctrlp.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'othree/html5.vim'
Plug 'pix/vim-align'
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'gcorne/vim-sass-lint'
Plug 'sickill/vim-pasta'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wzzrd/vim-matchit'
Plug 'spf13/PIV'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'tpope/vim-ragtag'
Plug 'nelstrom/vim-visual-star-search'
Plug 'sjl/threesome.vim'
Plug 'sjl/vitality.vim'
Plug 'vim-scripts/LanguageTool'
Plug 'vim-scripts/sudo.vim'
Plug 'panozzaj/vim-autocorrect'
Plug 'majutsushi/tagbar'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-tbone'
Plug 'yueyoum/vim-linemovement'
Plug 'terryma/vim-expand-region'
Plug 'hail2u/vim-css-syntax', { 'for': ['css', 'less', 'scss'] }
Plug 'csscomb/csscomb-for-vim', { 'for': ['css', 'less', 'scss'] }

"JAVASCRIPT
Plug 'elzr/vim-json'
Plug 'myhere/vim-nodejs-complete'

Plug 'mattn/jscomplete-vim' 
"Plug 'drslump/vim-syntax-js'
Plug 'pangloss/vim-javascript'
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'moll/vim-node'
Plug 'heavenshell/vim-jsdoc'
"Plug 'tpope/vim-jdaddy'

"REACT
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

"AUTOCOMPLETE
Plug 'mattn/emmet-vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'sirver/ultisnips'

"SYNTAX
Plug 'vim-scripts/SyntaxComplete'
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'digitaltoad/vim-jade', { 'for': 'jade' }

"COLORSCHEMES
Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/molokai'
Plug 'vim-scripts/Lucius'
Plug 'chriskempson/base16-vim'

"ELM
Plug 'lambdatoast/elm.vim', { 'for': 'elm' }

"Experimental
Plug 'airblade/vim-gitgutter'
Plug 'aklt/plantuml-syntax'
Plug 'tpope/vim-vinegar'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'talek/obvious-resize'
Plug 'losingkeys/vim-niji'
Plug 'bling/vim-airline'
Plug 'jgdavey/tslime.vim'
Plug 'jaxbot/browserlink.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'mxw/vim-jsx'
Plug 'junegunn/vim-peekaboo'
Plug 'guns/vim-sexp'
Plug 'unblevable/quick-scope'
Plug 'christoomey/vim-sort-motion'

Plug 'thiagoalessio/rainbow_levels.vim'

"Clojure
Plug 'vim-scripts/VimClojure', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'venantius/vim-cljfmt', { 'for': 'clojure' }
Plug 'tpope/vim-leiningen', { 'for': 'clojure' }
Plug 'tpope/vim-projectionist', { 'for': 'clojure' }
Plug 'tpope/vim-dispatch', { 'for': 'clojure' }

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

"Typescript
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
"Plug 'clausreinke/typescript-tools.vim'


" BUNDLES ARCHIVE {{{
"Plug 'ryanoasis/vim-devicons'
"  Plug 'ervandew/supertab'
"  Plug 'kana/vim-smartinput'
"  Plug 'ervandew/supertab'
"  Plug 'vim-stylus'
"  Plug 'css_color.vim'
"  Plug 'git://git.wincent.com/command-t.git'
"  Plug 'c9s/cascading.vim'
"  Plug 'juvenn/mustache.vim'
"  Plug 'comment.vim'
"  Plug 'kien/rainbow_parentheses.vim'
"  Plug 'Lokaltog/vim-powerline'
"  Plug 'YankRing.vim'  This currently completly broken c-p does not work,
"Plug 'AutoTag'
"Plug 'The-NERD-tree'
"Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
"Plug 'tpope/vim-cucumber'
"Plug 'tpope/vim-pathogen'
"Plug 'tpope/vim-rails'
"Plug 'tpope/vim-rake'
"Plug 'vlmonk/vim-rspec'
"Plug 'ZoomWin'
"Plug 'Gist.vim'
"Plug 'stephpy/vim-php-cs-fixer'
"Plug 'chreekat/vim-paren-crosshairs'
"Plug 'ecomba/vim-ruby-refactoring'
"Plug 'vim-scripts/Tag-Signature-Balloons'
"Plug ahayman/vim-nodejs-complete 
"Plug 'venantius/vim-eastwood'
"Plug 'wellle/tmux-complete.vim'
"Plug 'gavinbeatty/dragvisuals.vim'
"Plug 'tpope/vim-haml'
"Plug 'honza/vim-snippets'
"Plug 'Shougo/neosnippet'
"Plug 'Shougo/neocomplete'
"Plug 'rstacruz/vim-ultisnips-css'
"Plug 'terryma/vim-multiple-cursors'
"Plug '2072/PHP-Indenting-for-VIm'
"  overwrites @...
" }}}

call plug#end()
