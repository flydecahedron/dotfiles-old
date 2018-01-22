" VIM config
" Description: For c/c++ dev
" Author: flydecahedron

" General stuff
filetype plugin on
"set noruler
"set laststatus=2 " always display status line
""show caps lock on the status line
"let b:keymap_name = "CAPS"
"set statusline+=%k

" tmux
set term=screen-256color

" remap window nav
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

" Disable vi compatibility
set nocompatible

" C indent options
set autoindent
set smartindent
set tabstop=4 "tab width
set shiftwidth=4 "indent width
set expandtab "expand tabs to spaces

" Pathogen plugin manager, git clone to ~/.vim/bundle/
execute pathogen#infect()

" syntax
set t_Co=256
syntax on
set number
set showmatch
set relativenumber

" cmake builds w/ my build.sh and clean.sh
" set makeprg=./build.sh

"" clang_complete
"let g:clang_snippets=1
"let g:clang_snippets_engine='clang_complete'
" SuperTab completion fall-back 
"let g:clang_complete_auto = 1
"let g:clang_complete_copen = 1
"let g:SuperTabDefaultCompletionType = '<C-X><C-U><C-P>'
"let g:clang_library_path='/usr/lib/libclang.so' " apparently its faster?
"let g:clang_complete_macros = 1 " for opengl 
au FileType c,cpp setlocal comments-=:// comments+=f://

" Supertab
" set tab default to omnicomplete
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabClosePreviewOnPopupClose = 1

" ctags
" Basically copy and pasta'd stuff from SO
" https://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks/741486#741486
" Supertab
" look upwards for ctags
set tags=./tags;/

" place to store all the ctags 
set tags+=/home/eroc/.tags

" use cscope
if has("cscope")
    set csprg=~/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif

" Custom dumb stuff
" Remap shift space to underscore for shitty python naming convention
" only works in gvim
inoremap <S-space> _

colorscheme jellybeans
