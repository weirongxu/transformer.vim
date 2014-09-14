"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


function! transformer#util#buffer#get(arg) "{{{
  let arg = a:arg
  if arg == '%'
    " M.buf('%')
    return join(getline('^', '$'), "\n")
  elseif arg =~? '\v^\%(\d+|[\.\^\$])'
    " M.buf('%2')
    let line = matchstr(arg, '\v^\%\zs(\d+|[\.\^\$])\ze')
    return join(getline(line), "\n")
  endif
endfunction "}}}

function! transformer#util#buffer#put(arg, data) "{{{
  let arg = a:arg
  let data = a:data

  if arg == '%'
    " M.buf('%')
    %d
    call setline(1, split(data, "\n"))
  elseif arg =~? '\v^\%(\d+|[\$\.\^])'
    " M.buf('%2')
    let line = matchstr(arg, '\v^\%\zs(\d+|[\.\^\$])\ze')
    call setline(line, split(data, "\n"))
  elseif arg =~? '\v^n[svudlr]?(\d+)?\&?$'
    " 'n', 'n&', 'nv5', 'vs5', 'nu4', 'nd4', 'nl4', 'nr4'
    let m = matchlist(arg, '\v^n([svudlr])?(\d+)?\&?$')
    let cmd =
          \ (m[1] == 's') ? '%s split' :
          \ (m[1] == 'v') ? 'vertical %s split' :
          \ (m[1] == 'l') ? 'topleft vertical %s split' :
          \ (m[1] == 'r') ? 'topright vertical %s split' :
          \ (m[1] == 'd') ? 'botright %s split' :
          \ (m[1] == 'u') ? 'topright %s split' :
          \ 'new'
    let cmd = printf(cmd, m[2] ? m[2] : 5)
    if arg[len(arg)-1:] == '&'
      let curr_winnr = bufwinnr('%')
      call s:new_buffer(cmd, data)
      exec curr_winnr 'wincmd w'
    else
      call s:new_buffer(cmd, data)
    endif
  endif
  return data
endfunction "}}}

function! s:new_buffer(cmd, data, ...) "{{{
  let name = a:0 == 0 || empty(a:1) ?
        \ '__TEXT_TRANSFORMER__' : a:1
  exec "silent" a:cmd name
  setlocal buftype=nofile bufhidden=wipe noswapfile
  nnoremap <silent> <buffer> q :bw!<cr>
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: fdm=marker
