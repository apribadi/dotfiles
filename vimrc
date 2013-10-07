set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'JuliaLang/julia-vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'edsono/vim-matchit'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/EasyMotion'
Bundle 'vim-scripts/snipMate'
set rtp+=~/.opam/system/share/ocamlmerlin/vim
set rtp+=~/.opam/system/share/ocamlmerlin/vimbufsync
" YouCompleteMe installed separately

Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'tpope/vim-unimpaired'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/vimshell.vim'

filetype plugin on
filetype indent on
syntax on                  " syntax highlighting

" misc settings
set history=1000           " more history
set mouse=i                " enable mouse in insert mode
set ruler                  " display cursor line and column
set virtualedit=block      " for visual block, cursor may be on nonexist char
set number                 " line numbers
set undofile               " enable persistent undo 
set undodir=/home/apribadi/.vim/undo
set backspace=indent,eol,start
" set helpheight=200

" command settings
set showcmd
set wildmode=longest:full  " cmd completion - till longest match, then wildmenu
set wildmenu               " enhanced command line completion
set completeopt=menuone,longest

" file settings
set title                  " sets title of window to file name
set autoread               " watch for changes to file

" sizing, line breaks, tabs, and indentation
set autoindent             " autoindent, but not smartindent!
set smarttab               " tabbing behaves better
set expandtab              " soft tabs!
set shiftwidth=4
set shiftround
set tabstop=8
set scrolloff=5            " keep 5 lines above/below
set showbreak=+++\         " prefix for word-wrapped lines
set textwidth=80
set listchars=nbsp:¬       " display some invisible characters

" search
set hlsearch               " highlight search matches
set incsearch              " incremental search
set ignorecase smartcase   " ignore case, unless search uses capitals

" colors
if $TERM =~ '^xterm'
    set t_Co=256           
    set background=dark
    colorscheme solarized
endif

" mappings
let mapleader=' '
let maplocalleader=' '
let g:EasyMotion_leader_key='<Leader>'
map <F5> ggVGg?

" IPA
digraphs ez 658 "ezh
digraphs sw 601 "schwa
digraphs rs 602 "rhotacized schwa
digraphs oc 596 "open-mid back rounded vowel
digraphs ii 618 "small cap I 
digraphs lv 652 "small cap lambda
digraphs uu 650 "upside down upsilon
digraphs vf 611 "voiced velar fricative, looks like gamma
digraphs pf 661 "voiced pharyngeal fricative
digraphs !? 8253

" some variables
let g:snips_trigger_key='<C-\>'
let g:vimclojure#ParenRainbow=1
let g:tex_conceal='mg'
let ocaml_noend_error=1
" let g:syntastic_ocaml_checkers=['merlin']

" filetype specific

function TeXCompile()
    if glob("Makefile") == ""
        silent ! (xelatex % &> /dev/null) &
    else
        silent ! (make &> /dev/null) &
    endif
endfunction

au BufWritePost *.tex call TeXCompile()
au BufWritePost *.coffee silent ! (coffee -c % &> /dev/null) &
au BufRead,BufNewFile *.md setlocal filetype=markdown

au FileType rust    setlocal formatoptions=lncrq
au FileType html    setlocal shiftwidth=2
au FileType coffee  setlocal shiftwidth=2
au FileType haskell setlocal shiftwidth=2
au FileType make    setlocal shiftwidth=8 noexpandtab
au FileType ocaml   setlocal shiftwidth=2
au FileType ocaml   setlocal commentstring=(*%s*)
