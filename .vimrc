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
  "call dein#load_toml('~/.vim/rc/lazy_dein.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
  " プラグインのアップデートは、以下のコマンド
  " :call dein#update('dein.vim')
endif

" Required:
filetype plugin on
filetype plugin indent on
syntax enable

" If you wat to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

let s:removed_plugins = dein#check_clean()
if !exists('g:vscode')
  if len(s:removed_plugins) > 0
    call map(s:removed_plugins, "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
  endif
end

" ##############################
" # for plugin
" ##############################

" === plugin ===
map _ <Plug>(operator-replace)
" vmap v <Plug>(expand_region_expand)
" vmap <C-v> <Plug>(expand_region_shrink)

" === plugin easymotion ===
nmap <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
map <Leader>s <Plug>(easymotion-s2)

" === plugin sneak ===
map f <Plug>Sneak_f
map F <Plug>Sneak_F
" map s <Plug>Sneak_s
" map S <Plug>Sneak_S

" === plugin nerdcommenter ===
nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle

" === plugin fzf.vim ===
nnoremap <silent> <C-g> :<C-u>BLines<CR>
nnoremap <silent> <C-p> :<C-u>Files .<CR>
nnoremap <silent> <C-f>l :<C-u>Lines<CR>
nnoremap <silent> <C-f>b :<C-u>Buffers<CR>
nnoremap <silent> <C-f>g :<C-u>GFiles<CR>
nnoremap <silent> <C-f>f :<C-u>Files<CR>
nnoremap <silent> <C-f>r :<C-u>Rg<CR>

" :Filesによる表示の変更
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8, 'highlight': 'Todo', 'border': 'horizontal' } }
let g:fzf_buffers_jump = 1

" === plugin quickrun ===
let g:quickrun_config={'*': {'split': ''}}

nnoremap <Leader>d :Gdiffsplit<CR>
set updatetime=200
let g:gitgutter_override_sign_column_highlight = 0
nmap gp <Plug>(GitGutterPrevHunk)
nmap gn <Plug>(GitGutterNextHunk)

" === plugin incsearch ===
" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)

" === plugin incsearch-fuzzy.vim ===
" map z/ <Plug>(incsearch-fuzzyspell-/)
" map z? <Plug>(incsearch-fuzzyspell-?)
" map zg/ <Plug>(incsearch-fuzzyspell-stay)

" === plugin haya14busa/incsearch-migemo.vim ===
map m/ <Plug>(incsearch-migemo-/)
map m? <Plug>(incsearch-migemo-?)
map mg/ <Plug>(incsearch-migemo-stay)

" === plugin plasticboy/vim-markdown ===
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" === plugin reireias/vim-cheatsheet ===
let g:cheatsheet#cheat_file = '~/.ghq/github.com/hasefumi23/dotfiles/vim_cheat.md'
command! EditCheat :edit ~/.ghq/github.com/hasefumi23/dotfiles/vim_cheat.md
let g:cheatsheet#float_window = 1
" you can change float window size.
let g:cheatsheet#float_window_width_ratio = 0.8
let g:cheatsheet#float_window_height_ratio = 0.8
nnoremap <Leader>? <Cmd>Cheat<CR>
nnoremap <leader>f. <Cmd>EditCheat<CR>

" === plugin plasticboy/vim-markdown ===
let g:sonictemplate_vim_template_dir = ['~/.vim/template']

" === plugin glacambre/firenvim ===
let g:firenvim_config = { 
    \ 'localSettings': {
        \ '.*': {
            \ 'priority': 0,
            \ 'takeover': 'never',
        \ },
    \ }
\ }

if exists('g:started_by_firenvim')
  nnoremap <leader>font :set guifont=UDEV_Gothic_NF:h18<CR>
endif

if !exists('g:vscode')
  " === plugin hrsh7th/vim-searchx ===
  " Overwrite / and ?.
  nnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
  nnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
  xnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
  xnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
  cnoremap ; <Cmd>call searchx#select()<CR>

  " Move to next/prev match.
  nnoremap N <Cmd>call searchx#prev_dir()<CR>
  nnoremap n <Cmd>call searchx#next_dir()<CR>
  xnoremap N <Cmd>call searchx#prev_dir()<CR>
  xnoremap n <Cmd>call searchx#next_dir()<CR>
  nnoremap <C-k> <Cmd>call searchx#prev()<CR>
  nnoremap <C-j> <Cmd>call searchx#next()<CR>
  xnoremap <C-k> <Cmd>call searchx#prev()<CR>
  xnoremap <C-j> <Cmd>call searchx#next()<CR>
  cnoremap <C-k> <Cmd>call searchx#prev()<CR>
  cnoremap <C-j> <Cmd>call searchx#next()<CR>

  " Clear highlights
  nnoremap <C-l> <Cmd>call searchx#clear()<CR>

  let g:searchx = {}

  " Auto jump if the recent input matches to any marker.
  let g:searchx.auto_accept = v:true

  " The scrolloff value for moving to next/prev.
  let g:searchx.scrolloff = &scrolloff

  " To enable scrolling animation.
  let g:searchx.scrolltime = 500

  " To enable auto nohlsearch after cursor is moved
  let g:searchx.nohlsearch = {}
  let g:searchx.nohlsearch.jump = v:true

  " Marker characters.
  let g:searchx.markers = split('ABCDEFGHIJKLMNOPQRSTUVWXYZ=@`[{}];+:*,.<>', '.\zs')

  " Convert search pattern.
  function g:searchx.convert(input) abort
    if a:input !~# '\k'
      return '\V' .. a:input
    endif
    return a:input[0] .. substitute(a:input[1:], '\\\@<! ', '.\\{-}', 'g')
  endfunction
end

if !exists('g:vscode')
  set ambiwidth=double
end
scriptencoding utf-8
set autoread
set backspace=indent,eol,start
set breakindent
set clipboard+=unnamed
" set cursorcolumn
" set clipboard+=unnamed
set clipboard&
set clipboard^=unnamedplus
" set cursorcolumn
set cursorline
set cmdwinheight=20
set display=lastline
set encoding=utf-8
set expandtab
set fenc=utf-8
set fileformat=unix
set fileencoding=utf-8
set fileencodings=utf-8,cp932,sjis,utf-16,iso-2022-jp,euc-jp
set fileformats=unix,dos,mac
set foldmethod=marker
set helplang=ja,en
set hidden
set history=200
set hlsearch
set incsearch
set ignorecase
set laststatus=2
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set iskeyword-==
set iskeyword-=-
set mouse=a
set nobackup
set nowritebackup
set noswapfile
set nrformats-=octal
set nrformats=
set number
set pumheight=10
set relativenumber
set scrolloff=5
set shiftround
set shiftwidth=2
set shortmess-=S
set showcmd
set showmatch
set showtabline=2
set smartcase
set smartindent
set smarttab
set tabstop=2
set title
set ttyfast
set virtualedit=block
set visualbell
set whichwrap=b,s,h,l,<,>,[,],~
set wildmenu
set wildmode=list:full

" for vim nvim compatible
if has('nvim')
  set inccommand=split
else
  set ttymouse=xterm2
endif

if !exists('g:vscode')
  if has('win32') || has ('win64')
    " colorscheme iceberg
    colorscheme nord
  else
    " colorscheme pablo
    " colorscheme iceberg
    colorscheme nord
    " colorscheme cobalt2
    " colorscheme Tomorrow-Night-Blue
  endif
end

highlight Normal ctermbg=NONE
highlight Visual cterm=reverse
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd InsertLeave * set nopaste
" hi NonText    ctermbg=None ctermfg=59 guibg=NONE guifg=None
" hi SpecialKey ctermbg=None ctermfg=59 guibg=NONE guifg=None

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

" cmap
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" imap
inoremap <C-a> <C-o>:call <SID>home()<CR>
inoremap <C-a> <Home>
inoremap <C-b> <Left>
inoremap <C-d> <Del>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-h> <BS>
inoremap <C-k> <C-r>=<SID>kill()<CR>
" 残念ながらWSLでは動かない
" inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
inoremap <silent> jj <ESC>

" vmap
vnoremap 2 i"
vnoremap 7 i'
vnoremap 8 i(
vnoremap < <gv
vnoremap <Leader><CR> :!sh<CR>
vnoremap <c-a> <c-a>gv
vnoremap <c-x> <c-x>gv
vnoremap > >gv
vnoremap @ i`
vnoremap [ i[
" replace currently selected text with default register without yanking it
vnoremap p "0p
vnoremap P "0P
" vnoremap p "_dp
vnoremap { i{
vnoremap v $h

" omap
onoremap , i<
onoremap 2 i"
onoremap 7 i'
onoremap 8 i(
onoremap @ i`
onoremap [ i[
onoremap { i{

" normal mapping
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)
nmap S[ v$hS]
nmap S] veS]
nmap S8 v$hS)
nmap S9 veS)
nmap S2 v$hS"
nmap S7 v$hS'

