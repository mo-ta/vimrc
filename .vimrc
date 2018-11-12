" "----------------------------------------
" initial settings
"----------------------------------------
if &compatible
    set nocompatible "vi �݊�����Ȃ�
endif


"----------------------------------------
" ����Ȃ��v���O�C��OFF!
"----------------------------------------
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1


"----------------------------------------
" dein settings 
"----------------------------------------
"-- �����ݒ� --
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.vim') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home .  '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

"-- �����C���X�g�[�� --
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

"-- �v���O�C���ǂݍ��݁��L���b�V���쐬 --
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/.dein.toml'
let s:toml_file = '~/.dein.toml'
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
    call dein#load_toml(s:toml_file)
    call dein#end()
    call dein#save_state()
endif

"-- �s���v���O�C���̎����C���X�g�[�� --
let g:vimproc#download_windows_dll = 1  "�R���p�C���ς�dll�̎����_�E�����[�h
if has('vim_starting') && dein#check_install()
    call dein#install()
endif


"----------------------------------------
" �f�B���N�g���ݒ聕�����쐬
"----------------------------------------
"-- �f�B���N�g���w��
let  s:tmp_dir         = s:cache_home . '/tmp'
let  s:local_dir       = s:cache_home . '/local'
let  s:swap_dir        = s:tmp_dir    . '/swap'
let  s:backup_dir      = s:tmp_dir    . '/backup'
let  s:undo_dir        = s:tmp_dir    . '/undo'
let  s:bookmark_dir    = s:local_dir  . '/bookmark'
let  s:junkfile_dir    = s:local_dir  . '/junkfile'
let  s:migemo_dict_dir = s:local_dir  . '/dict'
let  s:howm_dir        = s:local_dir  . '/howm'

"-- �f�B���N�g���m�F�Ǝ������� --
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

"-- �f�B���N�g���̎w�� --
set swapfile
let &directory = s:swap_dir

set backup
let &backupdir = s:backup_dir

if has('persistent_undo')
    let &undodir = s:undo_dir
endif


"----------------------------------------
" �I�v�V������
"----------------------------------------
set title                " �ҏW���̃t�@�C�����^�C�g���ɕ\��"
set number               " �s�ԍ��\��
set hidden               " �ҏW���ł��o�b�t�@���J��
set columns=250          " �E�C���h�E�̍���
set lines=40             " �R�}���h���C���̍���(GUI�g�p��)
set scrolloff=2          " �㉺�̃X�N���[�����Ȃ�����
set autochdir            " ��ɃJ�����g�o�b�t�@�����[�g��
set shellslash           " path��backslash�Ή�(Dos�p)
set shortmess+=I         " �E�K���_��\��
set display=lastline     " �����s�������ƕ\��
set virtualedit+=block   " �r�W���A�����[�h�̋�`�I�����ɉ��z�ҏW�ł���悤�ɂ���B
set virtualedit+=all     " �������̃��[�h�ŉ��z�ҏW�ł���悤�ɂ���B
set completeopt+=noinsert
set backspace=2
set noerrorbells "Beep���͖炳�Ȃ�
filetype plugin indent on
set autoindent
set shiftwidth=4
set tabstop=4
set wildmenu wildmode=list:longest,full "���C���h���j���[�ݒ�
set helplang=ja,en       "help�͓��{���                                        sh
set pumheight=10

if has("kaoriya")
    set fileencodings=guess
    set modeline
else
    set fileencodings=utf-8,cp932,euc-jp,sjis
endif


"---Color Syntax---
syntax on
set background=dark
colorscheme japanesque-mota
set termguicolors

"---IME�̃��[�h�ŐF��������----
set imdisable
augroup InsModeAu
    autocmd!
    autocmd InsertEnter,CmdwinEnter * set noimdisable
    autocmd InsertLeave,CmdwinLeave * set imdisable
augroup END

"----AirLine------------
set laststatus=2
let g:airline_theme = 'molokai'

"----�Ή����銇�ʂ��n�C���C�g
highlight MatchParen ctermfg=Red
set showmatch
set matchtime=1 "�}�b�`���銇�ʂ̕\������ *0.1sec
"-- viminfo --
"[']: mark�̃t�@�C������
"["]: ���W�X�^�s��
"[:]: �R�}���h����
"[n]: �ۑ��t�@�C���̎w��
set viminfo='50,\"1000,:0,n~/.vim/viminfo

"----------------------------------------
" �t�H���g�ݒ�
"----------------------------------------
if has('win32')
    set guifont=MS_Gothic:h12:cSHIFTJIS    " Windows�p
    set linespace=1                        " �s�Ԋu�̐ݒ�
    if has('kaoriya')
        set ambiwidth=auto                 " �ꕔ��UCS�����̕��������v�����Č��߂�
    endif
endif


"----------------------------------------
" Mouse
"----------------------------------------
set mouse=a       " �ǂ̃��[�h�ł��}�E�X���g����悤�ɂ���
set nomousefocus  " �}�E�X�̈ړ��Ńt�H�[�J�X�������I�ɐؑւ��Ȃ�
set nomousehide   " ���͎��Ƀ}�E�X�|�C���^���B���Ȃ�
set guioptions+=a " �r�W���A���I��(D&D��)�������I�ɃN���b�v�{�[�h�� (:help guioptions_a)


"----------------------------------------
" Python
"----------------------------------------
" ���s�t�@�C���̃t�H���_��python3����肻�̒��Ɋ֘A�t�@�C��������ݒ�
set runtimepath+=$VIM
set pythonthreedll=$VIM/python3/python35.dll


"----------------------------------------
" Mapping������ Leader����
"----------------------------------------
" * s : <Leader>�Ƃ��Ďg��
" * m : m[qwrtyuiop] �ȊO�͕ʋ@�\��Mapping���邽�߈�U������
" * , : Howm Prefix�Ƃ��Ďg��
"-- <Nop>�ɏ����� --
nnoremap s <Nop>
nnoremap m <Nop>
nnoremap , <Nop>

"-- <Leader> <LocalLeader>�ݒ� --
let mapleader="s"
let maplocalleader = "\<Space>"


"----------------------------------------
" Sub Mode
"----------------------------------------
let g:submode_timeoutlen = 10000            "submode��autooff�ɂȂ鎞�� ��{OFF���Ȃ�
let g:submode_keep_leaving_key = 1          "���̃L�[�������ꂽ�ꍇ�A�R�}���h�Ƃ��Ď��s����


"----------------------------------------
" Unite Denite
"----------------------------------------
"-- Unite Setting --
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_mru_limit = 200
let g:unite_source_file_mru_filename_format = ':~:.' "�ŋߊJ�����t�@�C�� 
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
    " ���̓��[�h�̂Ƃ�ctrl+w�Ńo�b�N�X���b�V�����폜
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
nnoremap <silent> <leader>h :<C-u>Denite file_mru<CR>
nnoremap <silent> <leader>b :<C-u>Denite buffer<CR>
nnoremap <silent> <leader>y :<C-u>Unite history/yank<CR>
nnoremap <silent> <leader>Y :<C-u>Unite yankround<CR>
nnoremap <silent> <leader>o :<C-u>Unite -vertical -winwidth=30 outline<CR>
nnoremap <silent> <leader>O :<C-u>Unite -vertical -winwidth=30 -no-quit outline<CR>
nnoremap <silent> <leader>w :<C-u>Unite window<CR>
nnoremap <silent> <leader>t :<C-u>Unite tab<CR>
nnoremap <silent> <leader>m :<C-u>Unite mark<CR>
nnoremap <silent> <leader>s :<C-u>Unite session<CR>
nnoremap <silent> <leader>r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <leader>f :<C-u>VimFiler -split -simple -winwidth=35 -no-quit<CR>
nnoremap <silent> <leader>a :<C-u>Unit BookmarkAdd<CR>
nnoremap <silent> <leader>c :<C-u>Unit bookmark<CR>
"nnoremap <F2> :VimFiler<CR>
"inoremap <silent> <C-s> <Esc>:Unite history/yank<CR>


"--------------------------------------------------
" �ꕶ������
"--------------------------------------------------
" * UNDO�������܂Ƃ߂Ĉ��łł���悤��
" * yank�����Ȃ�
" * <c-h>��NomalMode�ł�<X>�Ɠ�������������

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
" �R�}���h���C���g��
"--------------------------------------------------
"  ':'        --> OverCommandLine
"  '::'       --> �ʏ�
"  '<SPACE>:' --> OutputRegister(�o�͂����W�X�^�ۑ�)

"-- OutputRegister --
command! -nargs=* -complete=command
\   OutputRegister
\   redir @*
\|  execute <q-args>
\|  redir END

