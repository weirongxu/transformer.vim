" Create Middle
let s:Middleware = transformer#obj('middle')

let s:middleware_type = [
      \   'pipe',
      \   'func', 'fn',
      \   'exec', 'data', 'null',
      \   'sh',
      \   'tmp', 'file',
      \   'reg',
      \   'buf',
      \   'select',
      \   'smart',
      \ ]

for type in s:middleware_type
  execute join([
        \ 'function! s:Middleware.'. type ."(...)",
        \ '  let m = copy(self)',
        \ '  let m.type = "'. type .'"',
        \ '  let m.args = a:000',
        \ '  return m',
        \ 'endfunction',
        \ ], "\n")
endfor


function! s:Middleware.get_arg(...) "{{{
  return len(self.args) > 0 ? self.args[0] :
        \ a:0 > 0 ? a:1 :
        \ ''
endfunction "}}}


function! transformer#middleware#create()
  " XXX now, 's:Middleware' without private variable, so copy useless.
  return s:Middleware
endfunction


" Execute Middle
function! transformer#middleware#exec(m, data, state)
  let data = a:data
  let type = a:m.type
  let arg = a:m.get_arg(data)

  if type == 'pipe'
    let ret = transformer#util#pipe(arg, data)

  elseif type == 'func'
    " TODO get Interpolation
    exec 'let ret=' arg

  elseif type == 'fn'
    " TODO get Interpolation
    exec 'let ret=' arg '()'

  elseif type == 'exec'
    " TODO get Interpolation
    exec 'let ret=' arg

  elseif type == 'data'
    let ret = arg

  elseif type == 'null'
    throw "Null Middle Unknown Error"

  elseif type == 'sh'
    " TODO get Interpolation
    let ret = system(arg)

  elseif type == 'tmp'
    " TODO

  elseif type == 'file'
    " TODO

  elseif type == 'reg'
    let ret = getreg(arg)

  elseif type == 'buf'
    let ret = transformer#util#buffer(arg, data)

  elseif type == 'select'
    " TODO
    "
  elseif type == 'smart'
    let ret = transformer#util#smart(a:state, a:data)

  else
    throw type." isn't valid middleware"

  endif
  return ret
endfunction
