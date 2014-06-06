" 選択を行わないウィンドウ番号をフィルタリングする関数
function! s:choosewin_is_ignore_window(action, winnr)
    if a:action ==# "open"
        return index(["unite", "vimfiler", "vimshell"], getbufvar(winbufnr(a:winnr), "&filetype")) >= 0
    else
        return 0
    endif
endfunction
let g:Unite_kinds_choosewin_is_ignore_window_func = function("s:choosewin_is_ignore_window")
