"------------------------------------------------------------------------------
" Features {{{1

" Disable compatibility with vi which can cause unexepcted issues.
set nocompatible

" Attempt to determin the type of a file based on its name.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting.
if has('syntax')
  syntax on
endif


"------------------------------------------------------------------------------
" Must have options {{{1

set hidden

" Better command-line completion.
set wildmenu

" Show partial commands in the last line of the screen.
set showcmd

" Highligh searches.
set hlsearch


"------------------------------------------------------------------------------
" Usability options {{{1

" Use case insensitive search, except  when using capital letters.
set ignorecase
set smartcase

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on.
set autoindent

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Display line numbers on the left.
set number


"------------------------------------------------------------------------------
" Indentation options {{{1

" Indentation settings for using 4 spaces instead of tabs.
set shiftwidth=4
set softtabstop=4
set expandtab


"------------------------------------------------------------------------------
" Mappings {{{1

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next seach
nnoremap <C-L> :nohl<CR><C-L>

