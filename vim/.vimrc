"------------------------------------------------------------
" Features {{{1

" Set 'nocompatible' to ward off unexpected things that our
" distro might have made
set nocompatible

" Attempt to determin the type of a file based on its name
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif


"------------------------------------------------------------
" Cmd options {{{1

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highligh searches
set hlsearch


"------------------------------------------------------------
" Usability options {{{1

" Display line numbers on the left
set number


"------------------------------------------------------------
" Indentation options {{{1

" Indentation settings for using 4 spaces instead of tabs.
set shiftwidth=4
set softtabstop=4
set expandtab
