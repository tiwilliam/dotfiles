" Start required settings for vundle set nocompatible
filetype on
filetype plugin on
filetype plugin indent on

set t_Co=256 " use 265 colors in vim
"colorscheme ir_black_sg
colorscheme Tomorrow-Night

" Remember cursor position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

set nocompatible
set directory=/tmp

" Line number
set ruler
set number
syntax on

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set listchars=tab:»·,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

hi StatusLine term=reverse ctermbg=darkgreen term=reverse ctermfg=0
au InsertEnter * hi StatusLine term=reverse ctermbg=darkred term=reverse ctermfg=0
au InsertLeave * hi StatusLine term=reverse ctermbg=darkgreen term=reverse ctermfg=0

set wrap
set linebreak
set textwidth=0
set wrapmargin=0
set fo-=t
set sm
set list

" Indent
set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=4 softtabstop=4 shiftwidth=4

" Filetype specific settings
au BufNewFile,BufRead *.py set ft=python
au BufNewFile,BufRead *.pyx set ft=python

let g:pyflakes_use_quickfix = 0

highlight SpellBad ctermbg=red ctermfg=white guibg=#592929
highlight MarkError ctermbg=red ctermfg=white guibg=#592929

match MarkError /[\x7f-\xff]/   " Broken chars
match MarkError /\s\+\%#\@<!$/  " Extra whitespace
match MarkError /\%80v.\+/      " 80 char limit

" 79 char limit
if exists('+colorcolumn')
  highlight ColorColumn ctermbg=236
  set colorcolumn=79
endif

" Key bindings
map <C-LEFT> <ESC>:tabp<CR> 
map <C-RIGHT> <ESC>:tabn<CR> 

" Tags
set tags=~/.vimtags
let Tlist_Ctags_Cmd='/usr/bin/ctags'

" Aliases
:command! W w

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

" Make Command-T open files in new tabs instead of buffers
let g:CommandTAcceptSelectionMap = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<CR>'
