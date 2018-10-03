if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if filereadable('./Session.vim')                                     "load session if existent
  execute Session.vim"
endif

set nocompatible                                                     " be iMproved
filetype off                                                         " required!

source ~/.vim/bundles.vim                                            " load external bundle file

filetype on
" SETTINGS {{{
set t_Co=256          "set 256 terminal colors

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

let mapleader = ","

set viminfo^=!

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
" Use Node.js for JavaScript interpretation
let $JS_CMD='node'

syntax enable

if (!has('nvim')) 
  set cryptmethod=blowfish
endif
set mouse=nicrh                                                       "enable mouse support in all modes
set modeline
set modelines=5
set scrolloff=4
set showmode
set showcmd
set visualbell
set cursorline
set ttyfast
set ruler
set laststatus=2
set norelativenumber
set nonumber
set guioptions-=T  "remove toolbar
set showmatch                                                      " Show matching brackets.
set mat=5                                                          " Bracket blinking.
set history=1000                                                   " large history
set undofile
set undolevels=1000                                                " use many undos
set pastetoggle=<F2>                                               " enable/disable autoformatting on right mouse paste
set breakindent                                                    " indent wrapped lines and prefix with +
set showbreak=+\ 
set shiftround
set autoread                                                       " Autoload files that are modified outside vim
set lazyredraw
augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter        * silent! checktime
        autocmd CursorHold      * silent! checktime
        autocmd CursorHoldI     * silent! checktime
    endif
augroup END
set autowriteall 
set hidden                                                           " allow vim to create hidden buffers
set backspace=indent,eol,start                                       " allow backspacing over everything in insert mode
set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set autochdir

set suffixesadd=.ts,.js,.json,.jade,.jsx

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

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
"call togglebg#map("<F8>") "Toggle Solarized

set nolist        " do not show hidden characters
set sessionoptions="blank,buffers,curdir,folds,resize,tabpages,winpos,winsize"

"some terminal problems with ascii confusion art
set listchars=tab:>\ ,eol:$,trail:.,nbsp:_
"}}}    
" Line Return {{{

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}
" SET ENCODING {{{"{{{
if has("multi_byte")
  "if &termencoding == ""
    "let &termencoding = &encoding
  "endif
  set encoding=utf-8 nobomb
  setglobal fileencoding=utf-8 nobomb
  set fileencodings=ucs-bom,utf-8,latin1
endif
" }}}"}}}
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
set foldlevelstart=9

" Space to toggle folds.
nnoremap <c-z> za
vnoremap <c-z> za

nnoremap ;0 :set foldlevel=0<cr>
nnoremap ;1 :set foldlevel=1<cr>
nnoremap ;2 :set foldlevel=2<cr>
nnoremap ;3 :set foldlevel=3<cr>
nnoremap ;4 :set foldlevel=4<cr>
nnoremap ;5 :set foldlevel=5<cr>
nnoremap ;6 :set foldlevel=6<cr>
nnoremap ;7 :set foldlevel=7<cr>
nnoremap ;8 :set foldlevel=8<cr>
nnoremap ;9 :set foldlevel=9999<cr>

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Use ,z to "focus" the current fold.
nnoremap <leader>z zMzvzz

function! MyFoldText() 
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
endfunction 
set foldtext=MyFoldText()

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" }}}
" AUTOCOMMANDS AND FILETYPE ASSOCIATIONS {{{
if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.phtml set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd FileType php setlocal nocursorcolumn
    autocmd FileType php setlocal nocursorline
  augroup END

  autocmd BufRead,BufNewFile *.tmpl set filetype=html
  autocmd BufRead,BufNewFile *.less set filetype=css
  autocmd BufRead,BufNewFile *.hbs setlocal filetype=html

  "highlight JSON files as javascript
  autocmd BufRead,BufNewFile *.json set filetype=json
  autocmd BufRead,BufNewFile *.jasmine_fixture set filetype=html
  au BufRead,BufNewFile Gemfile* set filetype=ruby 

  " set question mark to be part of a VIM word. in Ruby it is!
  autocmd FileType ruby set iskeyword=@,48-57,_,?,!,192-255
  autocmd FileType css,scss,less,jade set iskeyword=@,49-57,_,-,?,!,192-255
  autocmd FileType javascript set iskeyword=@,48-57,-,192-255
  autocmd FileType clojure,clj set iskeyword=@,48-57,_,-,?,!,192-255

  autocmd FileType html,htmldjango,jinjahtml,eruby,mako,ctp let b:closetag_html_style=1
  autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako,ctp source ~/.vim/bundle/closetag.vim/plugin/closetag.vim 

  autocmd FileType css,scss,less setlocal ts=4 sts=4 sw=4 et
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 et
  autocmd FileType coffee setlocal ts=2 sts=2 sw=2 et
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 et
  autocmd FileType php setlocal ts=4 sts=4 sw=4 et
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et
  autocmd FileType jade setlocal ts=4 sts=4 sw=4 et
  autocmd FileType xml,html setlocal ts=4 sts=4 sw=4 et
  " }}}

  "automatically remove trailing whitespace
  autocmd FocusLost *.py,*.js,*.json,*.rb,*.html,*.module,*.php,*.phtml,*.inc,*.tmpl,*.css,*.less,*.scss,*.ctp,*.coffee :call Preserve("%s/\\s\\+$//e")
  autocmd BufWritePre *.py,*.js,*.json,*.rb,*.html,*.module,*.php,*.phtml,*.inc,*.tmpl,*.css,*.less,*.scss,*.ctp,*.coffee :call Preserve("%s/\\s\\+$//e")

  set updatetime=100
  au BufLeave,FocusLost * silent! wall                                                   " write file on focus lost
  au CursorHold * silent! wall                                                 " write all files when cursor does not move
  au InsertLeave * :w

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

  "Fix drawing issues
  au BufWritePost * :silent! :syntax sync fromstart<cr>:redraw!<cr>
