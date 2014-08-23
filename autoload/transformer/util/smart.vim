"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


let s:S = transformer#source#create()
let s:M = transformer#middleware#create()

" Smart Get
function! transformer#util#smart#get(data) "{{{
  if a:data.is_range
    let src = s:S.select()
  else
    let c = s:getchar(join([
          \  'Get data from:',
          \  '  %: whole buffer',
          \  '  b: buffer',
          \  '  s: string',
          \  '  v: vimscript',
          \  '  $: shell',
          \  '  f: file',
          \  '  r: register',
          \  '> Select: ',
          \], "\n"))
    let src = s:source(c)
  endif
  let a:data.smart_src = src
  let a:data.source = src
  return transformer#source#exec(a:data)
endfunction "}}}


function! s:source(c) "{{{
  return
        \ a:c == '%' ? s:S.buf('%') :
        \ a:c == 'b' ? s:S.buf('%'.input('Input buffer line number: ')) :
        \ a:c == 's' ? s:S.data(input('Input string: ')) :
        \ a:c == 'v' ? s:S.exec(input('Input vimscript: ', '', 'expression')) :
        \ a:c == '$' ? s:S.sh(input('Input shell command: ', '', 'shellcmd')) :
        \ a:c == 'f' ? s:S.file(input('Input file path', extend('%:p:r'), 'file')) :
        \ a:c == 'r' ? s:S.reg(s:getchar('Input register name')) :
        \ s:source(a:c)
endfunction "}}}


" Smart Put
function! transformer#util#smart#put(data) "{{{
  if a:data.is_range
    let mid = s:M.select()
  elseif a:data.smart_src.type == 'buf'
    let mid = s:buf_src2mid(a:data.smart_src)
  else
    " XXX
    let mid = s:src2mid(a:data.smart_src)
  endif
  let a:data.middle = mid
  return transformer#middleware#exec(a:data)
endfunction "}}}


function! s:buf_src2mid(src) "{{{
  let arg = a:src.get_arg('%')
  if arg =~? '\v^\%(\d+|[\.\^]),(\d+|[\.\$])'
    let line = matchstr(arg, '\v^\%\zs(\d+|[\.\^])\ze,(\d+|[\.\$])')
    let arg = '%'.line
  endif
  return s:M.buf(arg)
endfunction "}}}

function! s:src2mid(src) "{{{
  " XXX this is hack, it's changed source object.
  src._type = 'middleware'
  return src
endfunction "}}}


function! s:getchar(msg) "{{{
  " FIXME not have to user press entry quit.
  try
    echo a:msg
    return nr2char(getchar())
  finally
  endtry
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: fdm=marker
