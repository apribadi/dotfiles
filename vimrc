" .vimrc

" bundles with pathogen
"   to generate help documents, do `pathogen#helptags`
call pathogen#runtime_append_all_bundles()

" misc settings
set nocompatible           " less vi
set history=1000           " more history
set mouse=i                " enable mouse in insert mode
set ruler                  " display cursor line and column
set virtualedit=block      " for visual block, cursor may be on nonexist char
set completeopt=menuone,longest

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
set autoindent             " indent, but not smart!
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
if $TERM =~ '^xterm'
    set t_Co=256           
    " set background=dark
    colorscheme inkpot_custom
endif


" mappings
let mapleader=" "
"noremap <C-j> <C-d>  " half-page down
"noremap <C-k> <C-u>  " half-page up
"map s <S-6>          " move to start
"map S I          " insert at start
"map a $          " move to end (append position)
"noremap + <C-W>+
"noremap - <C-W>-
"noremap s %
 
map <Leader>e :BufExplorer<CR>
map <Leader>t :NERDTreeToggle<CR>
map <Leader>a :Tabbi<CR>
map <F5> ggg?G``
map <C-o> o<Esc>

" plugin specific
"let vimclojure#ParenRainbow = 1
let g:SuperTabDefaultCompletionType="context"
let g:NERDTreeQuitOnOpen=1
"let g:lisp_rainbow=1

" file type sppcific
function FTScheme()
    setlocal shiftwidth=2
    setlocal equalprg=scmindent.scm
    runtime plugin/RainbowParenthsis.vim
endfunction

autocmd BufRead,BufNewFile *.mdt      setlocal filetype=tex
autocmd BufRead,BufNewFile *.tpl      setlocal filetype=html
autocmd BufRead,BufNewFile *.mustache setlocal filetype=html
autocmd BufRead,BufNewFile *.rkt      setlocal filetype=clojure
autocmd BufRead,BufNewFile Makefile   setlocal noexpandtab
autocmd BufRead,BufNewFile *.texp     setlocal filetype=tex
autocmd BufRead,BufNewFile *.txt      setlocal filetype=ignore

autocmd Filetype html                 setlocal shiftwidth=2
autocmd Filetype tex                  setlocal textwidth=80
autocmd Filetype javascript           setlocal shiftwidth=2
autocmd Filetype ruby                 setlocal shiftwidth=2
autocmd Filetype haskell              setlocal shiftwidth=2
autocmd Filetype scheme               call FTScheme()

function CompileTeX()
    if glob("Makefile") == ""
        silent ! (xelatex % &> /dev/null) &
    else
        silent ! (make &> /dev/null) &
    endif
endfunction

autocmd BufWritePost *.tex call CompileTeX()
