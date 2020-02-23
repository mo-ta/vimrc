" ＃todo
" - migemo 導入-完了
" - win-modeの調整 完了
" - vimrcのフォルダ管理 - 完了
" - python_host_prog を端末が変わっても自動で見る 完了
" - gitとの連携導入 完了
"    - gitguitterはアンインストール
"    - bitbuketでのGbrauseに対応したい
" - denite 導入 - 動くとこまでは完了
"    - autochdir 有効にするとdeniteが動かないので無効にした
"    - インサートモードでスタートしてjjで抜けたい
"    - フローティングはBGの色と位置がちゃんと指定できないのでそれまでは下側にする
"    - menu使って簡単なトルグとかを切り替えたい(文字コードとか)
" - 高速検索エンジン導入
" - QuickRun
"   - 強制終了の方法
"   - rubyの切り替え, yamyの実行とか
"   - 入力待ちで止めてるプログラムを実行する方法
" - mark場所の表示
" - yankaroundの挙動がおかしいのを直す
"
" let g:debug_init = 1
"
" function! s:debug_measure_time()
"   if g:debug_init
"     if !exists('g:debug_time')
"       let g:debug_time = {}
"       let g:debug_count = 0
"     endif
"     let g:debug_count += 1
"     let g:debug_time[g:debug_count] = strftime("%S%3N")
"   endif
" endfunction
"
" call s:debug_measure_time()
"----------------------------------------
" initial settings
"----------------------------------------
set nocompatible   " vi 互換じゃない

"----------------------------------------
" ディレクトリ設定＆自動作成
"----------------------------------------
"-- ディレクトリ指定
let s:dirs = {}
let s:dirs["init"] =  'c:/bin/nvim'
let s:dirs["cache"] = $XDG_CACHE_HOME
  let s:dirs["dein"] = s:dirs["cache"] . '/dein'
    let s:dirs["repo"] = s:dirs["dein"] . '/repos/github.com/Shougo/dein.vim'

  let s:dirs["tmp"] = $HOME . '/vim/tmp'
    " let s:dirs["swap"]    = s:dirs["tmp"] . '/swap'
    let s:dirs["backup"]  = s:dirs["tmp"] . '/backup'
    let s:dirs["undo"]    = s:dirs["tmp"] . '/undo'

  let s:dirs["local"] = $HOME . '/vim/local'
    let s:dirs["howm"]     =  s:dirs["local"] . '/howm'
    let s:dirs["junk"]     =  s:dirs["local"] . '/junk'
    " let s:dirs["bookmark"] =  s:dirs["local"] . '/bookmark'

"-- ディレクトリ確認と自動生成 --
for key in keys(s:dirs)
  if key != "repo" && !isdirectory(s:dirs[key])
    call mkdir(iconv(s:dirs[key], &encoding, &termencoding), 'p')
  endif
endfor
" call s:debug_measure_time()
"----------------------------------------
" dein settings
"----------------------------------------
"-- 自動インストール --
if !isdirectory(s:dirs["repo"])
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dirs["repo"]))
endif

let &runtimepath = s:dirs["repo"] .",". &runtimepath
"-- プラグイン読み込み＆キャッシュ作成 --
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/.dein.toml'
if dein#load_state(s:dirs["dein"])
  call dein#begin(s:dirs["dein"], [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

" call s:debug_measure_time()

"-- 不足プラグインの自動インストール --
let g:vimproc#download_windows_dll = 1  "コンパイル済みdllの自動ダウンロード
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" call s:debug_measure_time()
"-- ディレクトリの指定 --
set noswapfile
" let &directory = s:dirs["swap"]

set backup
let &backupdir = s:dirs["backup"]

if has('persistent_undo')
    let &undodir = s:dirs["undo"]
    set undofile
else
  echo "can not set undofile."
endif

"----------------------------------------
" オプション等
"----------------------------------------
set title                     " 編集中のファイルをタイトルに表示
set number                    " 行番号表示
set hidden                    " 編集中でもバッファを開く
set columns=999               " ウインドウの幅さ
set lines=999                 " ウインドウ高さ
set history=1000
set scrolloff=2               " 上下のスクロールしない高さ
" set autochdir                 " 常にカレントバッファをルートに
set shellslash                " pathのbackslash対応(Dos用)
set shortmess+=I              " ウガンダ非表示
set display=lastline          " 長い行もちゃんと表示
set virtualedit+=block        " ビジュアルモードの矩形選択時に仮想編集できるようにする
set virtualedit+=all          " いくつかのモードで仮想編集できるようにする
" set completeopt+=noinsert
set backspace=2               " <BS>キーで全部(字下げや改行)消去できる。
set noerrorbells              " Beep音なし
set expandtab                 " タブ入力でSpaceに置き換わる
set shiftwidth=2              " 自動シフトでのシフト量
set tabstop=2                 " タブのシフト量
set autoindent
filetype plugin indent on
set wildmenu wildmode=list:longest,full "ワイルドメニュー設定
set helplang=ja,en            " helpは日本語優先
set pumheight=10
set inccommand=split     " 置換をインタラクティブに表示
set fileencodings=utf-8,cp932,euc-jp,sjis
" Use deoplete.
let g:deoplete#enable_at_startup = 1

