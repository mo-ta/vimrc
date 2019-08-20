"----------------------------------------
" initial settings
"----------------------------------------
if &compatible
    set nocompatible "vi 互換じゃない
endif

"----------------------------------------
" dein settings 
"----------------------------------------
"-- 初期設定 --
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('/cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home .  '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

"-- 自動インストール --
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
"-- プラグイン読み込み＆キャッシュ作成 --
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/.dein.toml'
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
    call dein#load_toml(s:toml_file)
    call dein#end()
    call dein#save_state()
endif

"-- 不足プラグインの自動インストール --
let g:vimproc#download_windows_dll = 1  "コンパイル済みdllの自動ダウンロード
if has('vim_starting') && dein#check_install()
    call dein#install()
endif

"----------------------------------------
" ディレクトリ設定＆自動作成
"----------------------------------------
"-- ディレクトリ指定
let  s:tmp_dir         = s:cache_home . '/tmp'
let  s:local_dir       = s:cache_home . '/local'
let  s:swap_dir        = s:tmp_dir    . '/swap'
let  s:backup_dir      = s:tmp_dir    . '/backup'
let  s:undo_dir        = s:tmp_dir    . '/undo'
let  s:bookmark_dir    = s:local_dir  . '/bookmark'
let  s:junkfile_dir    = s:local_dir  . '/junkfile'
let  s:migemo_dict_dir = s:local_dir  . '/dict'
let  s:howm_dir        = s:local_dir  . '/howm'

"-- ディレクトリ確認と自動生成 --
if !isdirectory(s:tmp_dir)
    call mkdir(iconv(s:tmp_dir, &encoding, &termencoding), 'p')
endif

if !isdirectory(s:local_dir)
    call mkdir(iconv(s:local_dir, &encoding, &termencoding), 'p')
endif

if !isdirectory(s:swap_dir)
    call mkdir(iconv(s:swap_dir, &encoding, &termencoding), 'p')
endif
if !isdirectory(s:backup_dir)
    call mkdir(iconv(s:backup_dir, &encoding, &termencoding), 'p')
endif

if !isdirectory(s:undo_dir)
    call mkdir(iconv(s:undo_dir, &encoding, &termencoding), 'p')
endif

if !isdirectory(s:junkfile_dir)
    call mkdir(iconv(s:junkfile_dir, &encoding, &termencoding), 'p')
endif

if !isdirectory(s:bookmark_dir)
    call mkdir(iconv(s:bookmark_dir, &encoding, &termencoding), 'p')
endif

if !isdirectory(s:howm_dir)
    call mkdir(iconv(s:howm_dir, &encoding, &termencoding), 'p')
endif

"-- ディレクトリの指定 --
set noswapfile
let &directory = s:swap_dir

set backup
let &backupdir = s:backup_dir

if has('persistent_undo')
    let &undodir = s:undo_dir
    set undofile
endif

"----------------------------------------
" オプション等
"----------------------------------------
set title                " 編集中のファイルをタイトルに表示"
set number               " 行番号表示
set hidden               " 編集中でもバッファを開く
set columns=250          " ウインドウの高さ
set lines=40             " コマンドラインの高さ(GUI使用時)
set scrolloff=2          " 上下のスクロールしない高さ
set autochdir            " 常にカレントバッファをルートに
set shellslash           " pathのbackslash対応(Dos用)
set shortmess+=I         " ウガンダ非表示
set display=lastline     " 長い行もちゃんと表示
set virtualedit+=block   " ビジュアルモードの矩形選択時に仮想編集できるようにする。
set virtualedit+=all     " いくつかのモードで仮想編集できるようにする。
set completeopt+=noinsert
set backspace=2
set noerrorbells "Beep音は鳴らさない
set expandtab
set shiftwidth=4
set tabstop=4
set autoindent
filetype plugin indent on
set wildmenu wildmode=list:longest,full "ワイルドメニュー設定
set helplang=ja,en       "helpは日本語で 
set pumheight=10

if has("kaoriya")
    set fileencodings=guess
    set modeline
else
    set fileencodings=utf-8,cp932,euc-jp,sjis
endif

" Use deoplete.
let g:deoplete#enable_at_startup = 1

"---Color Syntax---
syntax on
set background=dark
colorscheme japanesque
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
let g:airline_theme = 'molokai'
"----対応する括弧をハイライト
set showmatch
" highlight MatchParen ctermfg=Red
set matchtime=1 "マッチする括弧の表示時間 *0.1sec
"-- viminfo --
"[']: markのファイル履歴
"["]: レジスタ行数
"[:]: コマンド履歴
"[n]: 保存ファイルの指定
set viminfo='50,\"1000,:0,n/viminfo

