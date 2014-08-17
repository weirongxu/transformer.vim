function! transformer#tf#cmd(cmd)
  let tf = s:TF
  let tf.arg = a:cmd
  let tf.type = 'cmd'
  return deepcopy(tf)
endfunction


function! transformer#tf#map(map)
  let tf = s:TF
  let tf.arg = a:map
  let tf.type = 'map'
  return deepcopy(tf)
endfunction


let s:TF = {}
let s:TFlist = {}
let s:TFidentity = 1


function! s:TF.subcmd(scmd, ...)
  " TODO
  " return transformer#subcmd#new(a:scmd, a:000)
endfunction


function! s:TF.src(src)
  let self.source = a:src
  return self
endfunction


let s:TF.is_activate = 0
let s:TF.middle = []


function! s:TF.exec(...)
  if transformer#util#type(a:1) == 'source'
    let self.source = a:1
    let self.middle = self.middle + a:000[1:]
  else
    let self.middle = self.middle + a:000
  endif
  call s:activate(self)
  let self.is_activate = 1
  return self
endfunction


function! s:activate(tf)
  let len = len(s:TFlist)
  let s:TFlist[s:TFidentity] = a:tf
  let arg = a:tf.arg
  if a:tf.type == 'cmd'
    execute 'command! -range=0 -count' arg 'call <SID>execute('.s:TFidentity.', <count>)'
  elseif a:tf.type == 'map'
    execute 'nnoremap <silent>' arg ':<C-u>call <SID>execute('.s:TFidentity.', 0)<CR>'
    execute 'vnoremap <silent>' arg ':<C-u>call <SID>execute('.s:TFidentity.', 1)<CR>'
    " TODO register map
  endif
  let s:TFidentity = s:TFidentity + 1
endfunction


function! s:execute(idx, is_range)
  let state = transformer#state()
  let state.is_range = a:is_range

  let tf = s:TFlist[a:idx]
  let source = tf.source

  let data = transformer#source#exec(source, state)
  for m in tf.middle
    if transformer#util#type(m) == 'source'
      let data = transformer#source#exec(m, state)
    else
      let data = transformer#middleware#exec(m, data, state)
    endif
  endfor
endfunction
