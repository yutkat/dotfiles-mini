""""""""""""""""""
"""   .vimrc   """
""""""""""""""""""
if !empty(&viminfo)
    set viminfo='50,<1000,s100,\"50,! " YankRing用に!を追加
endif
set shellslash              " Windowsでディレクトリパスの区切り文字に / を使えるようにする
set lazyredraw              " マクロなどを実行中は描画を中断
set complete+=k             " 補完に辞書ファイル追加
set history=500
if has('unix')
    let $LANG = "C"
else
    let $LANG = "en"
endif
execute "language " $LANG
execute "set langmenu=".$LANG
let mapleader = "\<Space>"
let maplocalleader = "\\"
set timeout timeoutlen=1000 ttimeoutlen=10

" タブ周り
" tabstopはTab文字を画面上で何文字分に展開するか
" shiftwidthはcindentやautoindent時に挿入されるインデントの幅
" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=4 shiftwidth=4 softtabstop=0
set expandtab              " タブを空白文字に展開
"set noautoindent nosmartindent " 自動インデント，スマートインデント

" 入力補助
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set formatoptions+=m           " 整形オプション，マルチバイト系を追加

" コマンド補完
set wildmenu           " コマンド補完を強化
set wildmode=longest,list,full " リスト表示，最長マッチ

" 検索関連
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 大文字ではじめたら大文字小文字無視しない
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト

" ファイル関連
set nobackup   " バックアップ取らない
set autoread   " 他で書き換えられたら自動で読み直す
set noswapfile " スワップファイル作らない
set hidden     " 編集中でも他のファイルを開けるようにする

" ビープ音除去
set vb t_vb=

" tags
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

"表示関連
set showmatch         " 括弧の対応をハイライト
set showcmd           " 入力中のコマンドを表示
"set number            " 行番号表示
set wrap              " 画面幅で折り返す
"set list              " 不可視文字表示
"set listchars=tab:>  " 不可視文字の表示方法
set notitle           " タイトル書き換えない
set scrolloff=5       " 行送り

" ステータスライン関連
set laststatus=2
set statusline=%-(%f%m%h%r%w%)%=%{&ff}\|%{&fenc}\ %y%l,%c\ %0P

" ウィンドウ関連
set splitbelow
set splitright

" 補完
set completeopt=longest,menuone,preview


" ==================== カラー ==================== "
colorscheme default          " カラースキーム
syntax on " シンタックスカラーリングオン
filetype indent on " ファイルタイプによるインデントを行う
filetype plugin on " ファイルタイプごとのプラグインを使う
" ポップアップメニューの色変える
"highlight Pmenu ctermbg=lightcyan ctermfg=black
"highlight PmenuSel ctermbg=blue ctermfg=black
"highlight PmenuSbar ctermbg=darkgray
"highlight PmenuThumb ctermbg=lightgray
highlight Comment ctermfg=blue

" 行番号のハイライト
set cursorline
highlight clear CursorLine

autocmd WinEnter    * set cursorline
autocmd WinLeave    * set nocursorline
autocmd InsertEnter * set nocursorline
autocmd InsertLeave * set cursorline

" ==================== カーソル ==================== "
let &t_SI .= "\<Esc>[5 q"
let &t_EI .= "\<Esc>[1 q"
if (v:version == 704 && has('patch687')) || v:version >= 705
    let &t_SR .= "\<Esc>[3 q"
endif

" ==================== エンコーディング関連 ==================== "
set encoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932,sjis
set fileformats=unix,dos,mac


" ==================== キーマップ ==================== "
" 表示行単位で移動
noremap j gj
noremap k gk
vnoremap j gj
vnoremap k gk

" undo behavior
inoremap <BS> <C-g>u<BS>
inoremap <CR> <C-g>u<CR>
inoremap <DEL> <C-g>u<DEL>
inoremap <C-w> <C-g>u<C-w>

" Emacs style
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" function key
imap <F1>  <Esc><F1>
imap <F2>  <Esc><F2>
imap <F3>  <Esc><F3>
imap <F4>  <Esc><F4>
imap <F5>  <Esc><F5>
imap <F6>  <Esc><F6>
imap <F7>  <Esc><F7>
imap <F8>  <Esc><F8>
imap <F9>  <Esc><F9>
imap <F10> <Esc><F10>
imap <F11> <Esc><F11>
imap <F12> <Esc><F12>
cmap <F1>  <Esc><F1>
cmap <F2>  <Esc><F2>
cmap <F3>  <Esc><F3>
cmap <F4>  <Esc><F4>
cmap <F5>  <Esc><F5>
cmap <F6>  <Esc><F6>
cmap <F7>  <Esc><F7>
cmap <F8>  <Esc><F8>
cmap <F9>  <Esc><F9>
cmap <F10> <Esc><F10>
cmap <F11> <Esc><F11>
cmap <F12> <Esc><F12>

" ハイライト消す
nmap <silent> gh :nohlsearch<CR>

"noremap ^? <Del>

" コピー
nnoremap Y y$

