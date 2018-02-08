set nocompatible
set backspace=indent,eol,start
filetype off

" Vundle plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'wesleyche/Trinity'
Plugin 'bling/vim-bufferline'
Plugin 'rking/ag.vim'

call vundle#end()
filetype plugin indent on

" various tweaks
set autoindent
set number
set ruler

" default indentation - 4 chars, softtabs
set tabstop=4
set shiftwidth=4
set expandtab

" highlighting
syntax on
set hlsearch
set background=dark

" show tabs and trailing spaces
set list
set listchars=tab:>\ ,trail:-

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

" Open and close the Taglist separately
nmap <F9> :TrinityToggleTagList<CR>
" Open and close the NERD Tree separately
nmap <F10> :TrinityToggleNERDTree<CR>

" Enable indentation highlighting
nmap <F6> <Leader>ig

" Set CWD as window title
set title
set titlestring+=\ pwd:\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}
