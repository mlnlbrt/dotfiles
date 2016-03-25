set nocompatible
set backspace=indent,eol,start
filetype off

" YCM
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'wesleyche/Trinity'
Plugin 'bling/vim-bufferline'

call vundle#end()
filetype plugin indent on

" various tweaks
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set number

" highlighting
syntax on
set hlsearch
set background=dark

" taglist tweaks
let Tlist_Auto_Update = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1

" ycm tweaks
let g:ycm_autoclose_preview_window_after_insertion = 1

" shortcuts
nnoremap <F2> :set tabstop=2 shiftwidth=2 expandtab
nnoremap <F3> :set tabstop=4 shiftwidth=4 expandtab
nnoremap <F4> :set tabstop=8 shiftwidth=8 noexpandtab
nnoremap <F8> :set invpaste paste?<CR>
set pastetoggle=<F8>
set showmode

" toggle between hard-tabs and spaces
function TabToggle()
    if &expandtab
        set noexpandtab
    else
        set expandtab
    endif
endfunction
nmap <F5> mz:execute TabToggle()<CR>'z

" trinity shortcuts
" Open and close the Taglist separately
nmap <F9> :TrinityToggleTagList
" Open and close the NERD Tree separately
nmap <F10> :TrinityToggleNERDTree
