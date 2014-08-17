"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


" Create State
let s:State = transformer#obj('middle')

let s:State.is_range = 0

function! transformer#state#create() "{{{
  " XXX now, 's:State' without private variable, so copy useless.
  return s:State
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: foldmethod=marker