"---Color Syntax---
syntax on
set background=dark
colorscheme onedark
set termguicolors


"---IMEのモードで色をかえる----
" set imdisable
set iminsert=0
set imsearch=-1
" augroup InsModeAu
"     autocmd!
"     autocmd InsertEnter,CmdwinEnter * set noimdisable
"     autocmd InsertLeave,CmdwinLeave * set imdisable
" augroup END
"
"
"----AirLine------------
set laststatus=2
let g:airline_theme = 'onedark'
"----対応する括弧をハイライト
set showmatch
set matchtime=1 "マッチする括弧の表示時間 *0.1sec
"-- viminfo --
"[']: markのファイル履歴
"["]: レジスタ行数
"[:]: コマンド履歴
"[n]: 保存ファイルの指定
set viminfo='50,\"1000,:1000,n~/vim/viminfo

"----------------------------------------
" フォント設定
"----------------------------------------
set guifont=Cica:h12    " Windows用
set linespace=1         " 行間隔の設定
set ambiwidth=double    " 一部のUCS文字の幅を自動計測して決める


" Mouse
"----------------------------------------
set mouse=a       " どのモードでもマウスを使えるようにする
set nomousefocus  " マウスの移動でフォーカスを自動的に切替えない
set nomousehide   " 入力時にマウスポインタを隠さない
set guioptions+=a " ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)

"----------------------------------------
" python, ruby ,node
"----------------------------------------
set runtimepath+=$VIM
let g:python3_host_prog = substitute(system('where python'), '\n.*', '', '')

" ちゃんとバージョンみたのは遅いのでコメントアウト
" function! s:ProgPath(prog_name)
"   let ver = system(a:prog_name . ' --version')
"   if ver =~ '[ v]\(\d\{1,2\}\)\.\d\{1,2\}'
"     return {
"     \ 'main' : substitute(ver, '.*[ v]\(\d\{1,2\}\)\.\(\d\{1,2\}\).*', '\1', ''),
"     \ 'sub'  : substitute(ver, '.*[ v]\(\d\{1,2\}\)\.\(\d\{1,2\}\).*', '\2', ''),
"     \ 'path' : substitute(system('where ' . a:prog_name), '\n.*', '', ''),
"   \}
"   else
"     return {}
"   endif
" endfunction
"
" if 1
"   let tmp = s:ProgPath("python")
"   if tmp != {}
"     if tmp['main'] == 3
"       let g:python3_host_prog = tmp['path']
"       let g:loaded_python_provider = 0
"     elseif s:python_path['main'] == 2
"       let g:python_host_prog = tmp['path']
"       let g:loaded_python3_provider = 0
"     else
"       let g:loaded_python3_provider = 0
"       let g:loaded_python_provider = 0
"     endif
"   else
"     let g:loaded_python3_provider = 0
"     let g:loaded_python_provider = 0
"   endif
"
"   let tmp = s:ProgPath("ruby")
"   if tmp != {}
"     let g:ruby_host_prog = tmp['path']
"   else
"     let g:loaded_ruby_provider = 0
"   endif
"
"   let tmp = s:ProgPath("node")
"   if tmp != {}
"     let g:node_host_prog = tmp['path']
"   else
"     let g:loaded_node_provider = 0
"   endif
" endif
"
"----------------------------------------
" Mapping無効化 Leader割当
"----------------------------------------
" * s : <Leader>として使う
" * m : m[qwrtyuiop] 以外は別機能にMappingするため一旦初期化
" * , : Howm Prefixとして使う
"-- <Nop>に初期化 --
nnoremap s <Nop>
nnoremap m <Nop>
nnoremap , <Nop>

"-- <Leader> <LocalLeader>設定 --
let mapleader="s"
let maplocalleader = "\<Space>"

"----------------------------------------
" Sub Mode
"----------------------------------------
let g:submode_timeoutlen = 10000            "submodeがautooffになる時間 基本OFFしない
let g:submode_keep_leaving_key = 1          "他のキーが押された場合、コマンドとして実行する

"----------------------------------------
" Unite Denite
"----------------------------------------
"-- Unite Setting --
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_mru_limit = 200
let g:unite_source_file_mru_filename_format = ':~:.' "最近開いたファイル 
let g:unite_source_session_enable_auto_save = 1
" let g:unite_source_bookmark_directory = s:dirs["bookmark"]
" call s:debug_measure_time()
"-- Mapping In Unite --
augroup UniteKeyMap
    autocmd!
    autocmd FileType unite call s:unite_my_settings()
augroup END

function! s:unite_my_settings()
    nmap <buffer> <ESC> <Plug>(unite_exit)
    imap <buffer> jj <Plug>(unite_insert_leave)
    " 入力モードのときctrl+wでバックスラッシュも削除
    imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
    nnoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
    inoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
    nnoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
    inoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
    nnoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
    inoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
endfunction

