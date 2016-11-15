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
nnoremap <F4> :set nu!<CR>
imap <F4> <C-O>:set nu!<CR>

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
nnoremap <F3> :set invpaste paste?<CR>
imap <F3> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F3>

" map vu to quick open unittest_file in split window
map <Leader>vu <esc>:vs unittest_%<CR>

" find word in project
vnoremap <c-f> :<BS><BS><BS><BS><BS>noautocmd execute "lvimgrep /" . expand("<cword>") . "/gj **/*" <Bar> lw<CR>

" map a to quick check words grammer with aspell
map <Leader>a <esc>:!aspell -c %<CR>

" map q to quick quit that's efficient for multi-subwindows
map <Leader>q <esc>:q<CR>
map <Leader>qq <esc>:q!<CR>
map <Leader>wq <esc>:wq<CR>
