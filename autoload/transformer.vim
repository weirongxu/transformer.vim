"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


function! transformer#cmd(cmd)
  return transformer#tf#cmd(a:cmd)
endfunction

function! transformer#map(map)
  return transformer#tf#map(a:map)
endfunction

function! transformer#source()
  return transformer#source#create()
endfunction

function! transformer#middle()
  return transformer#middleware#create()
endfunction

function! transformer#state()
  return transformer#state#create()
endfunction

function! transformer#obj(type) "{{{
  return {'_type': a:type}
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: foldmethod=marker
