"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


function! transformer#tf#cmd(cmd) "{{{
  let tf = s:TF
  let tf.arg = a:cmd
  let tf.type = 'cmd'
  return deepcopy(tf)
endfunction "}}}


function! transformer#tf#map(map) "{{{
  let tf = s:TF
  let tf.arg = a:map
  let tf.type = 'map'
  return deepcopy(tf)
endfunction "}}}


let s:TF = {}
let s:TFlist = {}
let s:TFidentity = 1


function! s:TF.subcmd(scmd, ...) "{{{
  " TODO
  " return transformer#subcmd#new(a:scmd, a:000)
endfunction "}}}


" TODO deprecated
function! s:TF.src(src) "{{{
  let self.source = a:src
  return self
endfunction "}}}


let s:TF.is_activate = 0
let s:TF.middle = []


function! s:TF.stream(...) "{{{
  if transformer#util#type(a:1) == 'source'
    let self.source = a:1
    let self.middle = self.middle + a:000[1:]
  else
    let self.middle = self.middle + a:000
  endif
  if !self.is_activate
    call s:activate(self)
    let self.is_activate = 1
  endif
  return self
endfunction "}}}


function! s:activate(tf) "{{{
  let len = len(s:TFlist)
  let s:TFlist[s:TFidentity] = a:tf
  let arg = a:tf.arg
  if a:tf.type == 'cmd'
    execute 'command! -range=0 -count' arg 'call <SID>execute('.s:TFidentity.', <count>, 0)'
  elseif a:tf.type == 'map'
    execute 'nnoremap <silent>   '.arg.' :<C-u>call <SID>execute('.s:TFidentity.', 0, 0)<CR>'
    execute 'nnoremap <silent> ""'.arg.' :<C-u>call <SID>execute('.s:TFidentity.', 0, 1)<CR>'
    execute 'vnoremap <silent>   '.arg.' :<C-u>call <SID>execute('.s:TFidentity.', 1, 0)<CR>'
  endif
  let s:TFidentity = s:TFidentity + 1
endfunction "}}}


function! s:execute(idx, is_range, unnamed_reg) "{{{
  let S = transformer#source()

  let data = transformer#data()
  let data.is_range = a:is_range

  let tf = s:TFlist[a:idx]
  if a:unnamed_reg || v:register != '"'
    let data.source = S.reg(v:register)
  else
    let data.source = tf.source
  endif

  call s:execute_loop(data, tf)
endfunction "}}}


function! s:execute_loop(data, tf) "{{{
  let data = transformer#source#exec(a:data)
  for m in a:tf.middle
    if transformer#util#type(m) == 'source'
      let data.source = m
      let data = transformer#source#exec(data)
    else
      let data.middle = m
      let data = transformer#middleware#exec(data)
    endif
  endfor
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: fdm=marker
