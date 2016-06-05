set nocompatible
set backspace=indent,eol,start
filetype off

" Vundle plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'taglist.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'wesleyche/Trinity'
Plugin 'bling/vim-bufferline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'simplyzhao/cscope_maps.vim'

call vundle#end()
filetype plugin indent on

" various tweaks
set autoindent
set number
set ruler

" default indentation - 4 chars, hardtabs
set tabstop=4
set shiftwidth=4
set noexpandtab

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

" eclim support for ycm
let g:EclimCompletionMethod = 'omnifunc'

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
        echo "Hard tabs"
    else
        set expandtab
        echo "Soft tabs"
    endif
endfunction
nmap <F5> mz:execute TabToggle()<CR>'z

" Open CtrlP
nmap <F1> :CtrlPMixed .<CR>
" Open and close the Taglist separately
nmap <F9> :TrinityToggleTagList<CR>
" Open and close the NERD Tree separately
nmap <F10> :TrinityToggleNERDTree<CR>

" Set PWD as window title
set title
set titlestring+=\ pwd:\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}
