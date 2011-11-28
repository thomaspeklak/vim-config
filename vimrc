if filereadable('./Session.vim')
  execute "source ./Session.vim"
endif
if has("gui_running")
  filetype off
  call pathogen#helptags()
  call pathogen#runtime_append_all_bundles()
  call pathogen#infect()
  filetype on
  runtime macros/matchit.vim
  map <tab> %
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
    autocmd FileType css,scss set iskeyword=@,48-57,_,-,?,!,192-255

    autocmd FileType html,htmldjango,jinjahtml,eruby,mako,ctp let b:closetag_html_style=1
    autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako,ctp source ~/.vim/bundle/closetag/plugin/closetag.vim 

    autocmd FileType css,scss setlocal ts=4 sts=4 sw=4 noet
    autocmd FileType coffee setlocal ts=2 sts=2 sw=2 et
    autocmd FileType ruby setlocal ts=2 sts=2 sw=2 et
    autocmd FileType php setlocal ts=2 sts=2 sw=2 et
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et
    autocmd FileType xml setlocal ts=4 sts=4 sw=4 noet
  endif

  set nocompatible
  set viminfo^=!

  let g:miniBufExplMapWindowNavVim = 1
  let g:miniBufExplMapWindowNavArrows = 1
  let g:miniBufExplMapCTabSwitchBufs = 1
  let g:miniBufExplModSelTarget = 1
  " Use Node.js for JavaScript interpretation
  let $JS_CMD='node'

  syntax enable

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
  set history=1000                                                  " large history
  set undofile
  set undolevels=1000                                               " use many undos
  set pastetoggle=<F2>                                               " enable/disable autoformatting on right mouse paste
  set shiftround
  set autoread                                                       " Autoload files that are modified outside vim
  set autowriteall 

  "  set nobackup                                                       " no backup file
  "  set noswapfile                                                     " no swap file

  set splitbelow splitright                                          " Add new windows towards the right and bottom.

  "Resize splits when the window is resized
  au VimResized * exe "normal! \<c-w>="

  " Statusline {{{

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

  " Wildmenu completion {{{

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

  " Clojure/Leiningen
  set wildignore+=classes
  set wildignore+=lib

  " }}}
  " Backups {{{

  set undodir=~/.vim/tmp/undo//     " undo files
  set backupdir=~/.vim/tmp/backup// " backups
  set directory=~/.vim/tmp/swap//   " swap files
  set backup                        " enable backups

  " }}}
  " Folding ----------------------------------------------------------------- {{{

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

  " }}}
  " CSS, SCSS and LessCSS {{{

  augroup ft_css
    au!

    au BufNewFile,BufRead *.less setlocal filetype=less

    au Filetype scss,less,css setlocal foldmethod=marker
    au Filetype scss,less,css setlocal foldmarker={,}
    au Filetype scss,less,css setlocal omnifunc=csscomplete#CompleteCSS
    au Filetype scss,less,css setlocal iskeyword+=-

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

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au BufNewFile,BufRead *.less,*.css,*.scss inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
  augroup END

  " }}}
  " Javascript {{{

  augroup ft_javascript
    au!

    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}
  augroup END

  " }}}
  " Ruby {{{

  augroup ft_ruby
    au!
    au Filetype ruby setlocal foldmethod=syntax
  augroup END

  " }}}
  " Vim {{{

  augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
  augroup END

  " }}}
  " Convenience mappings ---------------------------------------------------- {{{

  " Substitute
  nnoremap <leader>s :%s//<left>

  " Preview Files
  nnoremap <F6> :w<cr>:Hammer<cr>

nnoremap <F4> :TlistToggle<cr>

" HTML tag closing
inoremap <C-_> <Space><BS><Esc>:call InsertCloseTag()<cr>a

  " Better Completion
  set completeopt=longest,menuone,preview
  " inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  " inoremap <expr> <C-p> pumvisible() ? '<C-n>'  : '<C-n><C-r>=pumvisible() ? "\<lt>up>" : ""<CR>'
  " inoremap <expr> <C-n> pumvisible() ? '<C-n>'  : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

  "}}}"
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
  colorscheme molokai


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

so ~/.vim/bundle/autotag/plugin/autotag.vim

nmap <leader>r :CommandTFlush<CR>
nmap <leader>t :CommandT<CR>
nmap <leader>b :CommandTBuffer<CR>
let g:CommandTMaxFiles=15000


"provide mappings to use clipboard
nnoremap <S-INSERT> "+gP
imap <S-INSERT> <ESC>"+gPi
vmap <C-C> "+y

" if you forgot to open a file with sudo you can write it with w!!
cmap w!! w !sudo tee % >/dev/null

"store and restore session
nnoremap <C-S> :mksession! <CR>
nnoremap <C-M-L> :so ./Session.vim<CR>

" Comment/uncomment lines.
map <leader>/ <plug>NERDCommenterToggle

set sessionoptions="blank,buffers,curdir,folds,resize,tabpages,winpos,winsize"
" Fugitive {{{

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
" Gundo {{{

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
" Rainbox Parentheses {{{
if has("gui_running")

  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces

endif

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

endif

" }}}
" Supertab {{{

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabLongestHighlight = 1

"}}}
" Syntastic {{{

let g:syntastic_enable_signs = 1
let g:syntastic_disabled_filetypes = ['html']
let g:syntastic_stl_format = '[%E{Error 1/%e: line %fe}%B{, }%W{Warning 1/%w: line %fw}]'
let g:syntastic_jsl_conf = '$HOME/.vim/jsl.conf'

" }}}

source ~/.vim/vimrc_local

