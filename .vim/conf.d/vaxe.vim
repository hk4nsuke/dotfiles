"set autogroup
augroup MyAutoCmdVaxe
  autocmd!
augroup END

" vaxeの動作にはautowriteを有効にする必要がある
autocmd MyAutoCmdVaxe FileType haxe
      \ setl autowrite
autocmd MyAutoCmdVaxe FileType hxml
      \ setl autowrite
autocmd MyAutoCmdVaxe FileType nmml.xml
      \ setl autowrite

let g:vaxe_haxe_version = 3

" 以下はNeocomplete用
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.haxe = '\v([\]''"\)]|\w|(^\s*))(\.|\()'