"-- KeyMapping --
nnoremap <silent> <leader>h :<C-u>Denite file_mru<CR>
nnoremap <silent> <leader>H :<C-u>Denite command_history<CR>
nnoremap <silent> <leader>b :<C-u>Denite buffer<CR>
nnoremap <silent> <leader>y :<C-u>Denite neoyank<CR>
nnoremap <silent> <leader>o :<C-u>Unite -vertical -winwidth=30 outline<CR>
nnoremap <silent> <leader>O :<C-u>Unite -vertical -winwidth=30 -no-quit outline<CR>
nnoremap <silent> <leader>m :<C-u>Denite mark<CR>
nnoremap <silent> <leader>M :<C-u>Unite mapping<CR>
nnoremap <silent> <leader>s :<C-u>Unite session<CR>
nnoremap <silent> <leader>r :<C-u>Denite register<CR>
nnoremap <silent> <leader>f :<C-u>VimFiler -split -simple -winwidth=35 -no-quit<CR>
nnoremap <silent> <leader>c :<C-u>Denite command<CR>
nnoremap <silent> <leader>C :<C-u>Denite change<CR>
nnoremap <silent> <leader>l :<C-u>Denite line<CR>
inoremap <silent> <C-s> <Esc>:Denite neoyank<CR>

"--------------------------------------------------
" 一文字消去
"--------------------------------------------------
" * UNDO履歴をまとめて一回でできるように
" * yankさせない
" * <c-h>はNomalModeでも<X>と同じく文字消去

function! s:unify_x()
    undojoin
    normal! "_x
endfunction

function! s:unify_X()
    undojoin
    normal! "_X
endfunction

nnoremap <silent> <Plug>(unify-x) :<C-u>call <SID>unify_x()<CR>
nnoremap <silent> <Plug>(unify-X) :<C-u>call <SID>unify_X()<CR>

call submode#enter_with('unify-xX', 'n', 's', 'x'     ,'"_x')
call submode#enter_with('unify-xX', 'n', 's', 'X'     ,'"_X')
call submode#enter_with('unify-xX', 'n', 's', '<C-H>' ,'"_X')
call submode#map('unify-xX', 'n', 'rs', 'x'     ,'<Plug>(unify-x)')
call submode#map('unify-xX', 'n', 'rs', 'X'     ,'<Plug>(unify-X)')
call submode#map('unify-xX', 'n', 'rs', '<C-H>' ,'<Plug>(unify-X)')
" call s:debug_measure_time()
"--------------------------------------------------
" コマンドライン拡張
"--------------------------------------------------
"  ':'       --> 通常
"  '<SPACE>:' --> OutputRegister(出力をレジスタ保存)

"-- OutputRegister --
command! -nargs=* -complete=command
\   OutputRegister
\   redir @*
\|  execute <q-args>
\|  redir END
noremap <LocalLeader>: :<C-u>OutputRegister :

