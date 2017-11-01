"========================================
" initial settings
"========================================
if &compatible
  set nocompatible "vi �݊�����Ȃ�
endif
"----autocmd��reset---------
"���d�N���h�~ autocmd�g���Ƃ���
"augroup��MyAutoCmd�ɂ���΂����ŏ����Ă����
augroup MyAutoCmd
  autocmd!
augroup END


"========================================
"" {{{ dein settings :
"========================================
"----------------------------------------
" �����ݒ�
"----------------------------------------
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.vim') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

echo s:dein_repo_dir

set swapfile
set directory=C:/Users/appli/.vim/tmp/swap
set backup
set backupdir=C:/Users/appli/.vim/tmp/backup



"----�C���X�g�[������Ė�����΁A�����ŃC���X�g�[��
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

"----------------------------------------
" �v���O�C���ǂݍ��݁��L���b�V���쐬
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
" �s���v���O�C���̎����C���X�g�[��
"----------------------------------------
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
""}}}


"========================================
" ���̑� settings
"========================================

"----------------------------------------
"�I�v�V������
"----------------------------------------
set title         "�ҏW���̃t�@�C�����^�C�g���ɕ\��"
set number        "�s�ԍ��\��
syntax on         "�J���[�V���^�b�N�X
set foldmethod=marker
set scrolloff=7

"----Color Syntax--------
colorscheme happy_hacking
"colorscheme japanesque


"----AirLine------------
set laststatus=2
let g:airline_theme='one'

"----�Ή����銇�ʂ��n�C���C�g
hi MatchParen ctermbg=4�@"�F
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
nnoremap j gj  //�����s�ňړ�
nnoremap k gk�@

nnoremap n nzz //�������ʂ���ʒ�����
nnoremap N Nzz

set hlsearch      "�����q�b�g�����ɐF�t��
nnoremap <silent> <C-L> :noh<C-L><CR> //�������ʃn�C���C�g����~

"----------------------------------------
" �����Ȃ���vim���J����NERDTree���N��
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
"�⊮���X�g�Ȃ񂩂Ƃ��Ԃ��Ă�H

"-----migemo----------------
augroup MyAutoCmd
   autocmd InsertEnter,InsertLeave * set cursorline!
augroup END
map <Space>/ <Plug>(vigemo-search)

"----------------------------------------
"incert mode�𔲂���Ƃ���IME��off
"----------------------------------------
"�������ǃt�b�N�̃^�C�~���O���x���̂�fcitx�Őݒ�ɕύX
" ~/.config/fcitx/config �𒼐ڕҏW(GUI�ł�ESC����͕s��)
"augroup MyAutoCmd
"  "InsertMode���甲����Ƃ���IME-OFF
"  autocmd InsertLeave * call system('fcitx-remote -c')
"augroup END

