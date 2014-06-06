" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Use Underbar Completion
let g:neocomplete#enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#auto_completion_start_length = 3


" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Recommended key-mappings.
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" 上下で補完候補を入力
"inoremap <expr><UP> pumvisible() ? "\<C-p>" : "\<UP>"
"inoremap <expr><DOWN> pumvisible() ? "\<C-n>" : "\<DOWN>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" 全てのファイルタイプにマッチ
if !exists('g:neocomplete#same_filetypes')
    let g:neocomplete#same_filetypes = {}
endif
let g:neocomplete#same_filetypes._ = '_'

" for autoselect
let g:neocomplete#enable_auto_select = 1
" これ有効にしないと auto_select が不安定。ただ、これ有効にすると、neosnippets にて、完全一致の場合に候補に表示されなく鳴る
let g:neocomplete#enable_refresh_always = 1

" others
let g:neocomplete#use_vimproc = 1

