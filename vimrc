if has("gui_running")
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype on
runtime macros/matchit.vim
endif

let mapleader = ","

if has("gui_running")
  if has("autocmd")
    " Drupal *.module and *.install files.
    augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.phtml set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.tmpl set filetype=html
    autocmd BufRead,BufNewFile *.less set filetype=css
    autocmd BufRead,BufNewFile *.spec set filetype=ruby
    augroup END
  endif

  set nocompatible
  set viminfo^=!

  let g:miniBufExplMapWindowNavVim = 1
  let g:miniBufExplMapWindowNavArrows = 1
  let g:miniBufExplMapCTabSwitchBufs = 1
  let g:miniBufExplModSelTarget = 1

  syntax enable

  set modelines=0
  set scrolloff=4
  set showmode
  set showcmd
  set wildmenu
  set wildmode=list:longest
  set visualbell
  set cursorline
  set ttyfast
  set ruler
  set laststatus=2
  set relativenumber
  set guioptions-=T  "remove toolbar

  set showmatch                                                      " Show matching brackets.
  set mat=5                                                          " Bracket blinking.
  set history=10000                                                  " large history
  set undolevels=10000                                               " use many undos

  set nobackup                                                       " no backup file
  set noswapfile                                                     " no swap file

  vmap Q gq                                                          " us Q to format current paragraph
  nmap Q gqap

  function! Tabstyle_tabs()
    " Using 2 column tabs
    set softtabstop=2
    set shiftwidth=2
    set tabstop=2
    set noexpandtab
    autocmd User Rails set softtabstop=2
    autocmd User Rails set shiftwidth=2
    autocmd User Rails set tabstop=2
    autocmd User Rails set noexpandtab
  endfunction

  function! Tabstyle_spaces()
    " Use 2 spaces
    set softtabstop=2
    set shiftwidth=2
    set tabstop=2
    set expandtab
  endfunction

  call Tabstyle_spaces()

  " Indenting *******************************************************************
  set ai " Automatically set the indent of a new line (local to buffer)
  set si " smartindent (local to buffer)

  " Searching *******************************************************************
  set hlsearch  " highlight search
  set incsearch  " Incremental search, search as you type
  set ignorecase " Ignore case when searching
  set smartcase " Ignore case when searching lowercase
  set incsearch
  set showmatch

  " Colors **********************************************************************
  "set t_Co=256 " 256 colors
  set background=dark
  syntax on " syntax highlighting
  colorscheme blackboard


  " Shortcut to rapidly toggle `set list`
  nmap <leader>l :set list!<CR>

  set list

  " Use the same symbols as TextMate for tabstops and EOLs
  set listchars=tab:>\ ,eol:$
  set guifont=Mensch\ 9

  " Tabmovement like in FF
  map <C-1> 1gt
  map <C-2> 2gt
  map <C-3> 3gt
  map <C-4> 4gt
  map <C-5> 5gt
  map <C-6> 6gt
  map <C-7> 7gt
  map <C-8> 8gt
  map <C-9> 9gt
  map <C-0> :tablast<CR>

end


set hidden                                                           " allow vim to create hidden buffers

set backspace=indent,eol,start                                       " allow backspacing over everything in insert mode

" Preserve state after operation
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>                    " remove trailing white space

nmap <leader>= :call Preserve("normal gg=G")<CR>                      " indent lines
nmap <leader>0 gg=G

"automatically remove trailing whitespace
autocmd FocusLost *.py,*.js,*.rb,*.html,*.module,*.php,*.phtml,*.inc,*.tmpl,*.css,*.less,*.scss,*.ctp :call Preserve("%s/\\s\\+$//e")
autocmd BufWritePre *.py,*.js,*.rb,*.html,*.module,*.php,*.phtml,*.inc,*.tmpl,*.css,*.less,*.scss,*.ctp :call Preserve("%s/\\s\\+$//e")

"set encoding
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8 nobomb
  setglobal fileencoding=utf-8 nobomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

"open files in current path
map ,ew :e <C-R>=expand("%:p:h") . "/" <CR>
map ,es :sp <C-R>=expand("%:p:h") . "/" <CR>
map ,ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map ,et :tabe <C-R>=expand("%:p:h") . "/" <CR>

if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
endif

"Quickly edit and reload vimrc
nmap <slient> <leader>eV :e $MYVIMRC<CR>
nmap <slient> <leader>sV :so $MYVIMRC<CR>

"Switch between windows
map <C-H> <C-w>h
map <C-J> <C-w>j
map <C-K> <C-w>k
map <C-L> <C-w>l

nnoremap <leader>1 yypVr=
nnoremap <leader>2 yypVr-
nnoremap <leader>d yypVr
nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
nnoremap j gj
nnoremap k gk
nnoremap <F1> <ESC>
inoremap <F1> <ESC>
vnoremap <F1> <ESC>

au FocusLost * :wa                                                   " write file on focus lost

nnoremap <leader>ft Vatzf                                            " fold tag
nnoremap <leader>s ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>           " sort properties in css


" map esc to jj in insert mode to provide a way around photoshop bug blocking esc key
imap jj <ESC>

" map autocompletion to control-space
imap <C-space> <C-P>

" map :b# to accessible combination on german keyboard
nmap <C-tab> :b#<CR>
nmap <leader>, :b#<CR>

" map show next match (vimgrep)
nmap <leader>n :cn<CR>

" tag mappings
nnoremap ü <C-]>
nnoremap Ü <C-O>

" surround with char (needs surround plugin)
nmap <leader>" ysiw"
nmap <leader>' ysiw'
nmap <leader>( ysiw(
nmap <leader>[ ysiw[
nmap <leader>{ ysiw{
nmap <leader>< ysiw<
vmap <leader>" ys"
vmap <leader>' ys'
vmap <leader>( ys(
vmap <leader>[ ys[
vmap <leader>{ ys{
vmap <leader>< ys<

so ~/.vim/bundle/autotag/autotag.vim

nmap <leader>r :CommandTFlush<CR>
nmap <leader>t :CommandT<CR>
nmap <leader>b :CommandTBuffer<CR>
let g:CommandTMaxFiles=15000

nnoremap <leader>u :GundoToggle<CR>

"provide mappings to use clipboard
nnoremap <S-INSERT> "+gP
imap <S-INSERT> <ESC>"+gPi
vmap <C-C> "+y
vmap <leader>y "+y
nmap <leader>p "+gP
