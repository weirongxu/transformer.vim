"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


" Smart Get
function! transformer#util#smart#get(state) "{{{
  if a:state.is_range
    return transformer#util#selected_get()
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
    let a:state.smart = src
    return transformer#source#exec(src, a:state)
  endif
endfunction "}}}


function! s:source(c) "{{{
  let S = transformer#source#create()
  return
        \ a:c == '%' ? S.buf('%') :
        \ a:c == 'b' ? S.buf('%'.input('Input buffer line number: ')) :
        \ a:c == 's' ? S.data(input('Input string: ')) :
        \ a:c == 'v' ? S.exec(input('Input vimscript: ', '', 'expression')) :
        \ a:c == '$' ? S.sh(input('Input shell command: ', '', 'shellcmd')) :
        \ a:c == 'f' ? S.file(input('Input file path', extend('%:p:r'), 'file')) :
        \ a:c == 'r' ? s:getchar('Input register name') :
        \ s:source(a:c)
endfunction "}}}


" Smart Put
function! transformer#util#smart#put(state, data) "{{{
  if a:state.is_range
    return transformer#util#selected_put(a:data)
  elseif a:state.smart.type == 'buf'
    let mid = s:buf_src2mid(a:state.smart)
    return transformer#middleware#exec(mid, a:data, a:state)
  else
    let mid = s:buf_src2mid(a:state.smart)
  endif
endfunction "}}}


function! s:buf_src2mid(src) "{{{
  let M = transformer#middleware#create()
  let arg = a:src.get_arg('%')
  return M.buf(arg)
endfunction "}}}


function! s:getchar(msg) "{{{
  " FIXME not have to user press entry quit.
  echo a:msg
  return nr2char(getchar())
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: foldmethod=marker