"--------------------------------------------------
" 前回終了位置に移動
"--------------------------------------------------
"-- StartBufPrePos --
augroup StartBufPrePos
    autocmd!
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$') | exe 'normal g`"' | endif
augroup END

"----------------------------------------
" MarkDown
"----------------------------------------
let g:vim_markdown_folding_disabled=1
"
augroup MarkdownKeyMap
    autocmd!
    autocmd BufRead,BufNewFile *.md  set filetype=markdown
augroup END
"
" function! s:ExecShiba()
"     let s:shiba_arg = 'c:/bin/shiba/shiba.exe --detach ' . expand('%') 
"     execute '!start' s:shiba_arg
" endfunction
"
" "-- shibaで開く --
" nnoremap <silent> ma :<C-u>call <SID>ExecShiba()<CR><CR>
"
"-- htmlで開く(previm) --
let g:previm_enable_realtime = 1
nnoremap <silent> mp :PrevimOpen<CR>
"
" call s:debug_measure_time()
"----------------------------------------
" JunkFile
"----------------------------------------
command! -nargs=0 JunkFile call s:open_junk_file()
function! s:open_junk_file()
    let l:junk_dir = s:dirs["junk"] . strftime('/%Y/%m')
    if !isdirectory(l:junk_dir)
        call mkdir(l:junk_dir, 'p')
    endif
    let l:filename = input('Junk Code: ', l:junk_dir.strftime('/%Y-%m-%d-%H%M%S.'))
    if l:filename != ''
        execute 'edit ' . l:filename
    endif
endfunction

"-- <Leader>j にmap --
nnoremap <silent> <leader>j :<C-u>JunkFile<CR>


"----------------------------------------
" Scratch
"----------------------------------------
" kaoriyaのplugin(cmdex.vim)からコピー
" Open a scratch (no file) buffer.

command! -nargs=0 Scratch new | setlocal bt=nofile noswf | let b:cmdex_scratch = 1
function! s:CheckScratchWritten()
  if &buftype ==# 'nofile' && expand('%').'x' !=# 'x' && exists('b:cmdex_scratch') && b:cmdex_scratch == 1
    setlocal buftype= swapfile
    unlet b:cmdex_scratch
  endif
endfunction

augroup CmdexScratch
  autocmd!
  autocmd BufWritePost * call <SID>CheckScratchWritten()
augroup END

"-- <Leader>J にmap --
nnoremap <silent> <leader>J :<C-u>Scratch<CR>

" call s:debug_measure_time()
"----------------------------------------
" yank paste設定
"----------------------------------------
"* クリップボードと連携する
"* submodeでyankroundする
"* pで前候補
"* Pで後候補
"-- ClipBoard連携 --

set clipboard^=unnamed
set clipboard^=unnamedplus

"-- YankRound --
call submode#enter_with('yankround', 'n', 'rs', 'p'  ,'<Plug>(yankround-p)' )
call submode#enter_with('yankround', 'n', 'rs', 'P'  ,'<Plug>(yankround-P)' )
call submode#enter_with('yankround', 'n', 'rs', 'gp' ,'<Plug>(yankround-gp)')
call submode#enter_with('yankround', 'n', 'rs', 'gP' ,'<Plug>(yankround-gP)')
call submode#map('yankround', 'n', 'r', 'p', '<Plug>(yankround-prev)')
call submode#map('yankround', 'n', 'r', 'P', '<Plug>(yankround-next)')
let g:highlightedyank_highlight_duration = 500
"----------------------------------------
" howm
"----------------------------------------
" キーマップリーダー
" let QFixHowm_Key  = ','
" let QFixHowm_KeyB = ''
"
" let howm_dir            = s:dirs["howm"]
" let howm_filename       = '%Y/%m/%Y-%m-%d-%H%M%S.md'
" let howm_fileencoding   = 'cp932'
" let howm_fileformat     = 'dos'
"
" let QFixWin_EnableMode  = 1          " プレビューや絞り込みをQuickFix/ロケーションリストの両方で有効化(デフォルト:2)
" let QFixHowm_FileType   = 'markdown' " QFixHowmのファイルタイプ
" let QFixHowm_Title      = '#'        " タイトル記号を # に変更する(markdown使用の都合上)
" let QFixWin_EnableMode  = 1          " QuickFixウィンドウでもプレビューや絞り込みを有効化
" let QFix_UseLocationList= 1          " QFixHowm/QFixGrepの結果表示にロケーションリストを使用する
" autocmd Filetype qfix_memo setlocal textwidth=0 " textwidthの再設定
" "let QFixHowm_HolidayFile = '<休日定義ファイル Sche-Hd-0000-00-00-000000.utf8 までのパス>'
" let QFixHowm_Wiki = 1               "オートリンクでファイルを開く

"------------------------------------------------------------
" 検索関連                                                                                                                               
"------------------------------------------------------------
set nohlsearch " 最初はハイライトOFF(毎回ON-OFFする)
" set incsearch  " インクリメンタルサーチ
set ignorecase " 小文字の両方が含まれている場合は大文字小文字を区別
set smartcase  "
set backspace=indent,eol,start " 検索時にファイルの最後まで行ったら最初に戻る

nnoremap <silent><Esc> :<C-u>set nohlsearch<Return><Esc>
nnoremap * :<C-u>set hlsearch<Return>*zz
nnoremap g* :<C-u>set hlsearch<Return>*<C-o>
nnoremap n :<C-u>set hlsearch<Return>nzz
nnoremap N :<C-u>set hlsearch<Return>Nzz

"-- easymotion --
let g:EasyMotion_use_migemo = 1 " Migemo機能ON
let g:EasyMotion_do_mapping = 0 " mappingは自分で
nmap <Space><Space> <Plug>(easymotion-overwin-f2)
vmap <Space><Space> <Plug>(easymotion-bd-f2)

"-- clever-f --
let g:clever_f_timeout_ms = 1000                    " timeoutで自動OFF
let g:clever_f_not_overwrites_standard_mappings = 0 " mappingは自分で
map f <Plug>(clever-f-f)
map F <Plug>(clever-f-F)
map t <Plug>(clever-f-t)
map T <Plug>(clever-f-T)


"-- incsearch --
map ? <Plug>(incsearch-forward)
map / <Plug>(incsearch-migemo-/)
map g? <Plug>(incsearch-stay)
map g/ <Plug>(incsearch-migemo-stay)



if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
end

set guioptions+=T           " ツールバー消去
set guioptions+=m           " メニューバー非表示
"------------------------------------------------------------
" 行操作コマンド
"------------------------------------------------------------
"-- 行ごと移動(VisualModeでは複数行まとめて) --
nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]

"-- 改行挿入 --
"カーソル行の下に
imap <S-CR> <End><CR>
nnoremap <S-CR> mzo<ESC>`z

