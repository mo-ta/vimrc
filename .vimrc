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
" dein settings 
"========================================
"----------------------------------------
" 無ければ自動インストール
"----------------------------------------
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.vim') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

"----------------------------------------
" プラグイン読み込み＆キャッシュ作成
"----------------------------------------
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/.dein.toml'
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


"========================================
" その他 settings 
"========================================

"----------------------------------------
"オプション等
"----------------------------------------
set number        "行番号表示
syntax on         "カラーシンタックス
set hlsearch      "検索ヒット部分に色付け

"----------------------------------------
"key bind
"----------------------------------------
"----incert mode---------
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

"----------------------------------------
" 引数なしでvimを開くとNERDTreeを起動
"----------------------------------------
let file_name = expand('%')
if has('vim_starting') &&  file_name == ''
  autocmd VimEnter * NERDTree ./
endif

"----------------------------------------
"incert modeを抜けるときにIMEをoff
"----------------------------------------
"動くけど反応遅いのでfcitxで設定に変更
" ~/.config/fcitx/config を直接編集(GUIではESCを入力不可)
"augroup MyAutoCmd
"  "InsertModeから抜けるときにIME-OFF
"  autocmd InsertLeave * call system('fcitx-remote -c')
"augroup END
