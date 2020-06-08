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
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif

" ##############################
" # for plugin
" ##############################

" === plugin ===
map _ <Plug>(operator-replace)
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" === plugin easymotion ===
nmap <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
map <Leader>s <Plug>(easymotion-s2)

" === plugin sneak ===
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map s <Plug>Sneak_s
map S <Plug>Sneak_S

" === plugin nerdcommenter ===
nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle

" === plugin fzf.vim ===
nnoremap <silent> <C-g> :<C-u>Lines<CR>
nnoremap <silent> <C-f>l :<C-u>Lines<CR>
nnoremap <silent> <C-f>b :<C-u>Buffers<CR>
nnoremap <silent> <C-f>g :<C-u>GFiles<CR>
nnoremap <silent> <C-f>f :<C-u>Files<CR>

" :Filesによる表示の変更
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Todo', 'border': 'sharp' } }
let g:fzf_files_options =
      \ '--tiebreak=end,index --preview "(bat {-1} || rougify {-1} || ccat {-1} || cat {-1}) 2> /dev/null"'
let g:fzf_buffers_jump = 1

let g:indent_guides_enable_on_vim_startup = 1
highlight Normal ctermbg=NONE

" === plugin quickrun ===
let g:quickrun_config={'*': {'split': ''}}

nnoremap <Leader>d :Gdiffsplit<CR>
set updatetime=200
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn ctermbg=brown
nmap gp <Plug>GitGutterPrevHunk
nmap gn <Plug>GitGutterNextHunk

" === plugin incsearch ===
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" === plugin incsearch-fuzzy.vim ===
map z/ <Plug>(incsearch-fuzzyspell-/)
map z? <Plug>(incsearch-fuzzyspell-?)
map zg/ <Plug>(incsearch-fuzzyspell-stay)

" === plugin haya14busa/incsearch-migemo.vim ===
map m/ <Plug>(incsearch-migemo-/)
map m? <Plug>(incsearch-migemo-?)
map mg/ <Plug>(incsearch-migemo-stay)

" === plugin plasticboy/vim-markdown ===
let g:vim_markdown_folding_disabled = 1

scriptencoding utf-8
set ambiwidth=double
set autoread
set backspace=indent,eol,start
set breakindent
set clipboard+=unnamed
set cursorline
set cmdwinheight=20
set display=lastline
set encoding=utf-8
set expandtab
set fenc=utf-8
set fileformat=unix
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
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
set whichwrap=b,s,[,],<,>
set wildmenu
set wildmode=list:full

" for vim nvim compatible
if has('nvim')
  set inccommand=split
else
  set ttymouse=xterm2
endif

 
if has('win32') || has ('win64')
  colorscheme iceberg
else
  " colorscheme pablo
  " colorscheme iceberg
  " colorscheme cobalt2
  colorscheme Tomorrow-Night-Blue
endif

" アンダーラインを引く(color terminal)
 highlight CursorLine cterm=underline ctermfg=white ctermbg=black
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd InsertLeave * set nopaste
hi NonText    ctermbg=None ctermfg=59 guibg=NONE guifg=None
hi SpecialKey ctermbg=None ctermfg=59 guibg=NONE guifg=None

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

" normal mapping
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

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
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
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

" omap
onoremap , i<
onoremap 2 i"
onoremap 7 i'
onoremap 8 i(
onoremap @ i`
onoremap [ i[
onoremap { i{

" nmap
nnoremap * *N
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
nnoremap <Leader><CR> V:!sh<CR>
nnoremap <Leader>R :source ~/.vimrc<CR>
nnoremap <Leader>a ggVG
nnoremap <Leader>q :<C-u>q!<CR>
nnoremap <Leader>vim :e ~/.vimrc<CR>
nnoremap <Leader>y :<C-u>%y<CR>
nnoremap <f5> :!ctags -R<CR>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
nnoremap <silent> <C-p> :<C-u>Buffers<CR>
nnoremap <silent> <Leader>p :<C-u>GFiles<CR>
nnoremap <silent> <Leader>te :<C-u>term<cr>
nnoremap <silent> <S-tab> :<C-u>bprevious<CR>
nnoremap <silent> <tab> :<C-u>bnext<CR>
nnoremap <silent> [B :<C-u>bfirst<CR>
nnoremap <silent> [b :<C-u>bprevious<CR>
nnoremap <silent> ]B :<C-u>blast<CR>
nnoremap <silent> ]b :<C-u>bnext<CR>
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
nnoremap zs :<C-u>sp<CR><C-w>w
nnoremap zv :<C-u>vs<CR><C-w>w

call submode#enter_with('bufmove', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('bufmove', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '5<C-w>>')
call submode#map('bufmove', 'n', '', '<', '5<C-w><')
call submode#map('bufmove', 'n', '', '+', '5<C-w>+')
call submode#map('bufmove', 'n', '', '-', '5<C-w>-')

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

if system('uname -a | grep -E "(M|m)icrosoft"') != ''
  augroup myYank
    autocmd!
    autocmd TextYankPost * :call system('win32yank.exe -i', @")
  augroup END
endif

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

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Show signature help on placeholder jump
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
