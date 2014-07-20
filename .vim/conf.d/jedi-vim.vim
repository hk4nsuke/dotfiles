" pythoncomplete との競合回避
autocmd FileType python let b:did_ftplugin = 1

" ref: http://kazy.hatenablog.com/entry/2013/07/18/131118
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#auto_vim_configuration = 0

" 補完開始時に候補を挿入しない
let g:jedi#popup_on_dot = 0

" カーソルが移動するたびに jedi#show_func_def() を呼び出す autocmd が遅いので止める
let g:jedi#show_call_signatures = 0
