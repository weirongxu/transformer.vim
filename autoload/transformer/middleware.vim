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
      \   'visual',
      \   'smart',
      \ ])

function! transformer#middleware#create() "{{{
  " XXX now, 's:Middleware' without private variable, so copy useless.
  return s:Middleware
endfunction "}}}


" Execute Middle
function! transformer#middleware#exec(data) "{{{
  let d = has_key(a:data, 'data') ? a:data.data : ''
  let type = a:data.middle.type
  let arg = transformer#data#parse_arg(a:data.middle.get_arg(d), a:data)

  if type == 'pipe'
    let d = transformer#util#pipe(arg, d)

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
    let a:data.fname = fnamemodify(a:data.path, ':t')
    call writefile(split(d, "\n"), a:data.path)

  elseif type == 'file'
    let a:data.path = arg
    let a:data.fname = fnamemodify(a:data.path, ':t')
    call writefile(split(d, "\n"), a:data.path)

  elseif type == 'reg'
    let d = setreg(arg, d)

  elseif type == 'buf'
    let d = transformer#util#buffer(arg, d)

  elseif type == 'visual'
    let d = transformer#util#selected_put(d)

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
