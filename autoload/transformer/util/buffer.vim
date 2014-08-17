function! transformer#util#buffer#get(arg) "{{{
  let arg = a:arg
  if arg == '%'
    return join(getline('^', '$'), "\n")
  elseif arg =~? '\v^\%(\d+|[\.\^\$])'
    let line = matchstr(arg, '\v^\%\zs(\d+|[\.\^\$])\ze')
    return join(getline(line), "\n")
  endif
endfunction "}}}

function! transformer#util#buffer#put(arg, data) "{{{
  let arg = a:arg
  let data = a:data

  if arg == '%'
    %d
    call setline(1, split(data, "\n"))
  elseif arg =~? '\v^\%(\d+|[\$\.\^])'
    let line = matchstr(arg, '\v^\%\zs(\d+|[\.\^\$])\ze')
    call setline(line, split(data, "\n"))
  endif
  " TODO
  " let self.matchs_name = matchstr(a:target, '\v^buffer-new(-[lrud])? \zs.{}')
  " let self.matchs_pos = matchstr(a:target, '\v^buffer-new(-\zs[lrud]\ze)')
  " let self.matchs_num = matchstr(a:target, '\v^buffer-new(-[lrud]\zs\d{}\ze)')
  return data
endfunction "}}}

" function! s:Target.trigger_buffer_new(cont)
"   let name = empty(self.matchs_name) ?
"         \ '__TEXT_SHIFT__' : self.matchs_name
"   let pos =
"         \ (self.matchs_pos == 'l') ? 'topleft vertical %s split' :
"         \ (self.matchs_pos == 'r') ? 'topright vertical %s split' :
"         \ (self.matchs_pos == 'd') ? 'botright %s split' :
"         \ (self.matchs_pos == 'u') ? 'topright %s split' :
"         \ 'new'
"   exec "silent ".printf(pos, self.matchs_num)." ".name
"   setlocal buftype=nofile bufhidden=wipe noswapfile
"   nnoremap <silent> <buffer> q :bw!<cr>
"   call setline(1, split(a:cont, '\n'))
" endfunction
"
" function! s:Target.trigger_visual(cont)
"   call setreg(reg,out,reg_type)
"   silent exe 'norm! gv"'.reg.'p'
"   call setreg(reg,reg_save,reg_type)
" endfunction
