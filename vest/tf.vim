" Tests for transformer.

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

Context Vesting.run()
  It create command
    let c1 = transformer#cmd('test1')
    let c2 = transformer#cmd('test2')
    Should c1.cmd == 'test1'
    Should c2.cmd == 'test2'
  End

  It middle
    let M = transformer#middle()
    let pipe = M.pipe()
    Should pipe.type == ''
    Should c2.cmd == 'test2'
  End

  " P {'hoge'}

  " throw 'hoge'
End

Fin

let &cpo = s:save_cpo