endif

" }}}
" CSS, SCSS and LessCSS {{{

augroup ft_css
  au!

  au BufNewFile,BufRead *.less setlocal filetype=less
  au Filetype scss,less,css setlocal foldmethod=marker
  au Filetype scss,less,css setlocal foldmarker={,}
  au Filetype scss,less,css setlocal iskeyword+=-
  au BufRead,BufNewFile *.scss set filetype=scss
  au BufRead,BufNewFile *.less set filetype=less
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

nnoremap <F4> :TagbarToggle<cr>

" HTML tag closing
inoremap <C-_> <Space><BS><Esc>:call InsertCloseTag()<cr>a

vmap Q gq                                                          " us Q to format current paragraph
nmap Q gqap

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>                    " remove trailing white space
nmap <leader>= :call Preserve("normal gg=G")<CR>                      " indent lines
nmap <leader>0 gg=G

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
nnoremap <leader>3 yypVr

nnoremap / /\v
vnoremap / /\v
vnoremap <F1> <ESC>:wa<cr>
map <F1> :wa<CR>
imap <F1> <Esc>:wa<CR>

nnoremap <silent> <leader>ö :nohl<CR>
nnoremap <silent> <leader><space> :nohl<CR>
nnoremap <leader>ft Vatzf                                            " fold tag

" map esc to kj in insert mode to provide a way around photoshop bug blocking esc key
imap kj <ESC>
imap KJ <ESC>:wa<CR>

" map :b# to accessible combination on german keyboard
nmap <leader>. :b#<CR>

" map show next match (vimgrep)
nmap <leader>n :cn<CR>
nmap ;n :cp<CR>

"prev/next in quickfix file listing (e.g. search results)
map <C-M-Down> :cn<CR>
map <C-M-Up> :cp<CR>

"opt-cmd-arrows [next & previous open files]
map <D-M-Left> :bp<CR>
map <D-M-Right> :bn<CR>

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

"yank to the rest of the line
map Y y$

"find merge conflicts
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

"insert current date
nmap <leader>df a<C-R>=strftime("%Y-%m-%d %I:%M")<CR><Esc>
nmap <leader>dd a<C-R>=strftime("%Y-%m-%d")<CR><Esc>
nmap <leader>dt a<C-R>=strftime("%I:%M")<CR><Esc>

"insert brackets from home row
inoremap <C-j> [
inoremap <C-k> ]
inoremap <C-h> {
inoremap <C-l> }
inoremap <C-g> (
inoremap <C-;> )

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" duplicate mapping chec k @TODO
nmap ,mm :next<cr>
nmap ,,m :prev<cr>
nmap <C-ä> :lnext<cr>
nmap <C-ü> :lprev<cr>

"jump to next error / location
nnoremap <leader><leader>e :lnext<CR>

