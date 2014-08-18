"=============================================================================
" FILE: transformer.vim
" AUTHOR:  WeiRong Xu <weirongxu.raidou@gmail.com>
" License: MIT license
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


let s:pwd_path = expand("<sfile>:p:h")
let s:Process = vital#of('transformer').import('Process')

function! transformer#util#pipe#run(cmd, cont) "{{{
  if has('python')
    return s:python(a:cmd, a:cont)
  elseif s:Process.has_vimproc()
    return s:Process.system(a:cmd, a:cont)
  elseif executable('cat') && executable('sh')
    return s:cache_decorator(a:cont, 'cat', a:cmd)
  elseif executable('node')
    return s:cache_decorator(a:cont, 'node', a:cmd, 'node')
  elseif executable('nodejs')
    return s:cache_decorator(a:cont, 'node', a:cmd, 'nodejs')
  endif
endfunction "}}}

function! s:python(cmd, cont) "{{{
  let cmd = a:cmd
  let cont = a:cont
  py import subprocess, vim
  py cmd = vim.eval('cmd')
  py cont = vim.eval('cont')
  py p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stdin=subprocess.PIPE)
  py out, err = p.communicate(input=cont)
  " TODO log err
  py vim.command("let ret='{}'".format(out.replace("'", "''")))
  return ret
endfunction "}}}

function! s:cat(cmd) "{{{
  return s:Process.system('cat pipe | '.a:cmd)
endfunction "}}}

function! s:node(cmd, node) "{{{
  return s:Process.system(a:node.' '.s:pwd_path.'/pipe/pipe.js pipe '.a:cmd)
endfunction "}}}

function! s:cache_decorator(cont, func, ...) "{{{
  call writefile(split(a:cont, '\n'), g:transformer#pipe_dir.'/pipe')
  let o_pwd = getcwd()
  execute "cd " . g:transformer#pipe_dir
  let ret = call ('s:'.a:func, a:000)
  execute "cd " . o_pwd
  return ret
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: foldmethod=marker
