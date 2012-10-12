if filereadable('./Session.vim')                                     "load session if existent
  execute "source ./Session.vim"
endif

set nocompatible                                                     " be iMproved
filetype off                                                         " required!

set rtp+=~/.vim/bundle/vundle/                                       " add vundle to the path
call vundle#rc()                                                     " initialize vundle

source ~/.vim/bundles.vim                                            " load external bundle file

filetype on
" SETTINGS {{{
set t_Co=256          "set 256 terminal colors
let mapleader = ","

set viminfo^=!

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
" Use Node.js for JavaScript interpretation
let $JS_CMD='node'

syntax enable

set mouse=a                                                       "enable mouse support in all modes
set modeline
set modelines=5
set scrolloff=4
set showmode
set showcmd
set visualbell
set cursorline
" set cursorcolumn                 " currently disabled due to performance impacts
set ttyfast
set ruler
set laststatus=2
set norelativenumber
set nonumber
set guioptions-=T  "remove toolbar
set showmatch                                                      " Show matching brackets.
set mat=5                                                          " Bracket blinking.
set history=1000                                                  " large history
set undofile
set undolevels=1000                                               " use many undos
set pastetoggle=<F2>                                               " enable/disable autoformatting on right mouse paste
set shiftround
set autoread                                                       " Autoload files that are modified outside vim
set autowriteall 
set hidden                                                           " allow vim to create hidden buffers
set backspace=indent,eol,start                                       " allow backspacing over everything in insert mode

set completeopt=longest,menuone,preview                              " Better Completion

"  set nobackup                                                       " no backup file
"  set noswapfile                                                     " no swap file

set splitbelow splitright                                          " Add new windows towards the right and bottom.

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
syntax on " syntax highlighting
colorscheme lucius
set background=dark
"call togglebg#map("<F8>") "Toggle Solarized

set nolist        " do not show hidden characters
set sessionoptions="blank,buffers,curdir,folds,resize,tabpages,winpos,winsize"

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:>\ ,eol:$
"}}}
" FONT {{{
" As Linux and Mac have different declarations for guifont we need to
" differentiate between the two
if has('mac')
  set guifont=Mensch:h10
elseif has("unix")
  set guifont=Mensch\ 8
endif
"}}}
" SET ENCODING {{{"{{{
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8 nobomb
  setglobal fileencoding=utf-8 nobomb
  set fileencodings=ucs-bom,utf-8,latin1
endif
" }}}"}}}
" STATUSLINE {{{

set statusline=%f
set statusline+=%m
set statusline+=%r
set statusline+=%h
set statusline+=%w

set statusline+=\ 

set statusline+=[%{&ff}]

set statusline+=\  

set statusline+=%y

set statusline+=\ 

set statusline+=[\%03.3b]

set statusline+=\ 

set statusline+=%#redbar#                " Highlight the following as a warning.
set statusline+=%{SyntasticStatuslineFlag()} " Syntastic errors.
set statusline+=%*                           " Reset highlighting.

set statusline+=%=

