" .vimrc


" bundles with pathogen
"   to generate help documents, do `pathogen#helptags`
call pathogen#runtime_append_all_bundles()

" misc settings
set nocompatible           " less vi
set history=1000           " more history
set mouse=i                " enable mouse in all modes
set ruler                  " display cursor line and column
set virtualedit=block      " for visual block, cursor may be on nonexist char

" command settings
set showcmd
set wildmode=longest:full  " cmd completion - till longest match, then wildmenu
set wildmenu               " enhanced command line completion

" file settings
set title                  " sets title of window to file name
set autochdir              " cwd is dir containing file
set autoread               " watch for changes to file
filetype indent plugin on  " file type detection, indenting, and plugins
syntax on                  " syntax highlighting

" sizing, line breaks, tabs, and indentation
set autoindent smartindent " indent, smartly
set smarttab               " and tabbing behaves better
set expandtab              " soft tabs!
set shiftwidth=4
set softtabstop=4
set tabstop=8
set scrolloff=5            " keep 5 lines above/below
set showbreak=+++\         " prefix for word-wrapped lines
set textwidth=80

" search
set hlsearch               " highlight search matches
set incsearch              " incremental search
set ignorecase smartcase   " ignore case, unless search uses capitals

" colors
set t_Co=256               " more colors
colorscheme inkpot


" mappings
nnoremap ' `                " swap to more useful
nnoremap ` '
map + <C-W>+
map - <C-W>-
map <F5> ggg?G``
let mapleader=" "
map <Leader>e :BufExplorer<CR>
map <Leader>t :NERDTreeToggle<CR>

" plugin specific
let vimclojure#ParenRainbow = 1
let g:SuperTabDefaultCompletionType="context"
let g:NERDTreeQuitOnOpen=1

" file type specific
autocmd Filetype html                 setlocal shiftwidth=2
autocmd Filetype javascript           setlocal shiftwidth=2
autocmd Filetype ruby                 setlocal shiftwidth=2
autocmd BufRead,BufNewFile *.tpl      setlocal filetype=html
autocmd BufRead,BufNewFile *.mustache setlocal filetype=html
autocmd BufRead,BufNewFile *.rkt      setlocal filetype=clojure
autocmd BufRead,BufNewFile *.scm      setlocal filetype=clojure

command! Reload :! (pdflatex % &>/dev/null) &
autocmd BufWritePost *.tex silent Reload

