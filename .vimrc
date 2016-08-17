if &compatible
  set nocompatible
endif

" reset augroup
"augroup MyAutoCmd
"  autocmd!
"augroup END

" dein settings {{{
" dein自体の自インストール

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.vim') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/.dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}
" 引数なしでvimを開くとNERDTreeを起動
let file_name = expand('%')
if has('vim_starting') &&  file_name == ''
  autocmd VimEnter * NERDTree ./
endif

"End dein Scripts-------------------------

set number "行番号表示
syntax on  "カラーシンタックス
" 矢印キーでなら行内を動けるように
nnoremap <Down> gj
nnoremap <Up>   gk
" showbreaks
set showbreak=↪
" 入力モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
" jjでエスケープ
inoremap <silent> jj <ESC>
inoremap <silent> っj <ESC>

" 日本語入力がオンのままでも使えるコマンド(Enterキーは必要)
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
nnoremap っd dd
nnoremap っy yy




"command! FollowSymlink call s:SwitchToActualFile()
"function! s:SwitchToActualFile()
"    let l:fname = resolve(expand('%:p'))
"    let l:pos = getpos('.')
"    let l:bufname = bufname('%')
"    enew
"    exec 'bw '. l:bufname
"    exec "e" . fname
"    call setpos('.', pos)
"endfunction

