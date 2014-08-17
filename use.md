# Usage

    let tf = transformer#map("\<c-r>")
    let tf = transformer#map("\<Plug>hello")
    let tf = transformer#cmd("Trans")
    let M = transformer#source()
    let M = transformer#middle()

    call tf.in('reg')

    call tf.middleType('pipe')
    call tf.middleOut('cmd')

    call tf.exec('*hello*', 'md2html,marked').dest(M.reg('"'))

    " 'md2html,marked' 这个不太好。

    call tf.subcmd("coffee-press", [M.p('coffee'), M.p('uglify')])

    call tf.subcmd({
        \   'jade': 'jade --pretty',
        \   'hmtl2jade': 'html2jade - --donotencode --bodyless',
        \   'haml': 'haml -s',
        \   'html2haml': 'html2haml -s',
        \   'slim': 'slimrb -sp',
        \   'html2slim': 'html2slim',
        \   'markdown': 'md2html,marked',
        \   'coffee': 'coffee -spcb --no-header',
        \   'js2coffee': 'js2coffee',
        \   'livescript': 'livescript -spcb',
        \   'styl': 'stylus',
        \   'css2styl': [M.tmp('tmp.css'), M.sh('css2stylus @{tmp}.css').out(M.tmp('tmp.styl'))],
        \   'less': 'lessc -',
        \   'sass': 'sass -s',
        \   'scss': 'sass -sq --scss'
        \ }, 'cmd', 'pipe').dest(M.reg('"'))

    call tf.subcmd({
        \   'text2iso': [M.func('transformer#stdlib#text2iso(@{data})')]
        \ })

    tf.subcmd({object}, middleOut, middleType)

    call transformer#cmd("Pwd", M.func('expand("%:p")'))

    let tf = transformer#cmd('TF')
    let util = transformer#util()
    call tf.subcmd('jade')
        \ .src(util.buf('%'))
        \ .do(util.pipe('jade --pretty')).out(util.sh())
        \ .dest(util.src())

    \   'css2styl': [M.tmp('tmp.css'), M.sh('css2stylus @{tmp}.css').out(M.tmp('tmp.styl'))],
    call tf.subcmd('css2styl')
        \ .src(util.buf('%'))