" インクリメント設定
noremap + <C-a>
noremap - <C-x>

vmap ,y "+y
vmap ,d "+d
nmap ,p "+p
nmap ,P "+P
vmap ,p "+p
vmap ,P "+P


" xはレジスタに登録しない
nnoremap x "_x

if &term == "screen"
    map <esc>[1;5D <C-Left>
    map <esc>[1;5C <C-Right>
endif

" Enable metakey
"execute "set <M-p>=\ep"
"execute "set <M-n>=\en"

" move buffer
nnoremap <F2> :bprev<CR>
nnoremap <F3> :bnext<CR>

" move tab
nnoremap <S-F2> gT
nnoremap <S-F3> gt

nnoremap <F4> :bdelete<CR>
nnoremap <F5> <C-l>

" move changes
nnoremap <F10> g;
nnoremap <F11> g,

" change paragraph
nnoremap ( {
nnoremap ) }

" For search
nnoremap v/ /\v
vnoremap * y/<C-R>"<CR>
vnoremap z/ <ESC>/\%V
vnoremap z? <ESC>?\%V

" For replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Undoable<C-w> <C-u>
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>

" Change current directory
nnoremap ,cd :lcd %:p:h<CR>:pwd<CR>

" Delete buffer
nnoremap ,bd :bdelete<CR>

" Delete all marks
nnoremap ,md :delmarks!<CR>

" Change encoding
nnoremap ,u :e ++enc=utf-8<CR>
nnoremap ,s :e ++enc=cp932<CR>
nnoremap ,e :e ++enc=euc-jp<CR>
nnoremap ,j :e ++enc=iso-2022-jp<CR>

" tags jump
nnoremap <C-]> g<C-]>

" search continue
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

" edit macro
nnoremap ,me  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" visual shift
xnoremap <  <gv
xnoremap >  >gv

" completion
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
.
" split gf
nnoremap <C-w>F :vertical wincmd f<CR>

" ==================== command ==================== "
" change indent
command! -nargs=1 IndentChange set tabstop=<args> shiftwidth=<args>


" ==================== autocmd ==================== "
if has('autocmd')
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    autocmd!
    " 前回終了したカーソル行に移動
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
    " ======== Undo ======== "
    " アンドゥ
    if has('persistent_undo')
      set undodir=./.vimundo,~/.vim/vimundo
      autocmd BufRead ~/* setlocal undofile
    endif
  augroup END
  autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
  autocmd QuickfixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd lwin
endif

" ======== 貼り付け設定 ======== "
if &term =~ "xterm" || &term =~ "screen"
    let &t_SI .= "\<Esc>[?2004h"
    let &t_EI .= "\<Esc>[?2004l"

    function! XTermPasteBegin(ret)
        set pastetoggle=<f29>
        set paste
        return a:ret
    endfunction

    execute "set <f28>=\<Esc>[200~"
    execute "set <f29>=\<Esc>[201~"
    "map <expr> <f28> XTermPasteBegin("i")
    imap <expr> <f28> XTermPasteBegin("<C-g>u")
    "vmap <expr> <f28> XTermPasteBegin("c")
    cmap <f28> <nop>
    cmap <f29> <nop>
endif

" ======== Mouse Setting ======== "
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=""
  " For screen.
  if &term =~ "^screen"
    augroup MyAutoCmd
      autocmd!
      autocmd VimLeave * :set mouse=
    augroup END

    " screenでマウスを使用するとフリーズするのでその対策
    set ttymouse=xterm2
  endif

  if has('gui_running')
    set mouse=a
    " Show popup menu if right click.
    set mousemodel=popup
    " Don't focus the window when the mouse pointer is moved.
    set nomousefocus
    " Hide mouse pointer on insert mode.
    set mousehide
  endif
endif

" ==================== コード整形 ==================== "
"末尾の空白をハイライトする
"augroup HighlightTrailingSpaces
"  autocmd!
"  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
"  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
"augroup END

if v:version >= 703
    noremap <Plug>(ToggleColorColumn)
            \ :<c-u>let &colorcolumn = len(&colorcolumn) > 0 ? '' :
            \   join(range(81, 9999), ',')<CR>
    nmap cc <Plug>(ToggleColorColumn)
else
    function! ToggleOldColorColumn(m)
        if a:m != 0
            let l:m = matchdelete(a:m)
        else
            let l:m = matchadd('turn', '^.\{80\}\zs.\+\ze')
        endif
        return l:m
    endfunction
    highlight turn gui=standout cterm=standout
    let m = 0
    nmap cc :let m = ToggleOldColorColumn(m)<CR>
endif

" ==================== コピー共有 ==================== "
"クリップボード共有
if has('clipboard')
    if v:version >= 703
        set clipboard=unnamedplus,unnamed
    else
        set clipboard+=unnamed
    endif
endif

" ======== undo ======== "
if has('persistent_undo')
  set undodir=~/.vim/undo
  augroup vimrc-undofile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif

" ======== matchit.vim ======== "
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif


" ==================== Local Configuration ==================== "
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif


