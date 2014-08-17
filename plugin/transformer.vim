if !exists('g:transformer#cache_dir')
  let g:transformer#cache_dir = expand("~/.cache/transformer")
endif
if !exists('g:transformer#pipe_dir')
  let g:transformer#pipe_dir = expand("~/.cache/transformer/pipe")
endif
if !exists('g:transformer#tmp_dir')
  let g:transformer#tmp_dir = expand("~/.cache/transformer/tmp")
endif
call transformer#util#check_cache_dir(g:transformer#cache_dir)
call transformer#util#check_cache_dir(g:transformer#pipe_dir)
call transformer#util#check_cache_dir(g:transformer#tmp_dir)
