"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


" Create Middle
let s:Middleware = transformer#ware('middle', [
      \   'pipe',
      \   'func', 'fn',
      \   'exec', 'data', 'null',
      \   'sh',
      \   'tmp', 'file',
      \   'reg',
      \   'buf',
      \   'select',
      \   'smart',
      \ ])

function! transformer#middleware#create() "{{{
  " XXX now, 's:Middleware' without private variable, so copy useless.
  return s:Middleware
endfunction "}}}


" Execute Middle
function! transformer#middleware#exec(data) "{{{
  let data = a:data.data
  let type = a:data.middle.type
  let arg = transformer#data#parse_arg(a:data.middle.get_arg(data), a:data)

  if type == 'pipe'
    let d = transformer#util#pipe(arg, data)

  elseif type == 'func'
    exec 'let d=' arg

  elseif type == 'fn'
    exec 'let d=' arg '()'

  elseif type == 'exec'
    exec 'let d=' arg

  elseif type == 'data'
    let d = arg

  elseif type == 'null'
    throw "Null Middle Unknown Error"

  elseif type == 'sh'
    let Process = vital#of('transformer').import('Process')
    let d = Process.system(arg)

  elseif type == 'tmp'
    let a:data.path = g:transformer#tmp_dir.'/'.arg
    let d = join(readfile(a:data.path), "\n")

  elseif type == 'file'
    let d = join(readfile(arg), "\n")
    let a:data.fname =
    let a:data.file = 'file'

  elseif type == 'reg'
    let d = getreg(arg)

  elseif type == 'buf'
    let d = transformer#util#buffer(arg, data)

  elseif type == 'select'
    let d = transformer#util#selected_put(data)

  elseif type == 'smart'
    return transformer#util#smart#put(a:data)

  else
    throw type." isn't valid middleware"

  endif
  let a:data.data = d
  let a:data.arg = arg
  return a:data
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: fdm=marker
