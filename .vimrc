" ===============
" Vim Boilerplate
" ===============
" Forget vi compatibility. Must be first: Side effects change subsequent options.
set nocompatible
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
" Don't use Ex mode, use Q for formatting
map Q gq
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
" The eighties are gone; we expect the mouse to work
if has('mouse')
  set mouse=a
endif
" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  filetype plugin indent on
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
" Load Pathogen
call pathogen#runtime_append_all_bundles() 
" Colorscheme
colorscheme tomokai
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
" Can I always be in the code folder, please?
cd /Users/zephod/code
" Highlight cursor line/column
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn
" Custom filetype mappings
au BufNewFile,BufRead *.article set filetype=html
au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.coffee set filetype=coffee
au BufNewFile,BufRead *.cls set filetype=tex
au BufNewFile,BufRead *.styl set filetype=stylus
au BufNewFile,BufRead *.hbs set filetype=html
au BufNewFile,BufRead *.md set filetype=markdown
" Autocompletion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

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
" Python code
autocmd FileType python call IndentWithSpaces(4)


" =============
" Key Remapping
" =============
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" When line-wrapping, move by SCREEN line not by FILE line
nnoremap j gj
nnoremap k gk
" Use ESC to kill search highlights
nnoremap <Leader><Esc> :nohlsearch<Return>
" Double tap the leader to toggle hidden characters
nnoremap <Leader><Leader> :set list!<Return>
" Leader-enter to toggle word wrap
set nowrap
nnoremap <Leader><Return> :set wrap!<Return>
" Split window
" nnoremap <Leader>s :belowright vnew<Return>
" Flush the command-t buffer
nnoremap <Leader>f :CommandTFlush<Return>
" Handle tabbing
nnoremap <Leader>q :tabp<Return>
nnoremap <Leader>w :tabn<Return>
nnoremap <Leader>n :tabnew<Return>

" ===============
" Macvim settings
" ===============
if has('gui_running')
  " Font settings
  set guifont=Consolas:h12
  set fuoptions=background:#ff111111
  set guioptions-=T " Remove the toolbar
  " Window size
  set lines=44
  set columns=140
endif

" =================
" Plugin: Command-T
" =================
" Open new tab when entering new file
let g:CommandTAcceptSelectionMap = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<CR>'
" Stop command-t showing me everything in my python environments
set wildignore+=%*
set wildignore+=*.pyc
set wildignore+=node_modules
set wildignore+=_build

