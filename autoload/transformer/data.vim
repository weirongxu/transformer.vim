"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


" Create State
let s:Data = transformer#obj('data')

let s:Data.is_range = 0

function! transformer#data#create() "{{{
  " XXX now, 's:State' without private variable, so copy useless.
  return s:Data
endfunction "}}}

function! transformer#data#parse_arg(arg, data) "{{{
  " TODO parse arg
  return a:arg
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: fdm=marker
