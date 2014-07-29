let s:MiddleWare = {}

let s:middleware_type = [
      \   'pipe',
      \   'func', 'fn',
      \   'exec', 'set',
      \   'sh',
      \   'tmp', 'file',
      \   'reg',
      \   'buf', 'newbuf',
      \   'select'
      \ ]

for type in s:middleware_type
  execute join([
        \ 'function! s:MiddleWare.'. type ."(...)",
        \ '  let m = copy(self)',
        \ '  let m.type = "'. type .'"',
        \ '  let m.action = a:000',
        \ '  return m',
        \ 'endfunction',
        \ ], "\n")
  " function! s:MiddleWare.pipe(...)
  "   let m = copy(self)
  "   let m.type = 'pipe'
  "   let m.action = a:000
  "   return m
  " endfunction
endfor

function! s:MiddleWare.out(m)
  let self.out_type = a:m.type
  return self
endfunction

function! transformer#middleware#create()
  " XXX now, 's:MiddleWare' without private variable, so copy useless.
  " return copy(s:MiddleWare)
  return s:MiddleWare
endfunction
