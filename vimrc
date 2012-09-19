" .vimrc

" bundles with pathogen
"   to generate help documents, do `pathogen#helptags`
call pathogen#infect()

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
"filetype indent plugin on  " file type detection, indenting, and plugins
filetype plugin on
filetype indent on
syntax on                  " syntax highlighting

" sizing, line breaks, tabs, and indentation
set autoindent             " indent, but not smart!
set smarttab               " and tabbing behaves better
set expandtab              " soft tabs!
set shiftwidth=4
set softtabstop=4
set tabstop=4
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
"map <Leader>e :BufExplorer<CR>
"map <Leader>t :NERDTreeToggle<CR>
"map <Leader>a :Tabbi<CR>

map <F4> ggg?G``
map <F5> :!make<CR>
map <C-o> o<Esc>

" plugin specific
"let vimclojure#ParenRainbow = 1
"let g:NERDTreeQuitOnOpen=1
"
"" IPA!
digraphs ez 658 "ezh
digraphs sw 601 "schwa
digraphs rs 602 "rhotacized schwa
digraphs oc 596 "open-mid back rounded vowel
digraphs ii 618 "small cap I 
digraphs lv 652 "small cap lambda
digraphs uu 650 "upside down upsilon
digraphs vf 611 "voiced velar fricative, looks like gamma
digraphs pf 661 "voiced pharyngeal fricative

"eth is d-

let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabDefaultCompletionType = "<C-x><C-o>"


" file type sppcific
function FTScheme()
    setlocal shiftwidth=2
    setlocal equalprg=scmindent.scm
    setlocal lispwords+=,module,object,operation,syntax-rules,loop-range,loop
    setlocal lispwords+=,define-class,define-method,define-generic
    setlocal lispwords+=,let-values,condition-case,with-input-from-string
    setlocal lispwords+=,with-output-to-string,handle-exceptions,call/cc,rec,receive
    setlocal lispwords+=,call-with-output-file

    setl include=\^\(\\(use\\\|require-extension\\)\\s\\+
    setl includeexpr=substitute(v:fname,'$','.scm','')
    setl path+=/usr/local/lib/chicken/3
    setl suffixesadd=.scm
    let g:rbpt_colorpairs = [
    \ ['red',     'DarkOrchid3'],
    \ ['cyan',    'SeaGreen3'],
    \ ['brown',       'RoyalBlue3'],
    \ ['gray',    'DarkOrchid3'],
    \ ['green',   'firebrick3'],
    \ ['cyan',    'RoyalBlue3'],
    \ ['red',     'SeaGreen3'],
    \ ['magenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['magenta', 'DarkOrchid3'],
    \ ['green',   'RoyalBlue3'],
    \ ]
    RainbowParenthesesToggle
    
    " note file ~/.lispwords
    " runtime plugin/RainbowParenthsis.vim
endfunction

autocmd BufRead,BufNewFile *.mdt      setlocal filetype=tex
autocmd BufRead,BufNewFile *.tpl      setlocal filetype=html
autocmd BufRead,BufNewFile *.mustache setlocal filetype=html
autocmd BufRead,BufNewFile *.rkt      setlocal filetype=clojure
autocmd BufRead,BufNewFile *.cljs      setlocal filetype=clojure
autocmd BufRead,BufNewFile Makefile   setlocal noexpandtab tabstop=8
autocmd BufRead,BufNewFile *.go       call GoFile()
autocmd BufRead,BufNewFile *.texp     setlocal filetype=tex
autocmd BufRead,BufNewFile *.txt      setlocal filetype=ignore
autocmd BufRead,BufNewFile *.tas      setlocal filetype=xml
autocmd BufRead,BufNewFile *.m        setlocal filetype=mercury
autocmd BufRead,BufNewFile *.md       setlocal filetype=text
autocmd BufRead,BufNewFile *.sage     setlocal filetype=python

autocmd Filetype xml                  call XmlFormat()
autocmd Filetype html                 setlocal shiftwidth=2 
autocmd Filetype tex                  setlocal indentexpr=
autocmd Filetype tex                  call TeXFile()
autocmd Filetype javascript           setlocal shiftwidth=2
autocmd Filetype ruby                 setlocal shiftwidth=2
"autocmd Filetype haskell              setlocal shiftwidth=2
autocmd Filetype scheme               call FTScheme()
autocmd Filetype factor               setlocal shiftwidth=2
autocmd Filetype rust                 setlocal formatoptions+=cro

function XmlFormat()
    map <buffer> <F5> :%!tidy -quiet -indent --indent-spaces 2 -xml --vertical-space t <CR>
    setlocal equalprg="tidy -quiet --show-errors 0 -indent -xml"
    "setlocal filetype=html

    " silent 1,$!tidy --input-xml true --indent yes 2>/dev/null
endfunction

function GoFile()
    setlocal noexpandtab
    let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
endfunction

function TeXCompile()
    if glob("Makefile") == ""
        silent ! (xelatex % &> /dev/null) &
    else
        silent ! (make &> /dev/null) &
    endif
endfunction

function TeXFile()
    if getline(1) =~ 'hmcthesis'
        setlocal foldmethod=expr
        setlocal foldexpr=TeXFold(v:lnum)
    endif
    filetype plugin off
endfunction

function! TeXFold(line)
    if getline(a:line) =~ '^.chapter'
        return '1'
    "elseif getline(a:line) =~ '^.section'
        "return '2'
    elseif getline(a:line) =~ '^.documentclass'
        return '1'
    elseif getline(a:line + 1) =~ '^.chapter'
        return '<1'
    else
        return '-1'
    endif
endfunction

function Make()
        silent ! (make &> /dev/null) &
endfunction

autocmd BufWritePost *.tex call TeXCompile()

set listchars=nbsp:¬
"set list