"----------------------------------------
" フォント設定
"----------------------------------------
if has('win32')
    " set guifont=MS_Gothic:h12:cSHIFTJIS    " Windows用
    set guifont=Cica:h12    " Windows用
    set linespace=1                        " 行間隔の設定
    if has('kaoriya')
        set ambiwidth=auto                 " 一部のUCS文字の幅を自動計測して決める
    endif
endif

"----------------------------------------
" Mouse
"----------------------------------------
set mouse=a       " どのモードでもマウスを使えるようにする
set nomousefocus  " マウスの移動でフォーカスを自動的に切替えない
set nomousehide   " 入力時にマウスポインタを隠さない
set guioptions+=a " ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)

"----------------------------------------
" Python
"----------------------------------------
" 実行ファイルのフォルダにpython3を作りその中に関連ファイルを入れる設定
set runtimepath+=$VIM
" set pythonthreedll=$VIM/python3/python35.dll
let g:python3_host_prog = 'python'

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
let g:unite_source_bookmark_directory = s:bookmark_dir

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

"-- Denite Setting --
let g:denite_enable_start_insert = 1

" Mapping In Denite
call denite#custom#map('insert', 'jj', '<denite:enter_mode:normal>')
call denite#custom#option('default', 'prompt', '>')
call denite#custom#map('insert', "<Down>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<Up>", '<denite:move_to_previous_line>')
call denite#custom#map('insert', "<C-t>", '<denite:do_action:tabopen>')
call denite#custom#map('insert', "<C-v>", '<denite:do_action:vsplit>')
call denite#custom#map('insert', "<C-s>", '<denite:do_action:vsplit>')
call denite#custom#map('normal', "t", '<denite:do_action:tabopen>')
call denite#custom#map('normal', "v", '<denite:do_action:vsplit>')
call denite#custom#map('normal', "s", '<denite:do_action:split>')

"-- KeyMapping --
nnoremap <silent> <leader>h :<C-u>Unite file_mru<CR>
nnoremap <silent> <leader>b :<C-u>Unite buffer<CR>
nnoremap <silent> <leader>y :<C-u>Unite history/yank<CR>
nnoremap <silent> <leader>Y :<C-u>Unite yankround<CR>
nnoremap <silent> <leader>o :<C-u>Unite -vertical -winwidth=30 outline<CR>
nnoremap <silent> <leader>O :<C-u>Unite -vertical -winwidth=30 -no-quit outline<CR>
nnoremap <silent> <leader>w :<C-u>Unite window<CR>
nnoremap <silent> <leader>t :<C-u>Unite tab<CR>
nnoremap <silent> <leader>m :<C-u>Unite mark<CR>
nnoremap <silent> <leader>M :<C-u>Unite mapping<CR>
nnoremap <silent> <leader>s :<C-u>Unite session<CR>
nnoremap <silent> <leader>r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <leader>f :<C-u>VimFiler -split -simple -winwidth=35 -no-quit<CR>
nnoremap <silent> <leader>a :<C-u>Unit BookmarkAdd<CR>
nnoremap <silent> <leader>c :<C-u>Unit bookmark<CR>
nnoremap <F2> :VimFiler<CR>
"inoremap <silent> <C-s> <Esc>:Unite history/yank<CR>

"--------------------------------------------------
" 一文字消去
"--------------------------------------------------
" * UNDO履歴をまとめて一回でできるように
" * yankさせない
" * <c-h>はNomalModeでも<X>と同じく文字消去

function! s:my_x()
    undojoin
    normal! "_x
endfunction

function! s:my_X()
    undojoin
    normal! "_X
endfunction

nnoremap <silent> <Plug>(my-x) :<C-u>call <SID>my_x()<CR>
nnoremap <silent> <Plug>(my-X) :<C-u>call <SID>my_X()<CR>

call submode#enter_with('my-xX', 'n', 's', 'x'     ,'"_x')
call submode#enter_with('my-xX', 'n', 's', 'X'     ,'"_X')
call submode#enter_with('my-xX', 'n', 's', '<C-H>' ,'"_X')
call submode#map('my-xX', 'n', 'rs', 'x'     ,'<Plug>(my-x)')
call submode#map('my-xX', 'n', 'rs', 'X'     ,'<Plug>(my-X)')
call submode#map('my-xX', 'n', 'rs', '<C-H>' ,'<Plug>(my-X)')

"--------------------------------------------------
" コマンドライン拡張
"--------------------------------------------------
"  ':'        --> OverCommandLine
"  '::'       --> 通常
"  '<SPACE>:' --> OutputRegister(出力をレジスタ保存)