"カーソル行の上に
nnoremap <C-S-CR> mzO<ESC>`z
imap <C-S-CR> <Up><End><CR>

" call s:debug_measure_time()
"------------------------------------------------------------
" バッファ, Window, Tab操作
"------------------------------------------------------------
"-- Window移動 -- wのトルグ
call submode#enter_with('win-mode', 'n', '', '<Leader>s', '<Nop>')
call submode#leave_with('win-mode', 'n', '', '<Space>')  " win-modeの終了
call submode#map('win-mode', 'n', '', 's', '<C-w>w')     " 次のウィンドウへ移動
call submode#map('win-mode', 'n', '', 'S', '<C-w>W')     " 前のウィンドウへ移動
call submode#map('win-mode', 'n', '', 'h', '<C-w>h')     " 左のウィンドウへ移動
call submode#map('win-mode', 'n', '', 'k', '<C-w>k')     " 上のウィンドウへ移動
call submode#map('win-mode', 'n', '', 'j', '<C-w>j')     " 下のウィンドウへ移動
call submode#map('win-mode', 'n', '', 'l', '<C-w>l')     " 右のウィンドウへ移動
call submode#map('win-mode', 'n', '', 'H', '<C-w>H')     " カレントウィンドウを左に移動
call submode#map('win-mode', 'n', '', 'K', '<C-w>K')     " カレントウィンドウを上に移動
call submode#map('win-mode', 'n', '', 'J', '<C-w>J')     " カレントウィンドウを下に移動
call submode#map('win-mode', 'n', '', 'L', '<C-w>L')     " カレントウィンドウを右に移動
call submode#map('win-mode', 'n', '', '>', '<C-w>>')     " カレントウィンドウ幅を拡大
call submode#map('win-mode', 'n', '', '<', '<C-w><')     " カレントウィンドウ幅を縮小
call submode#map('win-mode', 'n', '', '+', '<C-w>+')     " カレントウィンドウ高さを拡大
call submode#map('win-mode', 'n', '', '.', '<C-w>+')     " カレントウィンドウ高さを拡大(alias)
call submode#map('win-mode', 'n', '', '-', '<C-w>-')     " カレントウィンドウ高さを縮小
call submode#map('win-mode', 'n', '', '.', '<C-w>-')     " カレントウィンドウ高さを縮小(alias)
call submode#map('win-mode', 'n', '', 'c', '<C-w>c')     " カレントウィンドウを閉じる
call submode#map('win-mode', 'n', '', 'q', '<C-w>q')     " カレントウィンドウを終了
call submode#map('win-mode', 'n', '', 'Q', ':quit!<CR>') " カレントウィンドウを強制終了
call submode#map('win-mode', 'n', '', 'p', '<C-w>p')     " 前にアクセスしたウィンドウに移動
call submode#map('win-mode', 'n', '', 'P', '<C-w>P')     " プレビューウィンドウに移動
call submode#map('win-mode', 'n', '', 'o', '<C-w>o')     " カレントウィンド以外をすべて閉じる
call submode#map('win-mode', 'n', '', 'r', '<C-w>r')     " ウィンドウ配置を下向きに回転
call submode#map('win-mode', 'n', '', 'R', '<C-w>R')     " ウィンドウ配置を上向きに回転
call submode#map('win-mode', 'n', '', '=', '<C-w>=')     " すべてのウィンドウの高さをそろえる
call submode#map('win-mode', 'n', '', '0', '<C-w>=')     " すべてのウィンドウの高さをそろえる(alias)
call submode#map('win-mode', 'n', '', 't', 'gt')         " 次のタブに移動
call submode#map('win-mode', 'n', '', 'T', '<C-w>T')     " カレントウィンドウを新しいタブに移す

"-- Window分割
nnoremap <LocalLeader>s :<C-u>sp<CR>
nnoremap <LocalLeader>v :<C-u>vs<CR>
nnoremap <LocalLeader>V :<C-u>Vinarise<CR>

"-- バッファ切り替え --
call submode#enter_with('buf-change', 'n', '', '<LocalLeader>b', ':<C-u>bn<CR>')
call submode#enter_with('buf-change', 'n', '', '<LocalLeader>B', ':<C-u>bp<CR>')
call submode#map('buf-change', 'n', '', 'b', ':<C-u>bn<CR>')
call submode#map('buf-change', 'n', '', 'B', ':<C-u>bp<CR>')

"-- 保存、終了 --
noremap <LocalLeader>w :<C-u>w<CR>
noremap <LocalLeader>W :<C-u>w!<CR>
noremap <LocalLeader>q :<C-u>q<CR>
noremap <LocalLeader>Q :<C-u>q!<CR>

"-- TAB操作 --
call submode#enter_with('tab-change', 'n', '', '<LocalLeader>t' ,'gt')
call submode#map('tab-change', 'n', '', 't', 'gt')
nnoremap <LocalLeader>T :<C-u>tabnew<CR>

" call s:debug_measure_time()
"------------------------------------------------------------
" Undo 設定
"------------------------------------------------------------
let g:undotree_SetFocusWhenToggle =  1
nnoremap <silent> <leader>u :<C-u>UndotreeToggle<CR>

"------------------------------------------------------------
" 不可視文字の可視化
"------------------------------------------------------------
"-- Tab、行末の半角スペース(SpecialKey) --
set list
set listchars=tab:^\ ,trail:~

"----------------------------------------
" endwise
"----------------------------------------
" insertmode の 改行でコマンド実行するので他とぶつからないように 指定拡張子のときのみ実行する
let g:endwise_no_mappings = 1

" -- UseEndWise --
augroup UseEndWise 
    autocmd!
    autocmd FileType lua,ruby,sh,zsh,vb,vbnet,aspvbs,vim imap <buffer> <CR> <CR><Plug>DiscretionaryEnd
augroup END

" ------------------------------------------------------------
" こじんまりしたkeybind
"------------------------------------------------------------

"-- jjでInsertModeモードを抜ける<Insert> --
"-- InsertModeモードを抜けるときは右に<Insert> --
inoremap <silent> jj <ESC><Right>
inoremap <silent> ｊｊ <ESC><Right>
inoremap <Esc> <Esc><Right>

"-- タイポ修正<Insert> --
inoremap <C-t> <Esc><Left>"zx"zpa
nnoremap <C-t> <Left>"zx"pz


"-- 行末までヤンク<Normal,Visual> --
nnoremap Y y$


"-- 一単語をヤンクされた文字列を置きかえ<Normal> --
nnoremap ciy ciw<C-r>0<ESC><Right>
nnoremap ciY ciW<C-r>0<ESC><Right>

"-- inc dec --
nnoremap - <C-x>
nnoremap + <C-a>

"-- 変更点へjump --
call submode#enter_with('jump-modify', 'n', '', '<LocalLeader>i', 'g,')
call submode#enter_with('jump-modify', 'n', '', '<LocalLeader>o', 'g;')
call submode#map('jump-modify', 'n', '', 'i', 'g,')
call submode#map('jump-modify', 'n', '', 'o', 'g;')

"----------------------------------------
" Visual Mode 関連
"----------------------------------------
"-- winっぽく Shift + 矢印で領域選択 --
nnoremap <S-Up>    v<Up>
nnoremap <S-Down>  v<Down>
nnoremap <S-Left>  v<Left>
nnoremap <S-Right> v<Right>

vnoremap <S-Up>    <Up>
vnoremap <S-Down>  <Down>
vnoremap <S-Left>  <Left>
vnoremap <S-Right> <Right>

"-- トルグでVisualModeを切り替え --
vnoremap <silent>v :<C-u>call <SID>vmode_toggle()<CR>

function! s:vmode_toggle()
    let l:vmode_now = visualmode()
    if     l:vmode_now ==# 'v'
        call feedkeys('gvV', "n")
    elseif l:vmode_now ==# 'V'
        call feedkeys("gv\<C-v>", "n")
    elseif l:vmode_now == "\<C-v>"
        call feedkeys('gvv', "n")
    else
    endif
endfunction

"-- vim-expand-region --
" - mapping -
map L <Plug>(expand_region_expand)
map H <Plug>(expand_region_shrink)
" call s:debug_measure_time()
" - 動作設定 -
" 'ib' Support nesting of parentheses
" 'iB' Support nesting of braces
" 'il' inside line. https://github.com/kana/vim-textobj-line
" 'ie' entire file. https://github.com/kana/vim-textobj-entire
let g:expand_region_text_objects = {
\ 'iw' :0,
\ 'iW' :0,
\ 'i"' :0,
\ 'i''' :0,
\ 'i]' :1,
\ 'ib' :1,
\ 'iB' :1,
\ 'il' :0,
\ 'ip' :0,
\ 'ie' :0,
\ }


"----------------------------------------
" mark設定
"----------------------------------------
" * markで使うのはキーボード上段のq-uのみ使う
" * mmで自動的にasd...lに割振り
" * mo, miでマーク履歴(トルグにする)
" * 先にmのキーバインド外しているので使う分はすべてmap

"-- key --
nnoremap <silent> mm :<C-u>call <SID>AutoMarkrement()<CR>

"-- 次/前のマーク mo mi トルグで --
call submode#enter_with('jump-markpos', 'n', '', 'mo', ']`')
call submode#enter_with('jump-markpos', 'n', '', 'mi', '[`')
call submode#map('jump-markpos', 'n', 'r', 'o', ']`')
call submode#map('jump-markpos', 'n', 'r', 'i', '[`')
call submode#map('jump-markpos', 'n', 'rs', 'm', '<CR>:Denite mark<CR>')
"-- 手動で使う分をmap --
"
nnoremap mq mq:echo 'marked q'<CR>
nnoremap mw mw:echo 'marked w'<CR>
nnoremap me me:echo 'marked e'<CR>
nnoremap mr mr:echo 'marked r'<CR>
nnoremap mt mt:echo 'marked t'<CR>
nnoremap my my:echo 'marked y'<CR>
nnoremap mu mu:echo 'marked u'<CR>