set statusline+=%{fugitive#statusline()}

set statusline+=\ 

set statusline+=%-14.(%l,%c%V%)

set statusline+=\ 

set statusline+=%P

set statusline+=\ 

set statusline+=%L
set statusline+=
set statusline+=
" }}}
" WILDMENU COMPLETION {{{

set wildignore+=*.sass-cache                     " SASS

set wildmenu
set wildmode=list:longest

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit

set wildignore+=*.luac                           " Lua byte code

set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=tmp 
set wildignore+=*.class                            " Java class files"
set wildignore+=*.jar                            " Java jar files"
set wildignore+=*node_modules                     " Node modules dir


" }}}
" BACKUPS {{{

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups

" }}}
" FOLDING ----------------------------------------------------------------- {{{

set foldlevelstart=99999

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Use ,z to "focus" the current fold.
nnoremap <leader>z zMzvzz

function! MyFoldText() " {{{
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" }}}
" TEXTWRAPPING {{{
"these lines seem to have some kind of side effects, needs investigation
"command! -nargs=* Wrapmode set tw=60 formatoptions+=ta               " autowrap text on insert @ 60 chars
"command! -nargs=* Nowrapmode set tw=0 formatoptions-=ta              " restore to previouse state
"}}} 
" AUTOCOMMANDS AND FILETYPE ASSOCIATIONS {{{
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
  autocmd FileType css,scss set iskeyword=@,48-57,_,-,?,!,192-255
  autocmd FileType clojure,clj set iskeyword=@,48-57,_,-,?,!,192-255

  autocmd FileType html,htmldjango,jinjahtml,eruby,mako,ctp let b:closetag_html_style=1
  autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako,ctp source ~/.vim/bundle/closetag.vim/plugin/closetag.vim 

  autocmd FileType css,scss setlocal ts=4 sts=4 sw=4 noet
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noet
  autocmd FileType coffee setlocal ts=2 sts=2 sw=2 et
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 et
  autocmd FileType php setlocal ts=2 sts=2 sw=2 et
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et
  autocmd FileType xml setlocal ts=4 sts=4 sw=4 noet

  " OMNICOMPLETE {{{
  set ofu=syntaxcomplete#Complete
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  autocmd FileType c setlocal omnifunc=ccomplete#Complete
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  " }}}

  "automatically remove trailing whitespace
  autocmd FocusLost *.py,*.js,*.rb,*.html,*.module,*.php,*.phtml,*.inc,*.tmpl,*.css,*.less,*.scss,*.ctp,*.coffee :call Preserve("%s/\\s\\+$//e")
  autocmd BufWritePre *.py,*.js,*.rb,*.html,*.module,*.php,*.phtml,*.inc,*.tmpl,*.css,*.less,*.scss,*.ctp,*.coffee :call Preserve("%s/\\s\\+$//e")

  au FocusLost * :wa                                                   " write file on focus lost
  au CursorHold * :wa                                                 " write all files when cursor does not move

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin on
  filetype plugin indent on
  set ofu=syntaxcomplete#Complete

  "Resize splits when the window is resized
  au VimResized * exe "normal! \<c-w>="

  "Spellcheck commit messages
  autocmd BufRead COMMIT_EDITMSG setlocal spell!
endif

" }}}
" INITIALIZE MATCHIT {{{
runtime macros/matchit.vim
" }}}
" CSS, SCSS and LessCSS {{{

augroup ft_css
  au!

  au BufNewFile,BufRead *.less setlocal filetype=less

  au Filetype scss,less,css setlocal foldmethod=marker
  au Filetype scss,less,css setlocal foldmarker={,}
  au Filetype scss,less,css setlocal omnifunc=csscomplete#CompleteCSS
  au Filetype scss,less,css setlocal iskeyword+=-
  au BufRead,BufNewFile *.scss set filetype=scss

  " Use <leader>S to sort properties.  Turns this:
  "
  "     p {
  "         width: 200px;
  "         height: 100px;
  "         background: red;
  "
  "         ...
  "     }
  "
  " into this:

  "     p {
  "         background: red;
  "         height: 100px;
  "         width: 200px;
  "
  "         ...
  "     }
  au BufNewFile,BufRead *.less,*.css,*.scss nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>
augroup END

" }}}
" JAVASCRIPT {{{

augroup ft_javascript
  au!

  au FileType javascript setlocal foldmethod=marker
  au FileType javascript setlocal foldmarker={,}
augroup END

" }}}
" RUBY {{{

augroup ft_ruby
  au!
  " FOldmethod switched to manual, because of plugin problems (slow response
  " times)
  au Filetype ruby setlocal foldmethod=manual
  let g:rubycomplete_buffer_loading = 1
  let g:rubycomplete_classes_in_global = 1
  let g:rubycomplete_rails = 1
augroup END

" }}}
" VIM {{{

augroup ft_vim
  au!

  au FileType vim setlocal foldmethod=marker
  au FileType help setlocal textwidth=78
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

" }}}
" TABSTYLE FUNCTIONS {{{
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
"}}}
" PRESERVE STATE AFTER OPERATION FUNCTION {{{
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

" }}}
" CONVENIENCE MAPPINGS ---------------------------------------------------- {{{

" Substitute
nnoremap <leader>s :%s//<left>

" Preview Files
nnoremap <F6> :w<cr>:Hammer<cr>

nnoremap <F4> :TlistToggle<cr>

" HTML tag closing
inoremap <C-_> <Space><BS><Esc>:call InsertCloseTag()<cr>a

nnoremap <F3> :NERDTreeToggle<cr>

vmap Q gq                                                          " us Q to format current paragraph
nmap Q gqap


" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>                    " remove trailing white space

nmap <leader>= :call Preserve("normal gg=G")<CR>                      " indent lines
nmap <leader>0 gg=G
" F7 reformats the whole file and leaves you where you were (unlike gg)
map <silent> <F7> mzgg=G'z :delmarks z<CR>:echo "Reformatted."<CR>


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
"nmap j gj                                                        " go down instead of jump per line
"nnoremap j gj                                                        " go down instead of jump per line
"nnoremap k gk                                                        " go up
vnoremap <F1> <ESC>:wa<cr>
map <F1> :wa<CR>
imap <F1> <Esc>:wa<CR>


" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <leader>ö :nohl<CR>
nnoremap <leader>ft Vatzf                                            " fold tag


" map esc to jj in insert mode to provide a way around photoshop bug blocking esc key
imap kj <ESC>
imap KJ <ESC>:wa<CR>

" map :b# to accessible combination on german keyboard
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


" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>


"provide mappings to use clipboard
nnoremap <S-INSERT> "+gP
imap <S-INSERT> <ESC>"+gPi
vmap <C-C> "+y

" if you forgot to open a file with sudo you can write it with w!!
cmap w!! w !sudo tee % >/dev/null

"generate rails ctags
map <Leader>cr :!ctags --extra=+f --exclude=.git --exclude=log -R * `rvm gemdir`/gems/*<CR><CR>
map <Leader>cp :!ctags --extra=+f --exclude=.git --exclude=log --langmap=php:.php.module.inc --php-kinds=cdfi --languages=php --recurse * <CR><CR>
map <Leader>cj :!jsctags .<CR><CR>
map <Leader>ct :!ctags --extra=+f --exclude=.git --exclude=log -R * <CR><CR>

"yank to the reset of the line
map Y y$

"find merge conflicts
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

"insert current date
nmap <leader>df a<C-R>=strftime("%Y-%m-%d %I:%M")<CR><Esc>
nmap <leader>dd a<C-R>=strftime("%Y-%m-%d")<CR><Esc>
nmap <leader>dt a<C-R>=strftime("%I:%M")<CR><Esc>

"insert brackets from home row
inoremap <C-j> [
"inoremap <C-k> ]
inoremap <C-d> {
inoremap <C-f> }

"}}}
" SURROUND MAPPINGS {{{
" surround with char (needs surround plugin)
nmap <leader>" ysiw"
nmap <leader>' ysiw'
nmap <leader>( ysiw(
nmap <leader>) ysiw)
nmap <leader>[ ysiw[
nmap <leader>] ysiw]
nmap <leader>{ ysiw{
nmap <leader>} ysiw}
nmap <leader>< ysiw<
nmap <leader>> ysiw>
vmap <leader>" ys"
vmap <leader>' ys'
vmap <leader>( ys(
vmap <leader>) ys)
vmap <leader>[ ys[
vmap <leader>] ys]
vmap <leader>{ ys{
vmap <leader>} ys}
vmap <leader>< ys<
vmap <leader>> ys>
" }}}
" COMMANDT {{{
if has("CommandT")
  nmap <leader>r :CommandTFlush<CR>
  nmap <leader>t :CommandT<CR>
  nmap <leader>T :CommandT %%<CR>
  nmap <leader>b :CommandTBuffer<CR>
  nmap <leader>B :CommandTJump<CR>
  let g:CommandTMaxFiles=15000
endif
" }}}
" NERDCommenter {{{
" Comment/uncomment lines.
map <leader>/ <plug>NERDCommenterToggle
" }}}
" FUGITIVE {{{

nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>

augroup ft_fugitive
  au!

  au BufNewFile,BufRead .git/index setlocal nolist
augroup END

" }}}
" GUNDO {{{

nnoremap <F5> :GundoToggle<CR>
nnoremap <leader>u :GundoToggle<CR>
let g:gundo_debug = 1
let g:gundo_preview_bottom = 1

" }}}
" HTML5 {{{

let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0

" }}}
" RAINBOX PARENTHESES {{{

  "au VimEnter * RainbowParenthesesToggle  "has problems with vimclojure's
  "indenting, @TODO needs fixing
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces

nnoremap <leader>rb :RainbowParenthesesToggle<cr>
let g:rbpt_colorpairs = [
      \ ['brown',       'RoyalBlue3'],
      \ ['Darkblue',    'SeaGreen3'],
      \ ['darkgray',    'DarkOrchid3'],
      \ ['darkgreen',   'firebrick3'],
      \ ['darkcyan',    'RoyalBlue3'],
      \ ['darkred',     'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['brown',       'firebrick3'],
      \ ['gray',        'RoyalBlue3'],
      \ ['black',       'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['Darkblue',    'firebrick3'],
      \ ['darkgreen',   'RoyalBlue3'],
      \ ['darkcyan',    'SeaGreen3'],
      \ ['darkred',     'DarkOrchid3'],
      \ ['red',         'firebrick3'],
      \ ]
let g:rbpt_max = 16


" }}}
" SUPERTAB {{{

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabLongestHighlight = 1

"}}}
" SYNTASTIC {{{

let g:syntastic_enable_signs = 1
let g:syntastic_disabled_filetypes = ['html']
let g:syntastic_stl_format = '[%E{Error 1/%e: line %fe}%B{, }%W{Warning 1/%w: line %fw}]'
let g:syntastic_jsl_conf = '$HOME/.vim/jsl.conf'

" }}}
" POWERLINE {{{
let g:Powerline_symbols = 'fancy'
" }}}
" CTRLP {{{
  let g:ctrlp_map = '<C-G>' 
  map <leader>rr :ClearCtrlPCache<CR>
  map <C-d> :CtrlPBuffer<CR>
  map <leader>p :CtrlP<CR>
  map <leader>b :CtrlPBuffer<CR>

  let g:ctrlp_working_path_mode = 0

" }}}
" PIV {{{
let g:DisableAutoPHPFolding = 1 
"}}}
" AUTOTAG {{{
so ~/.vim/bundle/AutoTag/plugin/autotag.vim
" }}}

" TURBUX {{{

" }}}
" XDEBUG Client{{{
"enable debug client in gvim
if has("gui_running")
  let g:debuggerMapDefaultKeys = 7
endif
" }}}
" CLOJURE {{{
augroup ft_clojure
  au!
  au BufRead,BufNewFile *.clj set filetype=clojure
  syntax on
  set foldmethod=syntax
augroup END
" }}}

" VIM CLOJURE{{{
let vimclojure#HighlightBuiltins = 1 " Highlight Clojure's builtins
let vimclojure#ParenRainbow = 1      " Rainbow parentheses'!
" }}}
" SHEBANG {{{
map <leader>X :w<CR>:call SetExecutable()<CR>

" }}}

" CONVERT SECTION OF BOOKMARKS FILE TO LINKS
" 
" USAGE:
"   if your folder has the name 'foo' then simply call
"   :call BoomarksToMarkdownLinks("foo")<cr>
" {{{
function! BoomarksToMarkdownLinks(mark)
  let save_search = @/
  execute '1,/>' . a:mark . '</+1d'
  /<\/DL>/,$ d
  %s/\m.*HREF="\(.\{-}\)".*>\(.*\)<.*/- [\2](\1)/
  let @/ = save_search
endfunction
" }}}
" neocomplcache {{{

let g:neocomplcache_enable_at_startup = 1

let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 5
let g:neocomplcache_min_keyword_length = 5
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

let g:neocomplcache_max_list = 5
let g:neocomplcache_auto_completion_start_length = 3

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }


" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif

"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

if !exists('g:neocomplcache_force_omni_patterns')
      let g:neocomplcache_force_omni_patterns = {}
endif
"let g:neocomplcache_force_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'



" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

" }}}
" Lucius {{{
let g:lucius_style = "dark"

function! ToggleLuciusStyle()
  if g:lucius_style == "dark"
    LuciusDarkDim
  elseif g:lucius_style == "dark_dim"
    LuciusLight
  else
    LuciusDark
  endif
endfunction

command! -nargs=* ToggleLuciusStyle call ToggleLuciusStyle()
nnoremap <F8> :ToggleLuciusStyle<cr>
" }}}
"{{{ SNIP MATE
let g:snips_trigger_key='<c-g>'
"}}}
"
"{{{ NEOCOMPLETE SNIPPETS
let g:neocomplcache_snippets_dir="~/.vim/bundle/snipmate-snippets/snippets"
imap <C-A> <Plug>(neocomplcache_snippets_expand)
smap <C-A> <Plug>(neocomplcache_snippets_expand)
"}}}

" PHP CS FIXER{{{
let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer"        " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_level = "all"                " which level ?
let g:php_cs_fixer_config = "default"           " configuration
let g:php_cs_fixer_php_path = "php"             " Path to PHP
let g:php_cs_fixer_fixers_list = ""             " List of fixers
let g:php_cs_fixer_enable_default_mapping = 1   " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                  " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                  " Return the output of command if 1, else an inline information.

nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>
" }}}
" SWITCH VIM {{{
nnoremap - :Switch<cr>
" }}}

"{{{ wrap visual selection in tag

vmap <Leader>w <Esc>:call VisualHTMLTagWrap()<CR>
function! VisualHTMLTagWrap()
  let tag = input("Tag to wrap block: ")
  if len(tag) > 0
    normal `>
    if &selection == 'exclusive'
      exe "normal i</".tag.">"
    else
      exe "normal a</".tag.">"
    endif
    normal `<
    exe "normal i<".tag.">"
    normal `<
  endif
endfunction

"}}}
"{{{ js beautify
autocmd FileType javascript noremap <buffer>  <leader>ff :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <leader>ff :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <leader>ff :call CSSBeautify()<cr>
"}}}
    " Tabularize {
        if exists(":Tabularize")
          nmap <Leader>a= :Tabularize /=<CR>
          vmap <Leader>a= :Tabularize /=<CR>
          nmap <Leader>a=> :Tabularize /=<CR>
          vmap <Leader>a=> :Tabularize /=<CR>
          nmap <Leader>a: :Tabularize /:<CR>
          vmap <Leader>a: :Tabularize /:<CR>
          nmap <Leader>a:: :Tabularize /:\zs<CR>
          vmap <Leader>a:: :Tabularize /:\zs<CR>
          nmap <Leader>a, :Tabularize /,<CR>
          vmap <Leader>a, :Tabularize /,<CR>
          nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
          vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

          " The following function automatically aligns when typing a
          " supported character
          inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

          function! s:align()
              let p = '^\s*|\s.*\s|\s*$'
              if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
                  let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
                  let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
                  Tabularize/|/l1
                  normal! 0
                  call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
              endif
          endfunction

        endif
     " }
source ~/.vim/vimrc_local

if filereadable('./.vimrc.project')                                     "load session if existent
  execute "source ./.vimrc.project"
endif