" Easier linewise reselection of what you just pasted.
nnoremap <leader>V V`]

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

"Keep search pattern at the center of the screen.
 nnoremap <silent> n nzz
 nnoremap <silent> N Nzz
 nnoremap <silent> * *zz
 nnoremap <silent> # #zz
 nnoremap <silent> g* g*zz

inoremap ;fl (╯°□°）╯︵ ┻━┻"
"}}}
" Next and Last {{{
"
" Motion for "next/last object".  "Last" here means "previous", not "final".
" Unfortunately the "p" motion was already taken for paragraphs.
"
" Next acts on the next object of the given type, last acts on the previous
" object of the given type.  These don't necessarily have to be in the current
" line.
"
" Currently works for (, [, {, and their shortcuts b, r, B. 
"
" Next kind of works for ' and " as long as there are no escaped versions of
" them in the string (TODO: fix that).  Last is currently broken for quotes
" (TODO: fix that).
"
" Some examples (C marks cursor positions, V means visually selected):
"
" din'  -> delete in next single quotes                foo = bar('spam')
"                                                      C
"                                                      foo = bar('')
"                                                                C
"
" canb  -> change around next parens                   foo = bar('spam')
"                                                      C
"                                                      foo = bar
"                                                               C
"
" vin"  -> select inside next double quotes            print "hello ", name
"                                                       C
"                                                      print "hello ", name
"                                                             VVVVVV

onoremap an :<c-u>call <SID>NextTextObject('a', '/')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', '/')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', '/')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', '/')<cr>

onoremap al :<c-u>call <SID>NextTextObject('a', '?')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', '?')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', '?')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', '?')<cr>


function! s:NextTextObject(motion, dir)
    let c = nr2char(getchar())
    let d = ''

    if c ==# "b" || c ==# "(" || c ==# ")"
        let c = "("
    elseif c ==# "B" || c ==# "{" || c ==# "}"
        let c = "{"
    elseif c ==# "r" || c ==# "[" || c ==# "]"
        let c = "["
    elseif c ==# "'"
        let c = "'"
    elseif c ==# '"'
        let c = '"'
    else
        return
    endif

    " Find the next opening-whatever.
    execute "normal! " . a:dir . c . "\<cr>"

    if a:motion ==# 'a'
        " If we're doing an 'around' method, we just need to select around it
        " and we can bail out to Vim.
        execute "normal! va" . c
    else
        " Otherwise we're looking at an 'inside' motion.  Unfortunately these
        " get tricky when you're dealing with an empty set of delimiters because
        " Vim does the wrong thing when you say vi(.

        let open = ''
        let close = ''

        if c ==# "(" 
            let open = "("
            let close = ")"
        elseif c ==# "{"
            let open = "{"
            let close = "}"
        elseif c ==# "["
            let open = "\\["
            let close = "\\]"
        elseif c ==# "'"
            let open = "'"
            let close = "'"
        elseif c ==# '"'
            let open = '"'
            let close = '"'
        endif

        " We'll start at the current delimiter.
        let start_pos = getpos('.')
        let start_l = start_pos[1]
        let start_c = start_pos[2]

        " Then we'll find it's matching end delimiter.
        if c ==# "'" || c ==# '"'
            " searchpairpos() doesn't work for quotes, because fuck me.
            let end_pos = searchpos(open)
        else
            let end_pos = searchpairpos(open, '', close)
        endif

        let end_l = end_pos[0]
        let end_c = end_pos[1]

        call setpos('.', start_pos)

        if start_l == end_l && start_c == (end_c - 1)
            " We're in an empty set of delimiters.  We'll append an "x"
            " character and select that so most Vim commands will do something
            " sane.  v is gonna be weird, and so is y.  Oh well.
            execute "normal! ax\<esc>\<left>"
            execute "normal! vi" . c
        elseif start_l == end_l && start_c == (end_c - 2)
            " We're on a set of delimiters that contain a single, non-newline
            " character.  We can just select that and we're done.
            execute "normal! vi" . c
        else
            " Otherwise these delimiters contain something.  But we're still not
            " sure Vim's gonna work, because if they contain nothing but
            " newlines Vim still does the wrong thing.  So we'll manually select
            " the guts ourselves.
            let whichwrap = &whichwrap
            set whichwrap+=h,l

            execute "normal! va" . c . "hol"

            let &whichwrap = whichwrap
        endif
    endif
endfunction

" }}}
" AUTO COMMANDS {{{
" turn off paste on insert mode leave
au InsertLeave * set nopaste
" }}}
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
let g:gundo_preview_bottom = 1
if has('python3')
  let g:gundo_prefer_python3 = 1          " anything else breaks on Ubuntu 16.04+
endif
" }}}
" SUPERTAB {{{

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabLongestHighlight = 1

"}}}
" ALE {{{
let g:ale_linters = {
\   'javascript': ['eslint'],
\}
" After this is configured, :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

let g:ale_statusline_format = ['⨉%d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_error_str = '⨉'
let g:ale_echo_msg_warning_str = '⚠'
nmap <silent> <C-u> <Plug>(ale_previous_wrap)
nmap <silent> <S-u> <Plug>(ale_next_wrap)

" Set this setting in vimrc if you want to fix files automatically on save.
" This is off by default.
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_lint_delay = 750

highlight link ALEErrorLine error
highlight link ALEWarningLine warn

nmap <leader>af :ALEFix<CR>
nmap <leader>ah :ALEHover<CR>
nmap <leader>ar :ALEFindReferences<CR>

" }}}
" AIRLINE {{{
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#default#section_truncate_width = {
    \ 'b': 110,
    \ 'x': 40,
    \ 'y': 111,
    \ 'z': 45,
    \ 'warning': 81,
    \ 'error': 80,
    \ }
let g:airline#extensions#branch#displayed_head_limit = 16
" }}}
" CTRLP {{{
let g:ctrlp_map = '<C-G>' 
map <leader>rr :ClearCtrlPCache<CR>
map <C-d> :CtrlPBuffer<CR>
map <C-ö> :CtrlPMRU<CR>
map <C-A-g> :CtrlPMixed<CR>
map <leader>p :CtrlP<CR>
map <leader>b :CtrlPBuffer<CR>

let g:ctrlp_max_files = 30000
"let g:ctrlp_working_path_mode = "ra"
let g:ctrlp_root_markers= ["node_modules", ".git", ".hg", ".svn", ".bzr", "_darcs", ".approot", "package.json"]
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:15'
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files --exclude-standard']
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
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
" {{{ YouCompleteMe
let g:syntastic_always_populate_loc_list = 1
let g:ycm_key_list_select_completion = ['<Down>', '<Enter>']
let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>'] 
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_strings = 1

let g:ycm_rust_src_path = '/Users/tom/install/rust/src'
" }}}
" UltiSnips {{{
  "let g:UltiSnipsExpandTrigger="<c-l>"
  "let g:UltiSnipsListSnippets="<c-h>"
  "let g:UltiSnipsExpandTrigger="<tab>"
  "let g:UltiSnipsJumpForwardTrigger="<c-q>"
  "let g:UltiSnipsJumpBackwardTrigger="<c-w>"
  "let g:UltiSnipsSnippetsDir        = '~/.vim/snippets/'
  "let g:UltiSnipsSnippetDirectories = ['UltiSnips']
" }}}
" Emmet {{{
let g:user_emmet_leader_key = '<c-e>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}
" }}}
" MouseToggle{{{
fun! s:ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "nirch"
    endif

    if &mouse == ""
        let &mouse = s:old_mouse
        echo "Mouse is for Vim (" . &mouse . ")"
    else
        let s:old_mouse = &mouse
        let &mouse=""
        echo "Mouse is for terminal"
    endif
endfunction

nnoremap ;;m :call <SID>ToggleMouse()<cr>
" }}}
" NodeModulesToggle{{{
fun! s:ToggleNodeModules()
    if !exists("s:node_ignore")
        let s:node_ignore = "NM"
    endif

    if s:node_ignore == ""
        let s:node_ignore = "NM" 
        set wildignore+=*node_modules
        echo "ignoring node_modules"
    else
        let s:node_ignore = ""
        set wildignore-=*node_modules
        echo "inlcuding node_modules"
    endif
endfunction

nnoremap <leader><leader>i :call <SID>ToggleNodeModules()<cr>
" }}}
" Lucius {{{
LuciusBlack

function! ToggleLuciusStyle()
  if g:lucius_style == "black"
    LuciusDarkLowContrast
  elseif g:lucius_style == "dark_dim"
    LuciusLight
  else
    LuciusBlack
  endif
endfunction

command! -nargs=* ToggleLuciusStyle call ToggleLuciusStyle()
nnoremap <F8> :ToggleLuciusStyle<cr>
" }}}
"{{{ SNIP MATE
let g:snips_trigger_key='<c-g>'
"}}}
"
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
" EASY MOTION {{{
nmap <C-0> <Space>F
vmap <C-0> <Space>F
nmap <C-i> <Space>f
vmap <C-i> <Space>f
nmap <S-Tab> <Space>F
let g:EasyMotion_leader_key = '<Space>'
" }}}
" JAVASCRIPT LIBRARIES {{{
let g:used_javascript_libs = 'jquery,underscore,angularjs,node'
" }}}
" GitGutter {{{
nmap <Leader>gg :GitGutterToggle<CR>
noremap ggp :GitGutterPrevHunk<CR>
noremap ggn :GitGutterNextHunk<CR>
nmap gg+ :GitGutterStageHunk<CR>
" }}}
" Expand Region {{{
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" }}}
" Tern {{{
let g:tern_map_prefix=";"
let g:tern_map_keys=1
let g:tern_show_argument_hints = 'none'
let g:tern_show_signature_in_pum = 1

nmap <Leader>def :TernDef <CR>
nmap <Leader>ref :TernRefs <CR>
nmap <Leader>ren :TernRename <CR>
nmap <Leader>typ :TernType <CR>
nmap <Leader>doc :TernDoc <CR>

" TernHintToggle{{{
fun! s:ToggleTernHints()
    if g:tern_show_argument_hints == "none"
        let g:tern_show_argument_hints = "on_hold"
        echo "TernHints ON"
    else
        let g:tern_show_argument_hints="none"
        echo "TernHints OFF"
    endif
endfunction

nnoremap ;;j :call <SID>ToggleTernHints()<cr>
" }}}
"Obvious Resize {{{
noremap <silent> <S-Up> :ObviousResizeUp 8<CR>
noremap <silent> <S-Down> :ObviousResizeDown 8<CR>
noremap <silent> <S-Left> :ObviousResizeLeft 15<CR>
noremap <silent> <S-Right> :ObviousResizeRight 15<CR>
"}}}
"JSDoc {{{
let g:jsdoc_default_mapping=0
nmap <silent> <Leader>jd <Plug>(jsdoc)
"}}}
"VIM GO {{{
au FileType go nmap <space>r <Plug>(go-run)
au FileType go nmap <space>b <Plug>(go-build)
au FileType go nmap <space>t <Plug>(go-test)
au FileType go nmap <space>c <Plug>(go-coverage)
au FileType go nmap <space>ds <Plug>(go-def-split)
au FileType go nmap <space>dv <Plug>(go-def-vertical)
au FileType go nmap <space>gd <Plug>(go-doc)
au FileType go nmap <space>gv <Plug>(go-doc-vertical)
"}}}
" Tabularize {
nmap <Leader>x= :Tabularize /=<CR>
vmap <Leader>x= :Tabularize /=<CR>
nmap <Leader>x=> :Tabularize /=<CR>
vmap <Leader>x=> :Tabularize /=<CR>
nmap <Leader>x: :Tabularize /:<CR>
vmap <Leader>x: :Tabularize /:<CR>
nmap <Leader>x:: :Tabularize /:\zs<CR>
vmap <Leader>x:: :Tabularize /:\zs<CR>
nmap <Leader>x, :Tabularize /,<CR>
vmap <Leader>x, :Tabularize /,<CR>
nmap <Leader>x<Bar> :Tabularize /<Bar><CR>
vmap <Leader>x<Bar> :Tabularize /<Bar><CR>

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

" }

" OpenChangedFiles (<Leader>O)---------------------- {{{
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^[ \?]\(M\|A\|?\)" | cut -c 4-')
  let filenames = split(status, "\n")

  if len(filenames) < 1
    let status = system('git show --pretty="format:" --name-only')
    let filenames = split(status, "\n")
  endif

  exec "edit " . filenames[0]

  for filename in filenames[1:]
    if len(filenames) > 3
      exec "e " . filename
    else
      exec "vsp " . filename
    endif
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()
noremap<Leader>O :OpenChangedFiles <CR>
" }}}
" JSX {{{
let g:jsx_ext_required = 0
let g:jsx_pragma_required = 0
" }}}

" Rainbowlevels {{{
nmap <space>r :RainbowLevelsToggle<cr>
" }}}

" vim-json {{{
let g:vim_json_syntax_conceal = 0
" }}}

" vim-ack {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
" }}}

" QuickScopeSelective {{{
function! Quick_scope_selective(movement)
    let needs_disabling = 0
    if !g:qs_enable
        QuickScopeToggle
        redraw
        let needs_disabling = 1
    endif

    let letter = nr2char(getchar())

    if needs_disabling
        QuickScopeToggle
    endif

    return a:movement . letter
endfunction

let g:qs_enable = 0

nnoremap <expr> <silent> f Quick_scope_selective('f')
nnoremap <expr> <silent> F Quick_scope_selective('F')
nnoremap <expr> <silent> t Quick_scope_selective('t')
nnoremap <expr> <silent> T Quick_scope_selective('T')
vnoremap <expr> <silent> f Quick_scope_selective('f')
vnoremap <expr> <silent> F Quick_scope_selective('F')
vnoremap <expr> <silent> t Quick_scope_selective('t')
vnoremap <expr> <silent> T Quick_scope_selective('T')
" }}}

source ~/.vim/vimrc_local

if filereadable('./.vimrc.project')                                     "load session if existent
  execute "source ./.vimrc.project"
endif

