" Tips:
" Search-and-replace with [visual, then cgn](http://vimcasts.org/episodes/operating-on-search-matches-using-gn/)
" 
scriptencoding utf-8

call plug#begin()
" Used to use unimpaired but I can't remember what the advantage was?
" Plug 'tpope/vim-unimpaired'
" Ctrl-N is the best
Plug 'scrooloose/nerdtree'
" Syntax-checking and static analysis of code
Plug 'scrooloose/syntastic'
" Jump into files
Plug 'kien/ctrlp.vim'
" Give me a git overview of file changes
Plug 'airblade/vim-gitgutter'
" :Tab to tabularise some text
Plug 'godlygeek/tabular'
" Supposedly improves the % jump, but I don't see it
Plug 'tmhedberg/matchit'
" Call Ack from inside vim
Plug 'mileszs/ack.vim'
" Automatically closes your HTML
Plug 'docunext/closetag.vim'
" My custom colourscheme
Plug 'zephod/molokai'
" Allows Vgc, gcc, other kinds of commenting
Plug 'tomtom/tcomment_vim'
" Distraction-free writing mode
Plug 'junegunn/goyo.vim'
" Seamlessly navigate tmux splits
" Plug 'christoomey/vim-tmux-navigator'
" Syntax highlighting for CoffeeScript
Plug 'vim-coffee-script'
" Syntax highlighting for HTML5
Plug 'othree/html5.vim'
" Syntax highlighting for Less
Plug 'groenewege/vim-less'
" Syntax highlighting for Puppet
Plug 'rodjek/vim-puppet'
" Syntax highlighting for Javascript
Plug 'pangloss/vim-javascript'
" Syntax highlighting for JSX
Plug 'mxw/vim-jsx'
" Syntastic: Use `eslint` from `node_modules`
Plug 'pmsorhaindo/syntastic-local-eslint.vim'
call plug#end()

" ==============
" PLUGIN: Ctrl-P
" ==============
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_working_path_mode = ''
" Stop ctrlp showing me rubbish
set wildignore+=%*
set wildignore+=*.pyc
set wildignore+=node_modules
set wildignore+=_build
set wildignore+=_dist

" ================
" PLUGIN: NerdTree
" ================
map <C-n> :NERDTreeToggle<CR>
let NERDTreeMapOpenVSplit='<C-v>'
let NERDTreeMapOpenSplit='<C-x>'
let NERDTreeIgnore=['\.pyc$',"nodes"]

" ===============
" PLUGIN: Tomokai
" ===============
try
  colorscheme tomokai
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
endtry

" =================
" PLUGIN: Syntastic
" =================
let g:syntastic_python_checkers = ['python','pyflakes']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_enable_signs = 1
let g:syntastic_always_populate_loc_list=1
" let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open = 1
let g:syntastic_full_redraws = 1

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

" TODO not sure whether these are worth paying attention to.
" " Autocompletion
" autocmd FileType python set omnifunc=pythoncomplete#Complete
" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP

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
autocmd FileType coffee call IndentWithSpaces(4)

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

nnoremap <silent> <C-h> :<C-u>call <SID>JumpWithWrap('h', 'l')<CR>
nnoremap <silent> <C-j> :<C-u>call <SID>JumpWithWrap('j', 'k')<CR>
nnoremap <silent> <C-k> :<C-u>call <SID>JumpWithWrap('k', 'j')<CR>
nnoremap <silent> <C-l> :<C-u>call <SID>JumpWithWrap('l', 'h')<CR>

" Resize window.
nnoremap “ :resize -5<cr>
nnoremap ‘ :resize +5<cr>
nnoremap <C-[> :vertical resize -5<cr>
nnoremap <C-]> :vertical resize +5<cr>

" NeoVim terminal emulator
tnoremap <silent> <C-h> <C-\><C-n>:<C-u>call <SID>JumpWithWrap('h', 'l')<CR>:redraw!<CR>
tnoremap <silent> <C-j> <C-\><C-n>:<C-u>call <SID>JumpWithWrap('j', 'k')<CR>:redraw!<CR>
tnoremap <silent> <C-k> <C-\><C-n>:<C-u>call <SID>JumpWithWrap('k', 'j')<CR>:redraw!<CR>
tnoremap <silent> <C-l> <C-\><C-n>:<C-u>call <SID>JumpWithWrap('l', 'h')<CR>:redraw!<CR>
tnoremap “     <C-\><C-n>:resize -5<cr>i
tnoremap ‘     <C-\><C-n>:resize +5<cr>i
tnoremap <C-[> <C-\><C-n>:vertical resize -5<cr>i
tnoremap <C-]> <C-\><C-n>:vertical resize +5<cr>i
" autocmd BufWinEnter,WinEnter term://* startinsert
" autocmd BufLeave term://* stopinsert

" Python Debug
au FileType python map <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
au FileType python map <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>
map <silent> <leader>> OXXX DataPress Patch >>><esc>gcc
map <silent> <leader>< o<<< DataPress Patch XXX<esc>gcckk

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