"-- OutputRegister --
command! -nargs=* -complete=command
\   OutputRegister
\   redir @*
\|  execute <q-args>
\|  redir END

noremap :: :OverCommandLine<CR>
" noremap : :
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

"----------------------------------------
" JunkFile
"----------------------------------------
command! -nargs=0 JunkFile call s:open_junk_file()
function! s:open_junk_file()
    let l:junk_dir = s:junkfile_dir . strftime('/%Y/%m')
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

"----------------------------------------
" howm
"----------------------------------------
" キーマップリーダー
" let QFixHowm_Key  = ','
" let QFixHowm_KeyB = ''
"
" let howm_dir            = s:howm_dir
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
set incsearch  " インクリメンタルサーチ
set ignorecase " 小文字の両方が含まれている場合は大文字小文字を区別
set smartcase  "
set backspace=indent,eol,start " 検索時にファイルの最後まで行ったら最初に戻る

"  * /,?,*,# が押されたらHilight ON にしてから
"   /,? はmigemo
"   n,N は画面中央に

" if has("migemo") "kaoriya専用
"     set migemo
"     "let &migemodict = s:migemo_dict_dir
"     let migemodict = s:migemo_dict_dir
"     nnoremap /  :<C-u>set hlsearch<Return>g/
"     nnoremap g/ :<C-u>set hlsearch<Return>/
"     nnoremap ?  :<C-u>set hlsearch<Return>g?
"     nnoremap g? :<C-u>set hlsearch<Return>?
" endif



nnoremap <silent><Esc> :<C-u>set nohlsearch<Return><Esc>

nnoremap * :<C-u>set hlsearch<Return>*<C-o>zz
nnoremap # :<C-u>set hlsearch<Return>#zz
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


"------------------------------------------------------------
" 行操作コマンド
"------------------------------------------------------------
"-- 行ごと移動(VisualModeでは複数行まとめて) --
nnoremap <C-Down> "zdd"zp
nnoremap <C-Up> "zdd<Up>"zP
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]

"-- 改行挿入 --
"カーソル行の下に
imap <S-CR> <End><CR>
nnoremap <S-CR> mzo<ESC>`z

"カーソル行の上に
nnoremap <C-S-CR> mzO<ESC>`z
imap <C-S-CR> <Up><End><CR>


"------------------------------------------------------------
" バッファ, Window, Tab操作
"------------------------------------------------------------
"-- Window移動 -- wのトルグ
call submode#enter_with('win-mode', 'n', '', '<C-w>', '<Nop>')
call submode#map('win-mode', 'n', '', 'w', '<C-w>w')
call submode#map('win-mode', 'n', '', 'W', '<C-w>W')
call submode#map('win-mode', 'n', '', 'h', '<C-w>h')
call submode#map('win-mode', 'n', '', 'k', '<C-w>k')
call submode#map('win-mode', 'n', '', 'j', '<C-w>j')
call submode#map('win-mode', 'n', '', 'l', '<C-w>l')
call submode#map('win-mode', 'n', '', 'H', '<C-w>H')
call submode#map('win-mode', 'n', '', 'K', '<C-w>K')
call submode#map('win-mode', 'n', '', 'J', '<C-w>J')
call submode#map('win-mode', 'n', '', 'L', '<C-w>L')
call submode#map('win-mode', 'n', '', '>', '<C-w>>')
call submode#map('win-mode', 'n', '', '<', '<C-w><')
call submode#map('win-mode', 'n', '', '.', '<C-w>+')
call submode#map('win-mode', 'n', '', ',', '<C-w>-')
call submode#map('win-mode', 'n', '', '+', '<C-w>+')
call submode#map('win-mode', 'n', '', '-', '<C-w>-')
call submode#map('win-mode', 'n', '', 'r', '<C-w>r')
call submode#map('win-mode', 'n', '', '=', '<C-w>=')
call submode#map('win-mode', 'n', '', '0', '<C-w>=')
call submode#map('win-mode', 'n', 'rsx', 's', ':Unite window')
"-- Window分割
nnoremap <LocalLeader>s :<C-u>sp<CR>
nnoremap <LocalLeader>v :<C-u>vs<CR>

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


"------------------------------------------------------------
" Undo 設定
"------------------------------------------------------------
set undofile "Undo情報をファイルに記録

"-- GUndo --
let g:gundo_auto_preview =   0
let g:gundo_prefer_python3 = 1
nnoremap <silent> <leader>u :<C-u>UndotreeToggle<CR>

"-- UndoTree ---
let g:undotree_SetFocusWhenToggle =  1
nnoremap <silent> <F7> :<C-u>GundoToggle<CR>

