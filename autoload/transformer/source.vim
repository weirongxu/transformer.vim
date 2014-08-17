"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


" Create Source
let s:Source = {}

let s:source_type = [
      \   'func', 'fn',
      \   'exec', 'data',
      \   'sh',
      \   'tmp', 'file',
      \   'reg',
      \   'buf',
      \   'select',
      \   'smart',
      \ ]

let s:Source._type = 'source'

for type in s:source_type
  execute join([
        \ 'function! s:Source.'. type ."(...)",
        \ '  let s = copy(self)',
        \ '  let s.type = "'. type .'"',
        \ '  let s.args = a:000',
        \ '  return s',
        \ 'endfunction',
        \ ], "\n")
endfor


function! s:Source.get_arg(...) "{{{
  return len(self.args) > 0 ? self.args[0] :
        \ a:0 > 0 ? a:1 :
        \ ''
endfunction "}}}


function! transformer#source#create() "{{{
  " XXX now, 's:Source' without private variable, so copy useless.
  " return copy(s:Source)
  return s:Source
endfunction "}}}


" Execute Source
function! transformer#source#exec(s, state) "{{{
  let type = a:s.type
  let arg = a:s.get_arg()

  if type == 'func'
    " TODO get Interpolation
    exec 'let ret=' arg

  elseif type == 'fn'
    exec 'let ret=' arg '()'

  elseif type == 'exec'
    " TODO get Interpolation
    exec 'let ret=' arg

  elseif type == 'data'
    let ret = arg

  elseif type == 'sh'
    let ret = system(arg)

  elseif type == 'tmp'
    " TODO

  elseif type == 'file'
    " TODO

  elseif type == 'reg'
    let ret = getreg(arg)

  elseif type == 'buf'
    let ret = transformer#util#buffer(arg)

  elseif type == 'select'
    " TODO

  elseif type == 'smart'
    let ret = transformer#util#smart(a:state)

  else
    throw type." isn't valid source"

  endif
  return ret
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: foldmethod=marker
