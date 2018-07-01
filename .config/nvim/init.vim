" Tips:
" Search-and-replace with [visual, then cgn](http://vimcasts.org/episodes/operating-on-search-matches-using-gn/)
"---
" Note: <C-h> might be broken on OS X. Run the following commands in bash:
"    infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
"    tic $TERM.ti
" 
scriptencoding utf-8

" Use :PlugInstall on first run
call plug#begin()
" Used to use unimpaired but I can't remember what the advantage was?
" Plug 'tpope/vim-unimpaired'
" Ctrl-N is the best
Plug 'scrooloose/nerdtree'
" Jump into files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Give me a git overview of file changes
Plug 'airblade/vim-gitgutter'
" Automatically closes your HTML
Plug 'docunext/closetag.vim'
" Allows Vgc, gcc, other kinds of commenting
Plug 'tomtom/tcomment_vim'
" :Tab to tabularise some text
Plug 'godlygeek/tabular'
" :Ack to search for text
Plug 'mileszs/ack.vim'
" :Goyo distraction-free writing mode
Plug 'junegunn/goyo.vim'
" My custom colourscheme
Plug 'zephod/molokai'
" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Syntax checking
Plug 'w0rp/ale'
call plug#end()

" ================
" PLUGIN: NerdTree
" ================
set wildignore+=%*
set wildignore+=*.pyc
set wildignore+=node_modules
set wildignore+=_build
set wildignore+=_dist

" ==============
" PLUGIN: FZF
" ==============
set rtp+=~/.fzf

" ================
" PLUGIN: NerdTree
" ================
nnoremap <C-n> :NERDTreeToggle<CR>
"tnoremap <C-n> <C-\><C-n>:NERDTreeToggle<CR>
let NERDTreeMapOpenVSplit='<C-v>'
let NERDTreeMapOpenSplit='<C-x>'
let NERDTreeRespectWildIgnore=1

" ===============
" PLUGIN: Tomokai
" ===============
try
  colorscheme tomokai
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
endtry

" ============
" CORE: NEOVIM
" ============

" Show the cursor position all the time
set ruler		

" Case insensitive search unless Search String cOnstains Capitals
set ignorecase
set smartcase

" Don't use Ex mode, use Q for formatting
map Q gq

" Use space as leader key
let mapleader="\<Space>"

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Hack: Crontab opens vim but requires vi; correct my behaviour
if $VIM_CRONTAB == 'true'
  set nobackup
  set nowritebackup
endif

" Show absolute line numbers
set number

" SUPER USEFUL make macros go fast again
set lazyredraw

" Highlight cursor line/column
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" ====================
" Variable indentation
" ====================
function! IndentWithTabs(tab_size)
  execute "setlocal softtabstop=".a:tab_size
  execute "setlocal tabstop=".a:tab_size
  execute "setlocal shiftwidth=".a:tab_size
  set noexpandtab
endfunction
function! IndentWithSpaces(tab_size)
  execute "setlocal softtabstop=".a:tab_size
  execute "setlocal tabstop=".a:tab_size
  execute "setlocal shiftwidth=".a:tab_size
  set expandtab
endfunction

" Set up default 2-space tabbing anyway
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab

" Python code
autocmd FileType python call IndentWithSpaces(4)

" Vue code: Fix syntac highlighter
autocmd FileType vue syntax sync fromstart

" Don't wrap by default
set nowrap

" OS X Clipboard Integration
set clipboard=unnamed

" Use thin vertical cursor for insert mode(NeoVim-only)
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Split in a sensible direction
set splitbelow
set splitright

" Dont worry about hiding modified buffers
set hidden

" =============
" Key Remapping
" =============
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" When line-wrapping, move by SCREEN line not by FILE line
nnoremap j gj
nnoremap k gk
" Double tap the leader to toggle hidden characters
nnoremap <Leader><Leader> :set list!<Return>
" Leader-enter to toggle word wrap
nnoremap <Leader><Return> :set wrap!<Return>
" Leader-y to yank-append
nnoremap <Leader>y @".getline('.')

"
" Wrap window-move-cursor
"
function! s:GotoNextWindow( direction, count )
  let l:prevWinNr = winnr()
  execute a:count . 'wincmd' a:direction
  return winnr() != l:prevWinNr
endfunction

function! s:JumpWithWrap( direction, opposite )
  if ! s:GotoNextWindow(a:direction, v:count1)
    call s:GotoNextWindow(a:opposite, 999)
  endif
endfunction


" =============================
" Window mappings (normal mode)
" =============================
" Standard window-jump mappings
nnoremap <silent> <C-h> :<C-u>call <SID>JumpWithWrap('h', 'l')<CR>
nnoremap <silent> <C-j> :<C-u>call <SID>JumpWithWrap('j', 'k')<CR>
nnoremap <silent> <C-k> :<C-u>call <SID>JumpWithWrap('k', 'j')<CR>
nnoremap <silent> <C-l> :<C-u>call <SID>JumpWithWrap('l', 'h')<CR>
" Standard window-resize mappings
nnoremap <C-Down>  :resize -5<cr>
nnoremap <C-Up>    :resize +5<cr>
nnoremap <C-Left>  :vertical resize -5<cr>
nnoremap <C-Right> :vertical resize +5<cr>
" Standard window-split mappings
nnoremap <C-w>-  :new<cr>:term<cr>
nnoremap <C-w>\| :vnew<cr>:term<cr>
" Seldom used, except by other shortcuts:
nnoremap <C-w>! :redraw!<cr>

" Replace Ctrl-P with FZF
nnoremap <C-o> :GFiles<cr>
nnoremap <C-p> :Buffers<cr>

map <esc>[1;5D <C-Left>
map <esc>[1;5C <C-Right>

" ==========================================
" Window mappings (NeoVim terminal emulator)
" ==========================================
" Standard window-jump mappings (with redraw to fix status line)
tmap <silent> <C-h> <C-\><C-n><C-h><C-w>!
tmap <silent> <C-j> <C-\><C-n><C-j><C-w>!
tmap <silent> <C-k> <C-\><C-n><C-k><C-w>!
tmap <silent> <C-l> <C-\><C-n><C-l><C-w>!
" Standard window-resize mappings
tmap <C-Down>  <C-\><C-n><C-Down>i
tmap <C-Up>    <C-\><C-n><C-Up>i
tmap <C-Left>  <C-\><C-n><C-Left>i
tmap <C-Right> <C-\><C-n><C-Right>i
" Standard window-split mappings
tmap <C-w>-  <C-\><C-n><C-w>-<cr>
tmap <C-w>\| <C-\><C-n><C-w>\|<cr>
" Seldom used, except by other shortcuts:
tnoremap <C-w>! <C-\><C-n>:redraw!<cr>i
" Doubletap <C-w> to escape the terminal
tnoremap <C-w><C-w> <C-\><C-n>
" Automatically jump into insert mode in terminals
autocmd TermOpen,BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
" autocmd TermClose term://.* bdelete!

" Better command line editing
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>

cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

" Incoming change... I get a lot of old SWP files hanging around when I crash.
set noswapfile

" This is useful
inoremap § #
