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
    augroup END

    autocmd BufRead,BufNewFile *.tmpl set filetype=html
    autocmd BufRead,BufNewFile *.less set filetype=css
    autocmd BufRead,BufNewFile *.spec set filetype=ruby

    "highlight JSON files as javascript
    autocmd BufRead,BufNewFile *.json set filetype=javascript
    "highlight jasmine_fixture files as HTML
    autocmd BufRead,BufNewFile *.jasmine_fixture set filetype=html
    au BufRead,BufNewFile Gemfile* set filetype=ruby 

    " set question mark to be part of a VIM word. in Ruby it is!
    autocmd FileType ruby set iskeyword=@,48-57,_,?,!,192-255
    autocmd FileType scss set iskeyword=@,48-57,_,-,?,!,192-255

    autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
    autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim 
  endif

  set nocompatible
  set viminfo^=!

  let g:miniBufExplMapWindowNavVim = 1
  let g:miniBufExplMapWindowNavArrows = 1
  let g:miniBufExplMapCTabSwitchBufs = 1
  let g:miniBufExplModSelTarget = 1

  syntax enable

  set modeline
  set modelines=5
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
  set statusline=%f%m%r%h%w\ [%{&ff}]\ %y\ [\%03.3b]%=%{fugitive#statusline()}\ %-14.(%l,%c%V%)\ %P\ %L
  set relativenumber
  set guioptions-=T  "remove toolbar
  set showmatch                                                      " Show matching brackets.
  set mat=5                                                          " Bracket blinking.
  set history=10000                                                  " large history
  set undolevels=10000                                               " use many undos
  set pastetoggle=<F2>                                               " enable/disable autoformatting on right mouse paste
  set autoread                                                       " Autoload files that are modified outside vim
  

  set nobackup                                                       " no backup file
  set noswapfile                                                     " no swap file

  set splitbelow splitright                                          " Add new windows towards the right and bottom.
  

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

  " As Linux and Mac have different declarations for guifont we need to
  " differentiate between the two
  if has('mac')
    set guifont=Mensch:h10
  elseif has("unix")
    set guifont=Mensch\ 8
  endif

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
" F7 reformats the whole file and leaves you where you were (unlike gg)
map <silent> <F7> mzgg=G'z :delmarks z<CR>:echo "Reformatted."<CR>

"automatically remove trailing whitespace
autocmd FocusLost *.py,*.js,*.rb,*.html,*.module,*.php,*.phtml,*.inc,*.tmpl,*.css,*.less,*.scss,*.ctp,*.coffee :call Preserve("%s/\\s\\+$//e")
autocmd BufWritePre *.py,*.js,*.rb,*.html,*.module,*.php,*.phtml,*.inc,*.tmpl,*.css,*.less,*.scss,*.ctp,*.coffee :call Preserve("%s/\\s\\+$//e")

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


" map esc to jj in insert mode to provide a way around photoshop bug blocking esc key
imap jj <ESC>

" map autocompletion to control-space
imap <C-space> <C-P>

" map :b# to accessible combination on german keyboard
nmap <C-tab> :b#<CR>
nmap <leader>, :b#<CR>

" map show next match (vimgrep)
nmap <leader>n :cn<CR>

"prev/next in quickfix file listing (e.g. search results)
map <C-M-Down> :cn<CR>
map <C-M-Up> :cp<CR>

"opt-cmd-arrows [next & previous open files]
map <D-M-Left> :bp<CR>
map <D-M-Right> :bn<CR>

"indent/unindent visual mode selection with tab/shift+tab
vmap <tab> >gv
vmap <s-tab> <gv


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

" if you forgot to open a file with sudo you can write it with w!!
cmap w!! w !sudo tee % >/dev/null

"store and restore session
nnoremap <leader>s :mksession! ~/.vim_default_session<CR>
nnoremap <leader>S :so ~/.vim_default_session<CR>

nnoremap <C-S> :mksession! <CR>
nnoremap <C-M-L> :so ./Session.vim<CR>

" Comment/uncomment lines.
map <leader>/ <plug>NERDCommenterToggle

source ~/.vim/vimrc_local

set sessionoptions="blank,buffers,curdir,folds,resize,tabpages,winpos,winsize"
if filereadable('./Session.vim')
  execute "source ./Session.vim"
endif
