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
  let d = has_key(a:data, 'data') ? a:data.data : ''
  let type = a:data.source.type
  let arg = transformer#data#parse_arg(a:data.source.get_arg(), a:data)

  if type == 'func'
    exec 'let d=' arg

  elseif type == 'fn'
    exec 'let d=' arg '()'

  elseif type == 'exec'
    exec 'let d=' arg

  elseif type == 'data'
    let d = arg

  elseif type == 'sh'
    let Process = vital#of('transformer').import('Process')
    let d = Process.system(arg)

  elseif type == 'tmp'
    let a:data.path = g:transformer#tmp_dir.'/'.arg
    let a:data.fname = fnamemodify(a:data.path, ':t')
    if filereadable(a:data.path)
      let d = join(readfile(a:data.path), "\n")
    else
      let d = ''
    endif

  elseif type == 'file'
    let a:data.path = arg
    let a:data.fname = fnamemodify(a:data.path, ':t')
    if filereadable(a:data.path)
      let d = join(readfile(a:data.path), "\n")
    else
      let d = ''
    endif

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
  let a:data.arg = arg
  return a:data
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: fdm=marker