nnoremap * *N
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
nnoremap <Leader><CR> V:!sh<CR>
nnoremap <Leader>R :source ~/.vimrc<CR>
nnoremap <Leader>a ggVG
nnoremap <Leader>vim :e ~/.vimrc<CR>
nnoremap <Leader>y "Ayy
nnoremap <Leader>p "Ap
nnoremap <f5> :!ctags -R<CR>
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>
nnoremap <silent> <Leader>te :term<cr>
nnoremap <silent> <S-tab> :bprevious<CR>
nnoremap <silent> <tab> :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [C :cfirst<CR>
nnoremap <silent> [c :cprevious<CR>
nnoremap <silent> ]C :clast<CR>
nnoremap <silent> ]c :cnext<CR>
nnoremap H ^
nnoremap L $
nnoremap Y y$
nnoremap [ %
nnoremap zH <C-w>H
nnoremap zJ <C-w>J
nnoremap zK <C-w>K
nnoremap zL <C-w>L
nnoremap zO <C-w>=
nnoremap zh <C-w>h
nnoremap zj <C-w>j
nnoremap zk <C-w>k
nnoremap zl <C-w>l
nnoremap zo <C-w><Bar><C-w>_
nnoremap zs :sp<CR><C-w>w
nnoremap zv :vs<CR><C-w>w
nnoremap j gj
nnoremap k gk

" cut はレジスタへの登録はしない(若干直感に反するが、実用性を重視する)
vnoremap x "_x
nnoremap x "_x
nnoremap dx "_dd

command! Sps :s/\v\s+/\r/g
command! Spc :s/\v\s*,\s*/\r/g

if !exists('g:vscode')
  call submode#enter_with('bufmove', 'n', '', '<C-w>>', '<C-w>>')
  call submode#enter_with('bufmove', 'n', '', '<C-w><', '<C-w><')
  call submode#enter_with('bufmove', 'n', '', '<C-w>+', '<C-w>+')
  call submode#enter_with('bufmove', 'n', '', '<C-w>-', '<C-w>-')
  call submode#map('bufmove', 'n', '', '>', '5<C-w>>')
  call submode#map('bufmove', 'n', '', '<', '5<C-w><')
  call submode#map('bufmove', 'n', '', '+', '5<C-w>+')
  call submode#map('bufmove', 'n', '', '-', '5<C-w>-')
end

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

if has('persistent_undo')
  let undo_path = expand('~/.vim/undo')
  exe 'set undodir=' . undo_path
  set undofile
endif

" if system('uname -a | grep -E "(M|m)icrosoft"') != ''
"   augroup myYank
"     autocmd!
"     autocmd TextYankPost * :call system('win32yank.exe -i', @")
"   augroup END
" endif

function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! g:PrintRangeFromZero(end)
  put = range(0, a:end)
endfunction

noremap <leader>gp :call g:PrintRangeFromZero()<left>

" Toggle quickfix
if exists('g:__QUICKFIX_TOGGLE__')
    finish
endif
let g:__QUICKFIX_TOGGLE__ = 1

function! ToggleQuickfix()
    let l:nr = winnr('$')
    cwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        cclose
    endif
endfunction
nnoremap <script> <silent> <leader>q :call ToggleQuickfix()<CR>

if executable('rg')
  let &grepprg = 'rg --vimgrep --hidden'
  set grepformat=%f:%l:%c:%m
endif

if exists('g:vscode')
  nnoremap gf <Cmd>call VSCodeNotify('extension.go-file-undercursor')<CR>
  nnoremap yr <Cmd>call VSCodeNotify('copyRelativeFilePath')<CR>
  nnoremap <C-g> <Cmd>call VSCodeNotify('fuzzySearch.activeTextEditor')<CR>
  nnoremap K <Cmd>call VSCodeNotify('editor.action.showDefinitionPreviewHover')<CR>
  nnoremap za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
  nnoremap <leader>gd <Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>
  nnoremap <leader>gi <Cmd>call VSCodeNotify('editor.action.peekImplementation')<CR>
  nnoremap <leader>F <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
  nnoremap <leader>: <Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>
  nnoremap <leader>r <Cmd>call VSCodeNotify('editor.action.rename')<CR>
  nnoremap <leader>d <Cmd>call VSCodeNotify('git.openChange')<CR>
  nnoremap <C-h> <Cmd>call VSCodeNotify('editor.action.startFindReplaceAction')<CR>
  nnoremap <leader>R <Cmd>call VSCodeNotify('workbench.action.reloadWindow')<CR>
  nnoremap <leader><leader>f <Cmd>call VSCodeNotify('workbench.action.files.newUntitledFile')<CR>
  nnoremap <leader>sks <Cmd>call VSCodeNotify('workbench.action.openGlobalKeybindings')<CR>
  nnoremap <leader>skk <Cmd>call VSCodeNotify('workbench.action.openGlobalKeybindingsFile')<CR>
  nnoremap <leader>l <Cmd>call VSCodeNotify('workbench.action.editor.changeLanguageMode')<CR>
  nnoremap <leader>, <Cmd>call VSCodeNotify('workbench.action.openSettingsJson')<CR>
  nnoremap <C-t>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
  nnoremap <C-t>a <Cmd>call VSCodeNotify('workbench.action.toggleActivityBarVisibility')<CR>
  nnoremap <leader>, <Cmd>call VSCodeNotify('')<CR>
  nnoremap <leader>se <Cmd>call VSCodeNotify('revealFileInOS')<CR>
  nnoremap <leader>sc <Cmd>call VSCodeNotify('')<CR>
  nnoremap <leader>sr <Cmd>call VSCodeNotify('fileutils.renameFile')<CR>
  nnoremap <leader>sv <Cmd>call VSCodeNotify('markdown-preview-enhanced.openPreviewToTheSide')<CR>
  nnoremap <leader>sg <Cmd>call VSCodeNotify('openInGitHub.openFile')<CR>
  "openInGitHub.openFile
end

