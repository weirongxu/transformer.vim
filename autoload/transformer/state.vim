" Create State
let s:State = transformer#obj('middle')

let s:State.is_range = 0

function! transformer#state#create() "{{{
  " XXX now, 's:State' without private variable, so copy useless.
  return s:State
endfunction "}}}