noremap : :OverCommandLine<CR>
noremap :: :
noremap <LocalLeader>: :<C-u>OutputRegister :


"--------------------------------------------------
" �O��I���ʒu�Ɉړ�
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

augroup MarkdownKeyMap
   autocmd!
   autocmd BufRead,BufNewFile *.md  set filetype=markdown
augroup END

function! s:ExecShiba()
    let s:shiba_arg = 'c:/bin/shiba/shiba.exe --detach ' . expand('%') 
    execute '!start' s:shiba_arg
endfunction

"-- shiba�ŊJ�� --
nnoremap <silent> ma :<C-u>call <SID>ExecShiba()<CR>

"-- html�ŊJ��(previm) --
let g:previm_enable_realtime = 1
nnoremap <silent> mp :PrevimOpen<CR>


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

"-- <Leader>j ��map --
nnoremap <silent> <leader>j :<C-u>JunkFile<CR>


"----------------------------------------
" Scratch
"----------------------------------------
" kaoriya��plugin(cmdex.vim)����R�s�[
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

"-- <Leader>J ��map --
nnoremap <silent> <leader>J :<C-u>Scratch<CR>


"----------------------------------------
" yank paste�ݒ�
"----------------------------------------
"* �N���b�v�{�[�h�ƘA�g����
"* submode��yankround����
"* p�őO���
"* P�Ō���
"-- ClipBoard�A�g --

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
" �L�[�}�b�v���[�_�[
let QFixHowm_Key  = ','
let QFixHowm_KeyB = ''

let howm_dir            = s:howm_dir
let howm_filename       = '%Y/%m/%Y-%m-%d-%H%M%S.md'
let howm_fileencoding   = 'cp932'
let howm_fileformat     = 'dos'

let QFixWin_EnableMode  = 1          " �v���r���[��i�荞�݂�QuickFix/���P�[�V�������X�g�̗����ŗL����(�f�t�H���g:2)
let QFixHowm_FileType   = 'markdown' " QFixHowm�̃t�@�C���^�C�v
let QFixHowm_Title      = '#'        " �^�C�g���L���� # �ɕύX����(markdown�g�p�̓s����)
let QFixWin_EnableMode  = 1          " QuickFix�E�B���h�E�ł��v���r���[��i�荞�݂�L����
let QFix_UseLocationList= 1          " QFixHowm/QFixGrep�̌��ʕ\���Ƀ��P�[�V�������X�g���g�p����
autocmd Filetype qfix_memo setlocal textwidth=0 " textwidth�̍Đݒ�
"let QFixHowm_HolidayFile = '<�x����`�t�@�C�� Sche-Hd-0000-00-00-000000.utf8 �܂ł̃p�X>'
let QFixHowm_Wiki = 1               "�I�[�g�����N�Ńt�@�C�����J��


"------------------------------------------------------------
" �����֘A
"------------------------------------------------------------
set nohlsearch " �ŏ��̓n�C���C�gOFF(����ON-OFF����)
set incsearch  " �C���N�������^���T�[�`
set ignorecase " �������̗������܂܂�Ă���ꍇ�͑啶�������������
set smartcase  "
set backspace=indent,eol,start " �������Ƀt�@�C���̍Ō�܂ōs������ŏ��ɖ߂�

"  * /,?,*,# �������ꂽ��Hilight ON �ɂ��Ă���
"   /,? ��migemo
"   n,N �͉�ʒ�����

if has("migemo") "kaoriya��p
    set migemo
    "let &migemodict = s:migemo_dict_dir
    let migemodict = s:migemo_dict_dir
    nnoremap /  :<C-u>set hlsearch<Return>g/
    nnoremap g/ :<C-u>set hlsearch<Return>/
    nnoremap ?  :<C-u>set hlsearch<Return>g?
    nnoremap g? :<C-u>set hlsearch<Return>?
endif
nnoremap <silent><Esc> :<C-u>set nohlsearch<Return><Esc>

nnoremap * :<C-u>set hlsearch<Return>*<C-o>zz
nnoremap # :<C-u>set hlsearch<Return>#zz
nnoremap n :<C-u>set hlsearch<Return>nzz
nnoremap N :<C-u>set hlsearch<Return>Nzz

"-- easymotion --
let g:EasyMotion_use_migemo = 1 " Migemo�@�\ON
let g:EasyMotion_do_mapping = 0 " mapping�͎�����
nmap <Space><Space> <Plug>(easymotion-overwin-f2)
vmap <Space><Space> <Plug>(easymotion-bd-f2)

