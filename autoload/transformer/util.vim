"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


let s:V = vital#of('transformer')

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
  " return s:V.import('Vim.Buffer').get_selected_text()
  let save_z = getreg('z', 1)
  let save_z_type = getregtype('z')

  try
    silent normal! gv"zy
    return @z
  finally
    call setreg('z', save_z, save_z_type)
  endtry
endfunction "}}}


function! transformer#util#selected_put(data) "{{{
  " TODO
  " return s:V.import('Vim.Buffer').put_selected_text()
  let save_z = getreg('z', 1)
  let save_z_type = getregtype('z')
  call setreg('z', a:data, save_z_type)

  try
    silent normal! gv"zp
    return @z
  finally
    call setreg('z', save_z, save_z_type)
  endtry
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: foldmethod=marker
