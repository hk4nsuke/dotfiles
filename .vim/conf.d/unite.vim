" 起動時にインサートモードで開始
let g:unite_enable_start_insert = 1

" ignorecase (!smartcase)
call unite#set_profile('default', 'ignorecase', 1)
call unite#set_profile('default', 'smartcase', 0)

" 左上に表示
"let g:unite_split_rule = "botright"
let g:unite_split_rule = "topleft"


" unite.vim へのキーマッピング
"cnoremap <silent> fm<CR> <C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
cnoremap <silent> fp<CR> <C-u>Unite bookmark<CR>
cnoremap <silent> ff<CR> <C-u>Unite file<CR>
cnoremap <silent> fm<CR> <C-u>Unite file_mru<CR>
cnoremap <silent> fb<CR> <C-u>Unite buffer<CR>
cnoremap <silent> fr<CR> <C-u>Unite register<CR>
cnoremap <silent> fl<CR> <C-u>Unite locate<CR>
cnoremap <silent> fg<CR> <C-u>Unite vcs_grep -no-quit<CR>

nnoremap <C-f> :Unite gtags/def<CR>
nnoremap <C-g> :Unite gtags/ref -no-quit<CR>

" unite.vim 上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    " 単語単位からパス単位で削除するように変更
    imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
    "" 分割オープン
    "nmap <leader>h :call unite#mappings#do_action('left')<CR>
    "nmap <leader>l :call unite#mappings#do_action('right')<CR>
    "nmap <leader>k :call unite#mappings#do_action('above')<CR>
    "nmap <leader>j :call unite#mappings#do_action('below')<CR>
    "" unite バッファを維持してオープン
    "nmap <leader>p :call unite#mappings#do_action('persist_open')<CR>
    "" <leader>c で選択中のファイル、ディレクトリを tmux の新規ウィンドウで開く
    "nmap <leader>c :call unite#mappings#do_action('tmux_window')<CR>
    "" <leader>s で選択中のファイル、ディレクトリを tmux の新規ペインで開く
    "nmap <leader>s :call unite#mappings#do_action('tmux_split')<CR>
endfunction

" 最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 1000

" 高速化
" file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''"

" unite-grep のバックエンドを ag に切り換える
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200

