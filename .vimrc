scriptencoding utf-8
set encoding=utf-8
" ===================
" Vundle Boilderplate
" ===================
" DONT FORGET TO RUN:
"   git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Forget vi compatibility. Must be first: Side effects change subsequent options.
set nocompatible
filetype off                   " required for Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'
" My Bundles here:
" ----------------
" * Add new github repositories below.
"   * If owned by "vim-scripts", omit the name
" * Hit <Leader>sv to relad
" * Run :BundleInstall to integrate
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'godlygeek/tabular'
Plugin 'tmhedberg/matchit'
Plugin 'mileszs/ack.vim'
Plugin 'docunext/closetag.vim'
Plugin 'zephod/molokai'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-unimpaired'
" Requires: sudo pip install nose, nose_machineout, vim_bridge
Plugin 'nvie/vim-pyunit'
"Plugin 'tpope/vim-surround'
Plugin 'junegunn/goyo.vim'
"Plugin 'klen/rope-vim'
"Plugin 'reinh/vim-makegreen'
"Plugin 'lambdalisue/nose.vim'
" -- Tmux
Plugin 'christoomey/vim-tmux-navigator'
" -- language plugins
Plugin 'vim-coffee-script'
Plugin 'othree/html5.vim'
Plugin 'groenewege/vim-less'
Plugin 'rodjek/vim-puppet'
Plugin 'java.vim'
Plugin 'groovy.vim'
" ----------------
call vundle#end()
filetype plugin indent on     " required for Vundle
" Powerline plugin
set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim
let g:ragtag_global_maps = 1
au BufEnter * if !exists('b:powerline_ctrlp_type') | let b:powerline_ctrlp_type = 'main' | endif
" MakeGreen plugin
" let g:makegreen_stay_on_file = 1
" ===============
" Vim Boilerplate
" ===============
" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Keep a backup file
set backup
set backupdir=/tmp
set dir=/tmp
" Keep 50 lines of command line history
set history=50		
" Show the cursor position all the time
set ruler		
" Display incomplete commands
set showcmd		
" Do incremental searching
set incsearch		
" Case insensitive search unless Search String cOnstains Capitals
set ignorecase
set smartcase
" Don't use Ex mode, use Q for formatting
map Q gq

let mapleader="\<Space>"
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
" The eighties are gone; we expect the mouse to work
if has('mouse')
  set mouse=a
endif
" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!
    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78
    " When editing a file, always jump to the last known cursor position.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif
  augroup END
endif 

" ===================
" Tom Editor Settings
" ===================
" Hack: Crontab opens vim but requires vi; correct my behaviour
if $VIM_CRONTAB == 'true'
  set nobackup
  set nowritebackup
endif
" Colorscheme
try
  colorscheme tomokai
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
endtry

" Highlight syntax
syntax on
" Don't highlight very long lines (it ruins performance)
set synmaxcol=800
" Highlight searches
set hlsearch
" Show absolute line numbers
set number
" Wordwrap should break at the end of words
set linebreak
" I really like seeing these characters sometimes
set listchars=tab:▸\ ,eol:¬
" Autocompletion mode: Search local,buffers,unloadedBuffers,Tags
set complete=.,b,u,]
" SUPER USEFUL make macros go fast again
set lazyredraw
" Highlight cursor line/column
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn
" Custom filetype mappings
au BufNewFile,BufRead *.cls set filetype=tex
au BufNewFile,BufRead *.md set filetype=markdown
" Autocompletion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
" OS X Clipboard Integration
set clipboard=unnamed
" Disable noise
set vb

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
" Set up default 4-space tabbing anyway
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
" Python code
autocmd FileType python call IndentWithSpaces(4)
autocmd FileType coffee call IndentWithSpaces(4)


" =============
" Key Remapping
" =============
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" nmap <silent> <C-m> :MakeGreen test_%<CR>
" When line-wrapping, move by SCREEN line not by FILE line
nnoremap j gj
nnoremap k gk
" Double tap the leader to toggle hidden characters
nnoremap <Leader><Leader> :set list!<Return>
" Leader-enter to toggle word wrap
set nowrap
nnoremap <Leader><Return> :set wrap!<Return>
" Leader-y to yank-append
nnoremap <Leader>y @".getline('.')
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
nnoremap <Leader>w :w<CR>
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>
nnoremap <silent> p p`]

" ===============
" Macvim settings
" ===============
if has('gui_running')
  " Font settings
  set guifont=Monaco_for_Powerline:h13
  "set fuoptions=background:#ff111111
  set guioptions-=T " Remove the toolbar
  set guioptions-=L " Remove the left scrollbar
  set guioptions-=r " Remove the right scrollbar
  " Window size
  set lines=44
  set columns=140
endif

" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
" Thin cursor in iTerm2
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

if &term=="screen-256color"
  " Thin cursor in iTerm2 in tmux
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif


" Stop ctrlp/commandt/:find showing me rubbish
set wildignore+=%*
set wildignore+=*.pyc
set wildignore+=node_modules
set wildignore+=_build
set wildignore+=_dist

" ==============
" Plugin: Ctrl-P
" ==============
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_working_path_mode = ''

" Playing with splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Split in a sensible direction
set splitbelow
set splitright
" Dont worry about hiding modified buffers
set hidden
" Show me tab-based autocomplete in command mode
set wildmenu

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

" Show current file in NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeMapOpenVSplit='<C-v>'
let NERDTreeMapOpenSplit='<C-x>'
let NERDTreeIgnore=['\.pyc$',"nodes"]

" PyUnit
let PyUnitCmd = "nosetests --quiet --with-doctest --logging-filter=-paramiko,-selenium --attr='!slow' --with-machineout"
let PyUnitTestsSplitWindow = 'no'
let PyUnitShowTests = 0

" Syntastic
let g:syntastic_python_checkers = ['python','pyflakes']
let g:syntastic_enable_signs = 1
let g:syntastic_always_populate_loc_list=1
" let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open = 1
" let g:syntastic_python_checkers = ['flake8']

" Python Debug
au FileType python map <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
au FileType python map <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>

" TODO Cycle backgrond between shade 17, 22, and 52, and 234

nnoremap <Leader>c :hi Normal ctermbg=17<Return>
nnoremap <Leader>c :hi Normal ctermbg=17<Return>

