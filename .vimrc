"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/user/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/user/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('/Users/user/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('preservim/nerdtree')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

" My settings
syntax on
filetype plugin indent on
set number
set list
set backspace=indent,eol,start
set shiftwidth=4
set tabstop=4
set autoread
set showcmd
set cursorline
set wildmenu
set incsearch
set hlsearch
set showmatch
set smartindent
set expandtab

"" NERDTree
let NERDTreeShowHidden=1

"" dein
call map(dein#check_clean(), "delete(v:val, 'rf')")
