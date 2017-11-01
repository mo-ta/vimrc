"========================================
" initial settings
"========================================
if &compatible
  set nocompatible "vi 互換じゃない
endif
"----autocmdのreset---------
"多重起動防止 autocmd使うときは
"augroupをMyAutoCmdにすればここで消してくれる
augroup MyAutoCmd
  autocmd!
augroup END


"========================================
"" {{{ dein settings :
"========================================
"----------------------------------------
" 初期設定
"----------------------------------------
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.vim') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

echo s:dein_repo_dir

set swapfile
set directory=C:/Users/appli/.vim/tmp/swap
set backup
set backupdir=C:/Users/appli/.vim/tmp/backup



"----インストールされて無ければ、自動でインストール
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

"----------------------------------------
" プラグイン読み込み＆キャッシュ作成
"----------------------------------------
"let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/.dein.toml'
let s:toml_file = '~/.dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

"----------------------------------------
" 不足プラグインの自動インストール
"----------------------------------------
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
""}}}


"========================================
" その他 settings
"========================================

"----------------------------------------
"オプション等
"----------------------------------------
set title         "編集中のファイルをタイトルに表示"
set number        "行番号表示
syntax on         "カラーシンタックス
set foldmethod=marker
set scrolloff=7

"----Color Syntax--------
colorscheme happy_hacking
"colorscheme japanesque


"----AirLine------------
set laststatus=2
let g:airline_theme='one'

"----対応する括弧をハイライト
hi MatchParen ctermbg=4　"青色
"set showmatch

"----------------------------------------
"key bind
"----------------------------------------
"----incert mode---------/*{{{*/
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
"/*}}}*/
"----reguler mode---------
nnoremap j gj  //物理行で移動
nnoremap k gk　

nnoremap n nzz //検索結果を画面中央に
nnoremap N Nzz

set hlsearch      "検索ヒット部分に色付け
nnoremap <silent> <C-L> :noh<C-L><CR> //検索結果ハイライトも停止

"----------------------------------------
" 引数なしでvimを開くとNERDTreeを起動
"----------------------------------------
let file_name = expand('%')
if has('vim_starting') &&  file_name == ''
  autocmd VimEnter * NERDTree ./
endif
"" unite.vim {{{
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Leader>f [unite]

" unite.vim keymap
" https://github.com/alwei/dotfiles/blob/3760650625663f3b08f24bc75762ec843ca7e112/.vimrc
nnoremap [unite]u  :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> ,vr :UniteResume<CR>

" vinarise
let g:vinarise_enable_auto_detect = 1

" unite-build map
nnoremap <silent> ,vb :Unite build<CR>
nnoremap <silent> ,vcb :Unite build:!<CR>
nnoremap <silent> ,vch :UniteBuildClearHighlight<CR>
"" }}}

set wildmenu wildmode=list:full
"補完リストなんかとかぶってる？

"-----migemo----------------
augroup MyAutoCmd
   autocmd InsertEnter,InsertLeave * set cursorline!
augroup END
map <Space>/ <Plug>(vigemo-search)

"----------------------------------------
"incert modeを抜けるときにIMEをoff
"----------------------------------------
"動くけどフックのタイミングが遅いのでfcitxで設定に変更
" ~/.config/fcitx/config を直接編集(GUIではESCを入力不可)
"augroup MyAutoCmd
"  "InsertModeから抜けるときにIME-OFF
"  autocmd InsertLeave * call system('fcitx-remote -c')
"augroup END