"-- clever-f --
let g:clever_f_timeout_ms = 1000                    " timeout�Ŏ���OFF
let g:clever_f_not_overwrites_standard_mappings = 0 " mapping�͎�����
map f <Plug>(clever-f-f)
map F <Plug>(clever-f-F)
map t <Plug>(clever-f-t)
map T <Plug>(clever-f-T)


"------------------------------------------------------------
" �s����R�}���h
"------------------------------------------------------------
"-- �s���ƈړ�(VisualMode�ł͕����s�܂Ƃ߂�) --
nnoremap <C-Down> "zdd"zp
nnoremap <C-Up> "zdd<Up>"zP
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]

"-- ���s�}�� --
"�J�[�\���s�̉���
imap <S-CR> <End><CR>
nnoremap <S-CR> mzo<ESC>`z

"�J�[�\���s�̏��
nnoremap <C-S-CR> mzO<ESC>`z
imap <C-S-CR> <Up><End><CR>


"------------------------------------------------------------
" �o�b�t�@, Window, Tab����
"------------------------------------------------------------
"-- Window�ړ� -- w�̃g���O
call submode#enter_with('jump-win', 'n', '', '<LocalLeader>w', '<C-w>w')
call submode#enter_with('jump-win', 'n', '', '<LocalLeader>W', '<C-w>W')
call submode#map('jump-win', 'n', '', 'w', '<C-w>w')
call submode#map('jump-win', 'n', '', 'W', '<C-w>W')

"-- Window�ʒu����ւ� --
nnoremap <LocalLeader>J <C-w>J
nnoremap <LocalLeader>K <C-w>K
nnoremap <LocalLeader>L <C-w>L
nnoremap <LocalLeader>H <C-w>H
nnoremap <LocalLeader>r <C-w>r

"-- Window�T�C�Y�ύX
nnoremap <LocalLeader>= <C-w>=
noremap  <LocalLeader>0 <C-w>=
call submode#enter_with('winsize', 'n', '', '<LocalLeader>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<LocalLeader><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<LocalLeader>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<LocalLeader>-', '<C-w>-')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')

"-- Window����
nnoremap <LocalLeader>s :<C-u>sp<CR>
nnoremap <LocalLeader>v :<C-u>vs<CR>

"-- �o�b�t�@�؂�ւ� --
call submode#enter_with('buf-change', 'n', '', '<LocalLeader>b', ':<C-u>bn<CR>')
call submode#enter_with('buf-change', 'n', '', '<LocalLeader>B', ':<C-u>bp<CR>')
call submode#map('buf-change', 'n', '', 'b', ':<C-u>bn<CR>')
call submode#map('buf-change', 'n', '', 'B', ':<C-u>bp<CR>')

"-- �ۑ��A�I�� --
"nnoremap <LocalLeader>w :<C-u>w<CR>
nnoremap <LocalLeader>q :<C-u>q<CR>
nnoremap <LocalLeader>Q :<C-u>q!<CR>

"-- TAB���� --
call submode#enter_with('tab-change', 'n', '', '<LocalLeader>t' ,'gt')
call submode#map('tab-change', 'n', '', 't', 'gt')
nnoremap <LocalLeader>T :<C-u>tabnew<CR>


"------------------------------------------------------------
" Undo �ݒ�
"------------------------------------------------------------
set undofile "Undo�����t�@�C���ɋL�^

"-- GUndo --
let g:gundo_auto_preview = 1
let g:gundo_prefer_python3 = 1

nnoremap <silent> <leader>u :<C-u>GundoToggle<CR>

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
" �s�������̉���
"------------------------------------------------------------
" * Tab�A�S�p�X�y�[�X�A�s���̃X�y�[�X����������
" * Tab �s���̃X�y�[�X�� Syntax Specialkey�Ŏw�肷��
" * �S�p�X�y�[�X�� Syntax ZenkakuSpace�Ŏw��ł���悤�ɂ�������
"sample :teb =>	:�S�p�X�y�[�X:�@�s���̃X�y�[�X: 

"-- Tab�A�s���̔��p�X�y�[�X(SpecialKey) --
set list
set listchars=tab:^\ ,trail:~

"-- ZenkakuSpace --
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=white gui=underline guifg=yellow
endfunction