"-- asd...kl に割振り ---
let s:markrement_chars = "asdfghjkl"
let s:mark_chars = "qwertyu"
if exists('s:markrement_chars')
    let g:unite_source_mark_marks = s:mark_chars . s:markrement_chars
    let s:markrement_char_array = split( s:markrement_chars, '\zs') 
endif

"-- AutoMarkrement --
functio! s:AutoMarkrement()
    if !exists('b:markrement_pos')
        let b:markrement_pos = 0
    else
        let b:markrement_pos = (b:markrement_pos + 1) % len(s:markrement_char_array)
    endif
    execute 'mark' s:markrement_char_array[b:markrement_pos]
    echo 'marked' s:markrement_char_array[b:markrement_pos]
endfunction

" call s:debug_measure_time()
"----------------------------------------
" Quick Run
"----------------------------------------
noremap <silent>mn :QuickRun<CR>
nnoremap <expr><silent> mN quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
"-- key ---

"-- config --
"
"
let g:quickrun_config = {
    \"_" : {
                \'runner' : 'vimproc',
                \'runner/vimproc/updatetime' : 1,
                \"outputter/buffer/split" : ":botright 8sp",
                \"hook/time/enable" : 1,
          \},
\}


let g:quickrun_config['nim'] = {
      \ 'command': 'nim',
      \ 'cmdopt': 'compile --run --verbosity:0',
      \ 'hook/sweep/files': '%S:p:r',
      \ 'tempfile': '%{substitute(tempname(), ''\(\d\+\)$'', ''nim\1.nim'', '''')}'
      \}

"----------------------------------------
" コメント(caw.vim)
"----------------------------------------
" *  コメントのトルグ
"    * <LL>c   空白のぞく先頭
"    * <LL>C   行頭
" * yc コメント化したものを貼り付け
"    * yc 上に貼り付け
"    * yC 下に貼り付け
"
"-- mapping --
nmap <LocalLeader>c <Plug>(caw:hatpos:toggle)
vmap <LocalLeader>c <Plug>(caw:hatpos:toggle)
nmap <LocalLeader>C <Plug>(caw:zeropos:toggle)
vmap <LocalLeader>C <Plug>(caw:zeropos:toggle)

"-- 行コピーしてコメント化したものをペースト --
"- 上がコメント -
nmap yc "zyy"zP<Plug>(caw:hatpos:comment)j
vmap yc "zYgv<ESC>"zpgv<Plug>(caw:hatpos:comment)gv<ESC>j

"- 下がコメント -
nmap yC "zyy"zp<Plug>(caw:hatpos:comment)k
vmap yC "zY"zPgv<Plug>(caw:hatpos:comment)k


"----------------------------------------
" %の拡張(matchit)
"----------------------------------------
if !exists('loaded_matchit')
    " matchitを有効化
    runtime macrosmatchit.vim
endif

" 対応括弧を追加
set matchpairs& matchpairs+=<:>,「:」,『:』,（:）,【:】,《:》,〈:〉,［:］,‘:’,“:”

" =============================実験中============================================
" gmilk コマンドの結果をUnite qf で表示する
" command! -nargs=1 Gmilk call s:Gmilk("gmilk -a -n 200", <f-args>)
"
" function! s:Gmilk(cmd, arg)
"     silent execute "cgetexpr system(\"" . a:cmd . " ". a:arg . "\")"
"     if len(getqflist()) == 0
"         echohl WarningMsg
"         echomsg "No match found."
"         echohl None
"     else
"     execute "Unite -auto-preview qf"
"         redraw!
"
" endfunction
"
" "-------Terminal
" tnoremap <Esc> <C-\><C-n>
"
" function! s:TerminalRight()
"     vsplit
"     terminal ++curwin
" endfunction
"
" noremap  <silent> <leader>i :<C-u>call <SID>TerminalRight()<CR>
"
" function! s:bufnew()
"    " 幸いにも 'buftype' は設定されているのでそれを基準とする
"     if &buftype == "terminal" && &filetype == ""
"         set filetype=terminal
"     endif
" endfunction
"
" function! s:filetype()
"    " ここに :terminal のバッファ固有の設定を記述する
" endfunction
"
" augroup my-terminal
"     autocmd!
"    " BufNew の時点では 'buftype' が設定されていないので timer イベントでごまかすなど…
"     autocmd BufNew * call timer_start(0, { -> s:bufnew() })
"     autocmd FileType terminal call s:filetype()
" augroup END
" call s:debug_measure_time()
"----------------------------------------
"折り畳み
"----------------------------------------
set foldmethod=marker " 折り畳みの基準
" set foldlevel=2       " ファイルを開いた時の折り畳みレベル
" set foldcolumn=2      " 折り畳みの状態を左端n列に表示

" https://hatebu.me/entry/2017/09/18/223131
" https://www.soum.co.jp/misc/vim-no-susume/1/
" http://secret-garden.hatenablog.com/entry/2015/04/16/000000


noremap gk k
noremap gj j
"-- accelerated_jkで加速, l,h にも拡張
" let g:accelerated_jk_acceleration_table = [7,12,17,21,24,26,28,30]
let g:accelerated_jk_acceleration_table = [7, 12, 17, 21, 24, 28, 31, 40]

nmap k <Plug>(accelerated_gk)
nmap j <Plug>(accelerated_gj)
nmap l <Plug>(accelerated_l)
nmap h <Plug>(accelerated_h)
"
"-- <LL>j, <LL>kで加速 (J,Kでさらに加速)
let s:move_jk_step_size = 15
let s:move_jk_step_size_large = 45

call submode#enter_with('move-j', 'nv', '', '<LocalLeader>j', s:move_jk_step_size . 'gj')
call submode#map('move-j', 'nv', '', 'j'  , s:move_jk_step_size . 'gj')
call submode#map('move-j', 'nv', '', 'J'  , s:move_jk_step_size_large . 'gj')

call submode#enter_with('move-k', 'nv', '', '<LocalLeader>k' , s:move_jk_step_size .'gk')
call submode#map('move-k', 'nv', '', 'k'  , s:move_jk_step_size . 'gk')
call submode#map('move-k', 'nv', '', 'K'  , s:move_jk_step_size_large . 'gk')

"-- <LL>l => $, <LL>k => ^ or 0 -
" noremap <LocalLeader>l $
" noremap <LocalLeader>h ^
call submode#enter_with('move-l-head', 'nv', '', '<LocalLeader>h'  ,'^')
call submode#map('move-l-head', 'nv', '', 'h'  ,'0')

call submode#enter_with('move-l-tail', 'nv', '', '<LocalLeader>l'  ,'g_l')
call submode#map('move-l-tail', 'nv', '', 'l'  ,'$')
" call s:debug_measure_time()
"----------------------------------------
" mode切替
"----------------------------------------
"
"-- file encodeing --
"
"-- modifiable
nnoremap  <LocalLeader>m :set modifiable!<CR>
"----------------------------------------
" explorer.exeの実行
"----------------------------------------
"help :!start
"win専用 <CR>は2個入れないと上手くいかない
function! s:ExplorerCurrentDir()
  " execute '!start %:h'
  execute '!explorer %:h'
endfunction
noremap <leader>e :<C-u>call <SID>ExplorerCurrentDir()<CR><CR>




" Examples:
" after:    \v     \m       \M       \V       matches ~
"               'magic' 'nomagic'
"           $      $        $        \$       matches end-of-line
"           .      .        \.       \.       matches any character
"           *      *        \*       \*       any number of the previous atom
"           ()     \(\)     \(\)     \(\)     grouping into an atom
"           |      \|       \|       \|       separating alternatives
"          \a     \a       \a       \a       alphabetic character
"          \\     \\       \\       \\       literal backslash
"          \.     \.       .        .        literal dot
"          \{     {        {        {        literal '{'
"           a      a        a        a        literal 'a'
"
"----------------------------------------
" git
"----------------------------------------
" airblade/vim-gitgutter
" tpope/vim-fugitive
" Statuslineの設定
" set laststatus=2
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ \[ENC=%{&fileencoding}]%P 


"----------------------------------------
" Aligne
"----------------------------------------
let g:Align_xstrlen=3
"// Windowsでの設定例です。Mac他の場合は外部コマンド部分を読み替えてください。
" au FileType plantuml command! OpenUml :!start chrome %


" 保存時のみ実行する
let g:ale_lint_on_text_changed = 0
" 表示に関する設定
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'w'
let g:airline#extensions#ale#open_lnum_symbol = '('
let g:airline#extensions#ale#close_lnum_symbol = ')'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
highlight link ALEErrorSign Tag
highlight link ALEWarningSign StorageClass
" Ctrl + kで次の指摘へ、Ctrl + jで前の指摘へ移動
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:indentLine_enable = 1

" call s:debug_measure_time()

"----------------------------------------
" denite settin
"----------------------------------------
" set termguicolors    " ターミナルでも True Color を使えるようにする。
" set pumblend=20      " 0 〜 100 が指定できます。ドキュメントによると 5 〜 30 くらいが適当だそうです。

" 以下はおまけ。ここでは Denite の設定を載せていますが、
" 同様の仕組みで任意のウィンドウを半透明化できるでしょう。
" augroup transparent-windows
"   autocmd!
"   autocmd FileType denite set winblend=20  " こちらも 5 〜 30 で試してみてください。
"   autocmd FileType denite-filter set winblend=20
" augroup END

augroup denite_filter
  autocmd!
  autocmd FileType denite call s:denite_my_settings()
  function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
    \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> s
    \ denite#do_map('do_action', 'split')
    nnoremap <silent><buffer><expr> t
    \ denite#do_map('do_action', 'tabopen')
    nnoremap <silent><buffer><expr> v
    \ denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr> p
    \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
    \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
    \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> m 
    \ denite#do_map('toggle_select').'j'
  endfunction
augroup END


 " コマンド．file_rec で使うコマンド
" call denite#custom#var('file_rec', 'command',
    "\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
" Endif
let s:denite_default_options = {
\ 'split': 'floating'
\ }
	let s:menus = {}

	let s:menus.zsh = {
		\ 'description': 'Edit your import zsh configuration'
		\ }
	let s:menus.zsh.file_candidates = [
		\ ['zshrc', '~/.config/zsh/.zshrc'],
		\ ['zshenv', '~/.zshenv'],
		\ ]

	let s:menus.my_commands = {
		\ 'description': 'Example commands'
		\ }
	let s:menus.my_commands.command_candidates = [
		\ ['Split the window', 'vnew'],
		\ ['Open zsh menu', 'Denite menu:zsh'],
		\ ['Format code', 'FormatCode', 'go,python'],
		\ ]
  call denite#custom#var('menr', 'menus', s:menus)
" let s:menus = {}
" let s:menus.vim = {
"    \ 'description': 'Vim',
"    \ }
"
" let s:menus.denite = {
"    \ 'description': 'Denite',
"    \ }
"
" let s:menus.vim.file_candidates = [
"    \ ['  > Edit configuation file (init.vim)', '/bin/nvim/init.vim']
"    \ ]
" call denite#custom#var('menu', 'menus', s:menus)
" call s:debug_measure_time()
" call denite#custom#map('insert', "jj", <denite:enter_mode:normal>)
"-- Denite Setting --
" let g:denite_enable_start_insert = 1
" use floating
" let s:denite_win_width_percent = 0.80
" let s:denite_win_height_percent = 0.5
" let s:denite_default_options = {
"    \ 'split': 'floating',
"    \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
"    \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
"    \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
"    \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
"    \ 'highlight_filter_background': 'DeniteFilter',
"    \ 'prompt': '$ ',
"    \ 'start_filter': v:true,
"    \ }
"
"
if executable('rg')
  call denite#custom#var('file_rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg'])
endif






inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"



nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