"-- ClearUndo--
command! -bar ClearUndo  call s:clear_undo()
function! s:clear_undo() abort
    let old_undolevels = &undolevels
    setlocal undolevels=-1
    execute "normal! a \<BS>\<Esc>"
    let &l:undolevels = old_undolevels
    echo "Clear undo info."
endfunction

nnoremap <LocalLeader>U :<C-u>ClearUndo<CR>




"------------------------------------------------------------
" 不可視文字の可視化
"------------------------------------------------------------
" * Tab、全角スペース、行末のスペースを可視化する
" * Tab 行末のスペースは Syntax Specialkeyで指定する
" * 全角スペースは Syntax ZenkakuSpaceで指定できるようにしたつもり
"sample :teb =>	:全角スペース:　行末のスペース: 

"-- Tab、行末の半角スペース(SpecialKey) --
set list
set listchars=tab:^\ ,trail:~

"-- ZenkakuSpace --
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=white gui=underline guifg=yellow
endfunction

"-- 全角スペースを表示-- 
"CicaFontで見れるので変更
"何をしているかわからないけどコピペ 
"augroup ZenkakuSpace
"    autocmd!
"    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
"    augroup END
"call ZenkakuSpace()


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

"-- 一単語をヤンクしてきた文字列を置きかえ<Normal> --
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
noremap <S-Right> v<Right>

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
"* markで使うのはキーボード上段のq-uのみ使う
"* mmで自動的にasd...lに割振り
"* mo, miでマーク履歴(トルグにする)
"* 先にmのキーバインド外しているので使う分はすべてmap

"-- key --
nnoremap <silent> mm :<C-u>call <SID>AutoMarkrement()<CR>

"-- 次/前のマーク mo mi トルグで --
call submode#enter_with('jump-markpos', 'n', '', 'mo', ']`')
call submode#enter_with('jump-markpos', 'n', '', 'mi', '[`')
call submode#map('jump-markpos', 'n', 'r', 'o', ']`')
call submode#map('jump-markpos', 'n', 'r', 'i', '[`')

"-- 手動で使う分をmap --
noremap mq mq
noremap mw mw
noremap me me
noremap mr mr
noremap mt mt
noremap my my
noremap mu mu

"-- asd...kl に割振り ---
let s:markrement_chars = "asdfghjkl"
let s:mark_chars = "qwertyu"
if exists('s:markrement_chars')
    let g:unite_source_mark_marks = s:mark_chars . s:markrement_chars 
    let s:markrement_char_array = split( s:markrement_chars, '\zs') 
endif

"-- AutoMarkrement --
function! s:AutoMarkrement()
    if !exists('b:markrement_pos')
        let b:markrement_pos = 0
    else
        let b:markrement_pos = (b:markrement_pos + 1) % len(s:markrement_char_array)
    endif
    execute 'mark' s:markrement_char_array[b:markrement_pos]
    echo 'marked' s:markrement_char_array[b:markrement_pos]
endfunction


"----------------------------------------
" Quick Run
"----------------------------------------
noremap <silent>mn :w<CR>:QuickRun<CR>
noremap <silent><F8> :w<CR>:QuickRun<CR>
"-- key ---

"-- config --
let g:quickrun_config = {
\   "_" : {
\ 'runner'    : 'vimproc',
\ 'runner/vimproc/updatetime' : 1,
\       "outputter/buffer/split" : ":botright 8sp",
\       "hook/time/enable" : 1,
\   },
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
let g:accelerated_jk_acceleration_table = [7,12,17,21,24,26,28,30]

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
"noremap <LocalLeader>l $
" noremap <LocalLeader>h ^
call submode#enter_with('move-l-head', 'nv', '', '<LocalLeader>h'  ,'^')
call submode#map('move-l-head', 'nv', '', 'h'  ,'0')

call submode#enter_with('move-l-tail', 'nv', '', '<LocalLeader>l'  ,'g_l')
call submode#map('move-l-tail', 'nv', '', 'l'  ,'$')

"----------------------------------------
"mode切替
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
    execute '!start %:h'
endfunction
noremap <leader>e :<C-u>call <SID>ExplorerCurrentDir()<CR><CR>


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
" let g:Align_xstrlen=3
"// Windowsでの設定例です。Mac他の場合は外部コマンド部分を読み替えてください。
" au FileType plantuml command! OpenUml :!start chrome %


" 保存時のみ実行する
let g:ale_lint_on_text_changed = 0
" 表示に関する設定
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:airline#extensions#ale#open_lnum_symbol = '('
let g:airline#extensions#ale#close_lnum_symbol = ')'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
highlight link ALEErrorSign Tag
highlight link ALEWarningSign StorageClass
" Ctrl + kで次の指摘へ、Ctrl + jで前の指摘へ移動
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
