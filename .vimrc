
" search
"-----------------------------------------------------------------------------
" 検索時に大文字小文字を無視
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" ジャンプした時、現在のカーソル位置をキープする
set nostartofline
" インクリメンタルサーチ
set incsearch
" 検索時にファイルの最後まで行ったら最初に戻る
set wrapscan
" 検索結果をハイライトする
set hlsearch
" 正規表現に使われる記号を有効にする
set magic
" 検索語が画面の真ん中に来るようにする
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
" ()への移動
nnoremap ) t)
nnoremap ( t(
onoremap ) t)
onoremap ( t(
vnoremap ) t)
vnoremap ( t(

" edit
"-----------------------------------------------------------------------------
" 自動的にインデントしない
set noautoindent
" 自動的に改行しない (@ref http://d.hatena.ne.jp/WK6/20120606/1338993826)
autocmd FileType * setlocal textwidth=0
" 次行を自動的にコメントアウトしない
autocmd FileType * setlocal formatoptions-=ro
let g:PHP_autoformatcomment=0
let g:ft_html_autocomment=0

" cindent を有効にする
set nosmartindent
set cindent
set cinoptions=:0
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" 括弧入力時に対応する括弧を表示
set showmatch
" コマンドライン補完するときに強化されたものを使う
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

" display
"-----------------------------------------------------------------------------
" 行番号を表示
set number
" ルーラーを表示
set ruler
" 不可視文字を可視化しない
set nolist
" どの文字でタブや改行を表示するかを設定
set listchars=
" 長い行を折り返さない
set nowrap
" タイトルを表示しない
set notitle
" 他で書き換えられたら自動で読み直す
set autoread
" 折りたたみ機能を利用しない
set nofoldenable
" シンタックスハイライトを有効にする
syntax enable
" ビープ音、画面フラッシュ共にoff
set visualbell t_vb=
" コマンドラインの高さ
set cmdheight=1
" コマンドをステータス行に表示
set showcmd

" カラースキーマ
set background=dark
let g:solarized_termcolors=16
colorscheme solarized

" encoding
"-----------------------------------------------------------------------------
" 文字コード
"if $LANG == 'ja_JP.UTF-8'
"  set encoding=utf-8
"  set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
"  set termencoding=utf-8
"else
"  set encoding=euc-jp
"  set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp
"  set termencoding=euc-jp
"endif

" utf-8 決め打ち
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp

" status-line
"-----------------------------------------------------------------------------
" 常にステータスラインを表示
set laststatus=2

" ステータスラインの書式設定
set statusline=[%n]\ %y%{GetStatusEx()}\ %f%m%r%=%l/%L,%c%V\(%p%%)

" 文字エンコーディングと改行コード取得関数
function! GetStatusEx()
    let str = '['
    if has('multi_byte') && &fileencoding != ''
        let str = str . &fileencoding . ':'
    endif
    let str = str . '' . &fileformat . ']'
    return str
endfunction

" 挿入モード時、ステータスラインの色を変更
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=darkred ctermbg=220 cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

" backup
"-----------------------------------------------------------------------------
" バックアップを取る
set backup
" バックアップのディレクトリ (パーミッション気をつけないとパスワードファイルとか覗かれる)
set backupdir=~/.vim/backup
" バッファを切り替えてもundoを有効
set hidden
" viminfoのフォーマット
set viminfo='1000,\"50,f1,h,rA:,rB:
" スワップファイルを作る
set swapfile
set directory=~/.vim/swap
" コマンド履歴
set history=1000

" clipboard
"-----------------------------------------------------------------------------
" クリップボードを共有する
"set guioptions+=a
set guioptions-=a
"set clipboard+=autoselect
"set clipboard+=unnamed
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

" environment dependense settings
"-----------------------------------------------------------------------------
" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

" Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
if has('mac')
  set iskeyword=@,48-57,_,128-167,224-235
endif

" ヤンクバッファからクリップボードにコピー
if !has('gui')
    cnoremap pbcopy<CR> call system("pbcopy", @")<CR>
endif

" neobundle
"-----------------------------------------------------------------------------
set nocompatible               " Be iMproved

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \   'unit' : 'make -f make_unix.mak',
            \ },
            \}

" My Bundles here:
NeoBundle 'hk4nsuke/memolist.vim'
NeoBundle 'hk4nsuke/aoi-jump.vim'
NeoBundle 'hk4nsuke/Align'
NeoBundle 'hk4nsuke/vim-colors-solarized'
NeoBundle 'hk4nsuke/Mark'
"NeoBundle 'hk4nsuke/vdebug'
NeoBundle 'joonty/vdebug'
NeoBundle 'vim-scripts/PDV--phpDocumentor-for-Vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'hk4nsuke/winresizer'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'hk4nsuke/unite-git_grep'
NeoBundle 'hk4nsuke/unite-gtags'
NeoBundle 'hk4nsuke/unite-tmux'
NeoBundle 'ujihisa/unite-locate'
NeoBundle 'hk4nsuke/unite-php-ethna'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'thinca/vim-ref'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'jktgr/smarty.vim'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'kana/vim-operator-user.git'
NeoBundle 'kana/vim-operator-replace.git'
NeoBundle 'marijnh/tern_for_vim', {
  \ 'build': {
  \   'others': 'npm install'
  \}}
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'vim-jp/vital.vim'
NeoBundle 'osyo-manga/unite-choosewin-actions'
NeoBundle 't9md/vim-choosewin'
NeoBundle 'jdonaldson/vaxe'
NeoBundle 'ujihisa/unite-colorscheme'
"NeoBundle 'violetyk/neocomplete-php.vim'
"NeoBundle 'osyo-manga/vim-reanimate'
"NeoBundle 'everzet/phpfolding.vim'
"NeoBundle 'hk4nsuke/AutoComplPop'
"NeoBundle 'hk4nsuke/vim-php-ethna-jump.vim'
"NeoBundle 'pydave/AsyncCommand'
"NeoBundle 'stgpetrovic/syntastic-async'
"NeoBundle "osyo-manga/shabadou.vim"
"NeoBundle 'osyo-manga/vim-watchdogs'

filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
NeoBundleCheck

" external settings
"-----------------------------------------------------------------------------
" ctags
" tagファイルを上流へ再帰的に検索する
set tags+=tags;

" 各bundleのcustom.vimにプラグインごとの設定を記載する
" .vim/after/plugin/conf.d に移行する
runtime! bundle/*/custom.vim

" プラグインごとの設定
runtime! conf.d/*.vim

" custom command
"-----------------------------------------------------------------------------
" vimgrep
cnoremap rgrep vimgrep // **/*.{*,*} <Bar> cwin<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
cnoremap cgrep vimgrep // % <Bar> cwin<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

" json 整形
cnoremap <leader>json<CR> !python -m json.tool<CR>

" 文字コードを指定して開く
cnoremap sjis<CR> e ++enc=sjis<CR>
cnoremap euc<CR> e ++enc=euc-jisx0213<CR>
cnoremap utf<CR> e ++enc=utf-8<CR>

" code snipet
"-----------------------------------------------------------------------------
" Pear Error 
function! PearErrorSnipet()
  let l:cursor_word  = expand("<cword>")

  let l:text = printf("if (PEAR::isError($err = $%s)) {", l:cursor_word)
  exe "norm! o" . l:text
  let l:text = "return $err;"
  exe "norm! o" . l:text
  let l:text = "}"
  exe "norm! o" . l:text
endfunction
noremap <silent> <space>p :call PearErrorSnipet()<CR>

" others
"-----------------------------------------------------------------------------

" 現在開いているファイルのある場所にcdする
" XXX:カレントディレクトリをフルパス (:p) に展開し、その head (先端) (:h) を取り出す
augroup ChangeDirectory
    " グループ内の autocommand を全て削除する (これがしたかったので augroup で囲んでいる)
    autocmd!
    " lcd は cd と違い、カレントウィンドウのディレクトリのみを変更する (この使い方の場合差は無いけど、意味合い的にこちらにしておく)
    autocmd BufEnter * :lcd %:p:h
augroup END 


" gtags
"-----------------------------------------------------------------------------
"autocmd BufWritePost $F/**/* silent execute "!cd $F; gtags -q /mnt/ramdisk &"

" java
"-----------------------------------------------------------------------------
let java_highlight_all=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1


" local settings
"-----------------------------------------------------------------------------
source $HOME/.vimrc.d/.vimrc.common

" sandbox..
"-----------------------------------------------------------------------------
""nnoremap <C-\> :Gtags -r <C-R>=expand("<cword>")<CR><CR>
"" XXX:スクリプト外で実行されるのでグローバル関数
"" functionの!は既存の関数を上書きする設定。スクリプト再読み込み時対策
"function! GtagsExec(cword, opt, win)
"   " quickfixを空にしておく
"   call setqflist([])
"   " 引数には a: でアクセス
"   :execute "Gtags " . a:opt . " " . a:cword
"   if a:win == "true"
"       " TODO:quickfixリストは必ずしもアクティブなwindowに結果を出力するわけではないので、
"       " 意図しない分割が行われる可能性がある。保留中。
"       vsp
"       :execute "normal \<C-o>"
"   endif
"   " 候補が1つの場合はquickfixリストを閉じる
"   if len(getqflist()) == 1
"       ccl
"   endif
""  " quickfixを空にしておく
""  call setqflist([])
""  :execute "Gtags " . a:opt . " " . a:cword
""  " quickfixリストの長さを見て処理を分岐
""  let len = len(getqflist())
""  if len == 1
""      if a:win == "true"
""          sp +cc
""      else
""          cc
""      endif
""      ccl
""  elseif len >= 2
""      copen
""  endif
"endfunction
""nnoremap <C-]> :call GtagsExec(expand("<cword>"), "",   "false")<CR>
"nnoremap <C-\> :call GtagsExec(expand("<cword>"), "-r", "false")<CR>
""nnoremap <C-w><C-]> :call GtagsExec(expand("<cword>"), "",   "true")<CR>
"nnoremap <C-w><C-\> :call GtagsExec(expand("<cword>"), "-r", "true")<CR>

" EOF


" fixme
nnoremap <leader>ej :Unite ethna<CR>
