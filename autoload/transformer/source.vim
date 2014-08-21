"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


" Create Source
let s:Source = transformer#ware('source', [
      \   'func', 'fn',
      \   'exec', 'data',
      \   'sh',
      \   'tmp', 'file',
      \   'reg',
      \   'buf',
      \   'select',
      \   'smart',
      \ ])

function! transformer#source#create() "{{{
  " XXX now, 's:Source' without private variable, so copy useless.
  " return copy(s:Source)
  return s:Source
endfunction "}}}


" Execute Source
function! transformer#source#exec(data) "{{{
  let type = a:data.source.type
  let arg = a:data.source.get_arg()

  if type == 'func'
    " TODO get Interpolation
    exec 'let d=' arg

  elseif type == 'fn'
    exec 'let d=' arg '()'

  elseif type == 'exec'
    " TODO get Interpolation
    exec 'let d=' arg

  elseif type == 'data'
    let d = arg

  elseif type == 'sh'
    let Process = vital#of('transformer').import('Process')
    let d = Process.system(arg)

  elseif type == 'tmp'
    " TODO

  elseif type == 'file'
    " TODO

  elseif type == 'reg'
    let d = getreg(arg)

  elseif type == 'buf'
    let d = transformer#util#buffer(arg)

  elseif type == 'select'
    let d = transformer#util#selected_get()

  elseif type == 'smart'
    return transformer#util#smart#get(a:data)

  else
    throw type." isn't valid source"

  endif
  let a:data.data = d
  return a:data
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: foldmethod=marker
