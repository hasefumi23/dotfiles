syntax on

let mapleader="\<Space>"

"dein Scripts
"キャッシュを消したくなったら以下のコマンドを実行する
" :call dein#recache_runtimepath()
if &compatible
  set nocompatible
endif

" プラグインが実際にインストールされるディレクトリ
let s:dein_path = expand('~/.vim/dein')
" dein.vim 本体
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'

" Required:
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" deinなかったらcloneでもってくる
if !isdirectory(s:dein_repo_path)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
endif

if dein#load_state(s:dein_path)
  call dein#begin(s:dein_path)
  execute 'set runtimepath^=' . s:dein_repo_path

  let g:dein#install_progress_type = 'title'
  let g:dein#enable_notification = 1
  call dein#load_toml('~/.vim/rc/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.vim/rc/lazy_dein.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you wat to install not installed plugins on startup.
if dein#check_install()
 call dein#install()
endif

" for pulugin
" polyglot
let g:polyglot_disabled = ['markdown']

map _ <Plug>(operator-replace)
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

nmap <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
map <Leader>s <Plug>(easymotion-s2)

let g:comfortable_motion_interval = 2400.0 / 60
let g:comfortable_motion_friction = 100.0
let g:comfortable_motion_air_drag = 3.0

nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S

nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle

let g:fzf_layout = { 'down': '~50%'  }

set helplang=ja,en
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
set wildmode=list:full
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
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
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
set scrolloff=5
set display=lastline
set pumheight=10
set diffopt=internal,filler,algorithm:histogram,indent-heuristic

colorscheme pablo
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd InsertLeave * set nopaste

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

nnoremap <silent> [b :<C-u>bprevious<CR>
nnoremap <silent> ]b :<C-u>bnext<CR>
nnoremap <silent> [B :<C-u>bfirst<CR>
nnoremap <silent> ]B :<C-u>blast<CR>
nnoremap <silent> <tab> :<C-u>bnext<CR>
nnoremap <silent> <S-tab> :<C-u>bprevious<CR>
nnoremap <silent> <C-g> :<C-u>GFiles<CR>
nnoremap <silent> <C-p> :<C-u>Buffers<CR>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
nnoremap <f5> :!ctags -R<CR>
nnoremap Y y$
"nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :<C-u>q!<CR>
nnoremap <Leader>a ggVG
nnoremap <Leader>y ggVGy
nnoremap H ^
nnoremap L $
nnoremap <silent> <Leader>te :<C-u>term<cr>
nnoremap <Leader><CR> V:!sh<CR>
nnoremap * *N
nnoremap <Leader>R :source ~/.vimrc<CR>
nnoremap [ %

inoremap <silent> jj <ESC>
inoremap <C-a> ^
inoremap <C-e> $
"inoremap <C-p> <Up>
"inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <C-o>:call <SID>home()<CR>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-h> <BS>
inoremap <C-k> <C-r>=<SID>kill()<CR>

function! s:home()
  let start_column = col('.')
  normal! ^
  if col('.') == start_column
    normal! 0
  endif
  return ''
endfunction

function! s:kill()
  let [text_before, text_after] = s:split_line()
  if len(text_after) == 0
    normal! J
  else
    call setline(line('.'), text_before)
  endif
  return ''
endfunction

function! s:split_line()
  let line_text = getline(line('.'))
  let text_after  = line_text[col('.')-1 :]
  let text_before = (col('.') > 1) ? line_text[: col('.')-2] : ''
  return [text_before, text_after]
endfunction

vnoremap <Leader><CR> :!sh<CR>
vnoremap <c-a> <c-a>gv
vnoremap <c-x> <c-x>gv
vnoremap 8 i(
vnoremap 2 i"
vnoremap 7 i'
vnoremap @ i`
vnoremap [ i[
vnoremap { i{

onoremap 8 i(
onoremap 2 i"
onoremap 7 i'
onoremap @ i`
onoremap [ i[
onoremap { i{
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap ss :<C-u>sp<CR><C-w>w
nnoremap sv :<C-u>vs<CR><C-w>w

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

filetype plugin on
filetype plugin indent on

runtime macros/matchit.vim

set hidden
if has("autocmd")
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
endif

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

