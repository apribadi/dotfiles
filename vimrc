set nocompatible

set title
set autochdir

set autoindent             " indentation
set expandtab              " spaces for tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
set textwidth=80
set scrolloff=5            " keep 5 lines above/below

set hlsearch               " highlight matches
set incsearch              " incremental
set ignorecase smartcase   " upcase matches, too

filetype indent plugin on  " filetype sensitive
syntax on                  " syntax highlighting
set history=1000           " more history

nnoremap ' `                  " jump to mark   
nnoremap ` '

map + <C-W>+
map - <C-W>-

map <F5> ggg?G``

" file specific
"autocmd FileType c set noexpandtab tabstop=8 shiftwidth=8
autocmd BufRead *.html set shiftwidth=2
autocmd BufRead *.tpl set shiftwidth=2
autocmd BufRead *.mustache set shiftwidth=2 softtabstop=2
autocmd BufRead *.json set shiftwidth=2 softtabstop=2
autocmd Filetype ruby set shiftwidth=2
autocmd Filetype javascript set shiftwidth=2

