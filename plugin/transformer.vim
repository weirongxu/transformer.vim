"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


if !exists('g:transformer#cache_dir')
  let g:transformer#cache_dir = expand("~/.cache/transformer-vim")
endif
if !exists('g:transformer#pipe_dir')
  let g:transformer#pipe_dir = g:transformer#cache_dir."/pipe"
endif
if !exists('g:transformer#tmp_dir')
  let g:transformer#tmp_dir = g:transformer#cache_dir."/tmp"
endif

function! s:create_dir(dir) "{{{
  if !isdirectory(a:dir)
    call mkdir(a:dir, "p")
  endif
endfunction "}}}

call s:create_dir(g:transformer#cache_dir)
call s:create_dir(g:transformer#pipe_dir)
call s:create_dir(g:transformer#tmp_dir)


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: fdm=marker
