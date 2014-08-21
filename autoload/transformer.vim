"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


function! transformer#cmd(cmd) "{{{
  return transformer#tf#cmd(a:cmd)
endfunction "}}}

function! transformer#map(map) "{{{
  return transformer#tf#map(a:map)
endfunction "}}}

function! transformer#source() "{{{
  return transformer#source#create()
endfunction "}}}

function! transformer#middle() "{{{
  return transformer#middleware#create()
endfunction "}}}

function! transformer#data() "{{{
  return transformer#data#create()
endfunction "}}}

function! transformer#obj(type) "{{{
  return {'_type': a:type}
endfunction "}}}

function! transformer#ware(type, members) "{{{
  let obj = transformer#obj(a:type)

  for m in a:members
    execute join([
          \ 'function! obj.'. m ."(...)",
          \ '  let s = copy(self)',
          \ '  let s.type = "'. m .'"',
          \ '  let s.args = a:000',
          \ '  return s',
          \ 'endfunction',
          \ ], "\n")
  endfor

  function! obj.get_arg(...) "{{{
    return len(self.args) > 0 ? self.args[0] :
          \ a:0 > 0 ? a:1 :
          \ ''
  endfunction "}}}

  return obj
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: foldmethod=marker
