syntax on

set fenc=utf-8
set encoding=utf-8
scriptencoding utf-8
set fileformat=unix
set ttyfast
set cursorline
set number
set relativenumber
set mouse=a
set ttymouse=xterm2
set wildmenu
set whichwrap=b,s,[,],<,>
set wildmode=list:longest
set visualbell
set virtualedit=block
set title
set tabstop=2
set smarttab
set smartindent
set shiftwidth=2
set showmatch
set showcmd
set shiftround
set nowrap
set noswapfile
set nobackup
set nrformats=
set nrformats-=octal
set listchars=tab:Â»-,trail:-,eol:â†²,extends:Â»,precedes:Â«,nbsp:%
set list
set laststatus=2
set incsearch
set hlsearch
set history=200
set hidden
set expandtab
set backspace=indent,eol,start
set ambiwidth=double
set autoread
set statusline=[%{StatuslineMode()}]
set statusline+=\ %<%f\ %m
set statusline+=\ %h%r%=%-14.(%l,%c%V%)\ [%{&fenc!=''?&fenc:&enc}][%{&ff}]\ %L%8P
colorscheme pablo
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd InsertLeave * set nopaste

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
nnoremap <f5> :!ctags -R<CR>

" for matchit
set nocompatible
filetype plugin on
runtime macros/matchit.vim

set nocompatible
filetype plugin indent on
set hidden
if has("autocmd")
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
endif

set nocompatible
filetype plugin on

xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
    let buffer_numbers = {}
    for quickfix_item in getqflist()
        let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
    endfor
    return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  endif
endfunction

if system('uname -a | grep Microsoft') != ''
  augroup myYank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe', @")
  augroup END
endif
