"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


function! transformer#util#pipe(cmd, cont) "{{{
  return transformer#util#pipe#run(a:cmd, a:cont)
endfunction "}}}


function! transformer#util#buffer(arg, ...) "{{{
  if a:0 > 0
    return transformer#util#buffer#put(a:arg, a:1)
  else
    return transformer#util#buffer#get(a:arg)
  endif
endfunction "}}}


function! transformer#util#smart(is_range, ...) "{{{
  if a:0 > 0
    return transformer#util#smart#put(a:is_range, a:1)
  else
    return transformer#util#smart#get(a:is_range)
  endif
endfunction "}}}


function! transformer#util#check_cache_dir(dir) "{{{
  if !isdirectory(a:dir)
    call mkdir(a:dir, "p")
  endif
endfunction "}}}


function! transformer#util#type(obj) "{{{
  if has_key(a:obj, '_type')
    return a:obj._type
  else
    return type(a:obj)
  endif
endfunction "}}}


" Selected Handle
function! transformer#util#selected_get() "{{{
  " XXX this is hack, It will changed register 0~1
  let save_z = getreg('"', 1)
  let save_z_type = getregtype('"')

  try
    silent normal! gvy
    return @"
  finally
    call setreg('"', save_z, save_z_type)
  endtry
endfunction "}}}


function! transformer#util#selected_put(data) "{{{
  " XXX this is hack, It will changed register 0~1
  let save_z = getreg('"', 1)
  let save_z_type = getregtype('"')
  call setreg('"', a:data, save_z_type)

  try
    silent normal! gvp
  finally
    call setreg('"', save_z, save_z_type)
  endtry
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: foldmethod=marker
