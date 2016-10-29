" Auto reloading of vimrc after save
autocmd! bufwritepost vimrc source %

" remap esc to jj. Though it already be replaced by ctrl+c or ctrl+[
ino jj <esc>
cno jj <c-c>

" mouse add
set mouse=a

" Rebind <Leader> key
let mapleader = ';'

" moving betwwn tabs
map <Leader>N <esc>:tabprevious<CR>
map <Leader>n <esc>:tabnext<CR>

" moving around sub-windows
map <Leader>j <c-w>j
map <Leader>k <c-w>k
map <Leader>h <c-w>h
map <Leader>l <c-w>l

" set tab=4 space
set ts=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" auto indent depend on the above line indent
" set autoindent
" delete all space line
map <Leader>dl :g/^\s*$/d<CR>

" create a new vert sub window to diff two file
map <Leader>df :vert diffsplit<space>

" smart complemation {}[]()
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
function! ClosePair(char)
if getline('.')[col('.') - 1] == a:char
return "\<Right>"
else
return a:char
endif
endfunction

" python quick run from vi command
map <Leader>rp :call RunPython()<CR>
func! RunPython()
exec "w"
exec "!python %"
endfunc
map <Leader>ru :call RunUnittest()<CR>
func! RunUnittest()
exec "w"
exec "!python unittest_%"
endfunc
map <Leader>rb :call RunBash()<CR>
func! RunBash()
exec "w"
exec "!bash %"
endfunc
map <Leader>r :!python %<space>

" never backup
set nobackup

" show line number
set nu

" add file head content for script and markdown
autocmd BufNewFile *.sh,*.py exec ":call SetScriptTitle()"
func! SetScriptTitle()
call setline(1,"\#########################################################################")
call append(line("."), "\# File Name: ".expand("%"))
call append(line(".")+1, "\# Purpose:")
call append(line(".")+2, "\#\tThis file is to")
call append(line(".")+3, "\# History:")
call append(line(".")+4, "\#\tCreated Time: ".strftime("%F"))
call append(line(".")+5, "\# Author: Don E-mail: dpdeng@whu.edu.cn")
call append(line(".")+6, "\#########################################################################")
autocmd BufNewFile * normal G
endfunc
autocmd BufNewFile *.md exec ":call SetMdPattern()"
func! SetMdPattern()
call setline(1,"\---")
call append(line("."), "\layout: post")
call append(line(".")+1, "title: Markdown自动设定")
call append(line(".")+2, "\date: ".strftime("%F"))
call append(line(".")+3, "\categories: python")
call append(line(".")+4, "tags: Markdown Vim")
call append(line(".")+5, "\---")
call append(line(".")+6, "\#### <strong>History:</strong>")
call append(line(".")+7, "* <em>20160911</em>:将内容记录下来</br>")
call append(line(".")+8, "")
call append(line(".")+9, "\#### <strong>Background:</strong>")
call append(line(".")+10, "")
call append(line(".")+11, "\#### <strong>Content:</strong>")
autocmd BufNewFile * normal G
endfunc

" map sort function to a key
vnoremap <Leader>ss :sort<CR>

" easier moving of blocks
vnoremap < <gv
vnoremap > >gv

" Enable syntax highliting, need reload the file for first time, already in
" following plugin configuration
"filetype off
"filetype plugin indent on
"syntax on

" Formatting of paragraphs, avoid word separated by lines
vmap Q gq
nmap Q gqap

" disable backup and swap file
set nobackup
set nowritebackup
set noswapfile

" map f2 to forbid auto-indent when paste
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" find word in project
vnoremap <c-f> :<BS><BS><BS><BS><BS>noautocmd execute "lvimgrep /" . expand("<cword>") . "/gj **/*" <Bar> lw<CR>

" map vu to quick open unittest_file in split window
map <Leader>vu <esc>:vs unittest_%<CR>

" Put your non-Plugin stuff above this line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Configuration for Plugin
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
Plugin 'VundleVim/Vundle.vim'

" use za to fold/unfold code block, zj and zk to move between them
Plugin 'SimpylFold'
map <Leader>z za
map <Leader>c zM
map <Leader>x zR

" check pythen syntax problem when save
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
let python_highlight_all=1
syntax on

" smart complete for py with tab, then move choose by c-n or c-p
" besides, we can use c-n for text complete
"Plugin 'Pydiction'
"let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'

" smart complete
Plugin 'Valloric/YoucompleteMe'
" set bak global conf file
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
" don't ask to confirm conf file
let g:ycm_confirm_extra_conf=0
set completeopt=longest,menu
" set python path
let g:ycm_path_to_python_interpreter='/usr/bin/python'
" set complete with syntax
let g:ycm_seed_identifiers_with_syntax=1
" set complete in comments
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings=0
" set min num of chars to start complete
let g:ycm_min_num_of_chars_for_completion=2
" close preview dialog after completion
let g:ycm_autoclose_preview_window_after_completion=1
" complete string
let g:ycm_complete_in_strings=1

" use c-p to search file
Plugin 'ctrlp.vim'
"let g:ctrlp_map = '<c-p>' " don't need
 
" use c-shit-f to search variable
Plugin 'dyng/ctrlsf.vim'
map <Leader>f <Plug>CtrlSFPrompt
map <Leader>F <Plug>CtrlSFQuickfixPrompt

" show class or functions 
Plugin 'majutsushi/tagbar'
map <Leader>d :TagbarToggle<CR>

" show indent-line
Plugin 'Yggdroot/indentLine'
let g:indentLine_char='|'
let g:indentLine_enabled=1

" auto format code
Plugin 'tell-k/vim-autopep8'
let g:autopep8_disable_show_diff=1

" quick comment
Plugin 'scrooloose/nerdcommenter'
map <Leader>m <Leader>ci <CR>

" show file tree
Plugin 'scrooloose/nerdtree'
map <Leader>t :NERDTreeToggle<CR>
let NERDTreeChDirMode=1
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\~$','\.pyc$','\.swp$']
let NERDTreeWinSize=20

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
"
"  Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