"-- �S�p�X�y�[�X��\��-- 
"�������Ă��邩�킩��Ȃ����ǃR�s�y 
augroup ZenkakuSpace
    autocmd!
    autocmd VimEnter,WinEnter * match ZenkakuSpace /�@/
    augroup END
call ZenkakuSpace()


""----------------------------------------
" endwise
"----------------------------------------
" insertmode �� ���s�ŃR�}���h���s����̂ő��ƂԂ���Ȃ��悤�� �w��g���q�̂Ƃ��̂ݎ��s����
let g:endwise_no_mappings = 1

" -- UseEndWise --
augroup UseEndWise 
    autocmd!
    autocmd FileType lua,ruby,sh,zsh,vb,vbnet,aspvbs,vim imap <buffer> <CR> <CR><Plug>DiscretionaryEnd
augroup END


" ------------------------------------------------------------
" ������܂肵��keybind
"------------------------------------------------------------

"-- jj��InsertMode���[�h�𔲂���<Insert> --
"-- InsertMode���[�h�𔲂���Ƃ��͉E��<Insert> --
inoremap <silent> jj <ESC><Right>
inoremap <silent> ���� <ESC><Right>
inoremap <Esc> <Esc><Right>

"-- �^�C�|�C��<Insert> --
inoremap <C-t> <Esc><Left>"zx"zpa
nnoremap <C-t> <Left>"zx"pz


"-- �s���܂Ń����N<Normal,Visual> --
nnoremap Y y$

"-- ��P��������N���Ă����������u������<Normal> --
nnoremap ciy ciw<C-r>0<ESC><Right>
nnoremap ciY ciW<C-r>0<ESC><Right>

"-- inc dec --
nnoremap - <C-x>
nnoremap + <C-a>

"-- �ύX�_��jump --
call submode#enter_with('jump-modify', 'n', '', '<LocalLeader>i', 'g,')
call submode#enter_with('jump-modify', 'n', '', '<LocalLeader>o', 'g;')
call submode#map('jump-modify', 'n', '', 'i', 'g,')
call submode#map('jump-modify', 'n', '', 'o', 'g;')


"----------------------------------------
" Visual Mode �֘A
"----------------------------------------
"-- win���ۂ� Shift + ���ŗ̈�I�� --
nnoremap <S-Up>    v<Up>
nnoremap <S-Down>  v<Down>
nnoremap <S-Left>  v<Left>
noremap <S-Right> v<Right>

vnoremap <S-Up>    <Up>
vnoremap <S-Down>  <Down>
vnoremap <S-Left>  <Left>
vnoremap <S-Right> <Right>

"-- �g���O��VisualMode��؂�ւ� --
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

" - ����ݒ� -
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
" mark�ݒ�
"----------------------------------------
"* mark�Ŏg���̂̓L�[�{�[�h��i��q-u�̂ݎg��
"* mm�Ŏ����I��asd...l�Ɋ��U��
"* mo, mi�Ń}�[�N����(�g���O�ɂ���)
"* ���m�̃L�[�o�C���h�O���Ă���̂Ŏg�����͂��ׂ�map

"-- key --
nnoremap <silent> mm :<C-u>call <SID>AutoMarkrement()<CR>

"-- ��/�O�̃}�[�N mo mi �g���O�� --
call submode#enter_with('jump-markpos', 'n', '', 'mo', ']`')
call submode#enter_with('jump-markpos', 'n', '', 'mi', '[`')
call submode#map('jump-markpos', 'n', 'r', 'o', ']`')
call submode#map('jump-markpos', 'n', 'r', 'i', '[`')

"-- �蓮�Ŏg������map --
noremap mq mq
noremap mw mw
noremap me me
noremap mr mr
noremap mt mt
noremap my my
noremap mu mu

"-- asd...kl �Ɋ��U�� ---
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

"-- key ---
nnoremap <silent>mn :QuickRun ruby<CR>

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
" �R�����g(caw.vim)
"----------------------------------------
" *  �R�����g�̃g���O
"    * <LL>c   �󔒂̂����擪
"    * <LL>C   �s��
" * yc �R�����g���������̂�\��t��
"    * yc ��ɓ\��t��
"    * yC ���ɓ\��t��
"
"-- mapping --
nmap <LocalLeader>c <Plug>(caw:hatpos:toggle)
vmap <LocalLeader>c <Plug>(caw:hatpos:toggle)
nmap <LocalLeader>C <Plug>(caw:zeropos:toggle)
vmap <LocalLeader>C <Plug>(caw:zeropos:toggle)

