filetype off
filetype plugin on
filetype plugin indent on

set t_Co=256
set encoding=utf-8
set laststatus=2
set directory=/tmp
set nocompatible
set ruler
set number

" Make it fancy
syntax on
colorscheme ir_black_sg

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-powerline',

let g:pyflakes_use_quickfix = 0

highlight MarkError ctermbg=red ctermfg=white
match MarkError /[\x7f-\xff]/   " Broken chars
match MarkError /\s\+\%#\@<!$/  " Extra whitespace
match MarkError /\%80v.\+/      " 80 char limit

" 79 char limit
if exists('+colorcolumn')
  highlight ColorColumn ctermbg=236 ctermfg=white
  set colorcolumn=79
endif

" Remember cursor position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

autocmd BufWinEnter * call ResCur()

" Indent
set smarttab
set expandtab
set autoindent
set smartindent
set tabstop=4 softtabstop=4 shiftwidth=4

" Aliases
:command! W w

" TAB autocomplete
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction

inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
