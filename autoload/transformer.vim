let s:save_cpo = &cpo
set cpo&vim

let s:TF = {}
let s:TFlist = []

function! s:TF.subcmd(scmd, ...)
  " TODO
  return transformer#subcmd#new(a:scmd, a:000)
endfunction

" function! s:TF.exec(scmd, ...)
"   return transformer#subcmd#new(a:scmd, a:000)
" endfunction

function! s:TF.exec(data, mw)
  if type(a:mw) == 1
    if !has_key(self, 'middleType')
      throw "Transformer without default middle type."
    elseif !has_key(self, 'middleOut')
      throw "Transformer without default out way from middle."
    else
      call s:activate(self)
    endif
  endif
" call tf.exec('*hello*', 'md2html,marked').dest(M.reg('"'))
endfunction

function! s:TF.dest(middle)
endfunction

function! s:activate(tf)
  let len = len(s:TFlist)
  call add(s:TFlist, a:tf)
  execute "command!" a:tf.cmd "call <SID>execute(" len ")"
endfunction

function! s:execute(idx)
  " let g:TFlist = s:TFlist
  call transformer#execute#run(s:TFlist[a:idx])
  " g:TFlist = s:TFlist[a:idx]
endfunction

function! transformer#cmd(cmd, ...)
  if a:0 == 0
    let tf = s:TF
    let tf.cmd = a:cmd
    let tf.type = 'cmd'
    return deepcopy(tf)
  else
    let t = type(a:000[0])
    if t == 3 || t == 1
      let middles = a:000[0]
    elseif t == 4
      let middles = a:000
    endif
    return 1
  endif
endfunction


function! transformer#middle()
  return transformer#middleware#create()
endfunction


let &cpo = s:save_cpo