"-- �s�R�s�[���ăR�����g���������̂��y�[�X�g --
"- �オ�R�����g -
nmap yc "zyy"zP<Plug>(caw:hatpos:comment)j
vmap yc "zYgv<ESC>"zpgv<Plug>(caw:hatpos:comment)gv<ESC>j

"- �����R�����g -
nmap yC "zyy"zp<Plug>(caw:hatpos:comment)k
vmap yC "zY"zPgv<Plug>(caw:hatpos:comment)k


"----------------------------------------
" %�̊g��(matchit)
"----------------------------------------
if !exists('loaded_matchit')
    " matchit��L����
    runtime macrosmatchit.vim
endif

" �Ή����ʂ�ǉ�
set matchpairs& matchpairs+=<:>
set matchpairs+=�u:�v,�w:�x,�i:�j,�y:�z,�s:�t,�q:�r,�m:�n,�e:�f,�g:�h

" =============================������============================================
" gmilk �R�}���h�̌��ʂ�Unite qf �ŕ\������
command! -nargs=1 Gmilk call s:Gmilk("gmilk -a -n 200", <f-args>)

function! s:Gmilk(cmd, arg)
    silent execute "cgetexpr system(\"" . a:cmd . " ". a:arg . "\")"
    if len(getqflist()) == 0
        echohl WarningMsg
        echomsg "No match found."
        echohl None
    else
    execute "Unite -auto-preview qf"
        redraw!

endfunction

"-------Terminal
tnoremap <Esc> <C-\><C-n>

function! s:TerminalRight()
    vsplit
    terminal ++curwin
endfunction

noremap  <silent> <leader>i :<C-u>call <SID>TerminalRight()<CR>

function! s:bufnew()
   " �K���ɂ� 'buftype' �͐ݒ肳��Ă���̂ł������Ƃ���
    if &buftype == "terminal" && &filetype == ""
        set filetype=terminal
    endif
endfunction

function! s:filetype()
   " ������ :terminal �̃o�b�t�@�ŗL�̐ݒ���L�q����
endfunction

augroup my-terminal
    autocmd!
   " BufNew �̎��_�ł� 'buftype' ���ݒ肳��Ă��Ȃ��̂� timer �C�x���g�ł��܂����Ȃǁc
    autocmd BufNew * call timer_start(0, { -> s:bufnew() })
    autocmd FileType terminal call s:filetype()
augroup END

"----------------------------------------
"�܂���
"----------------------------------------
"set foldmethod=marker
set foldmethod=indent " �܂��݂̊
set foldlevel=2       " �t�@�C�����J�������̐܂��݃��x��
set foldcolumn=2      " �܂��݂̏�Ԃ����[n��ɕ\��

" https://hatebu.me/entry/2017/09/18/223131
" https://www.soum.co.jp/misc/vim-no-susume/1/
" http://secret-garden.hatenablog.com/entry/2015/04/16/000000

noremap gk k
noremap gj j

"-- accelerated_jk�ŉ���, l,h �ɂ��g��
let g:accelerated_jk_acceleration_table = [7,12,17,21,24,26,28,30]

nmap k <Plug>(accelerated_gk)
nmap j <Plug>(accelerated_gj)
nmap l <Plug>(accelerated_l)
nmap h <Plug>(accelerated_h)
"
"-- <LL>j, <LL>k�ŉ��� (J,K�ł���ɉ���)
let s:move_jk_step_size = 15
let s:move_jk_step_size_large = 45

call submode#enter_with('move-j', 'nv', '', '<LocalLeader>j', s:move_jk_step_size . 'gj')
call submode#map('move-j', 'nv', '', 'j'  , s:move_jk_step_size . 'gj')
call submode#map('move-j', 'nv', '', 'J'  , s:move_jk_step_size_large . 'gj')

call submode#enter_with('move-k', 'nv', '', '<LocalLeader>k' , s:move_jk_step_size .'gk')
call submode#map('move-k', 'nv', '', 'k'  , s:move_jk_step_size . 'gk')
call submode#map('move-k', 'nv', '', 'K'  , s:move_jk_step_size_large . 'gk')

"-- <LL>l => $, <LL>k => ^ or 0 -
noremap <LocalLeader>l $
noremap <LocalLeader>h ^
call submode#enter_with('move-l-head', 'nv', '', '<LocalLeader>h'  ,'^')
call submode#map('move-l-head', 'nv', '', 'h'  ,'0')

