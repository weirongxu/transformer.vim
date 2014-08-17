let s:pwd_path = expand("<sfile>:p:h")

function! transformer#util#pipe#run(cmd, cont) "{{{
  " XXX 查看一下quickrun的源码. 学习一下运行方式, 使用无缓存文件运行.
  " let cont = substitute(a:cont, '\v\"', '\\\"', 'g')
  " XXX if executable('cat') executable('sh') use sh cat |
  " support shell, vimproc, nodejs, python
  call writefile(split(a:cont, '\n'), g:transformer#pipe_dir.'/pipe')
  let o_pwd = getcwd()
  execute "cd " . g:transformer#pipe_dir
  let ret = system('node '.s:pwd_path.'/pipe/pipe.js pipe '.a:cmd)
  execute "cd " . o_pwd
  return ret
endfunction "}}}
