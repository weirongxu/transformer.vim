Transformer.vim
===============

Ctrl
----

    pre-cmd
    pre-key[def]
    sub-cmd
    [sub-key]

Limit
-----

    filetype
    buffer-name

Auto
----

    Watch

Pipe
----

### Start

#### :TF -auto
    in: select next key
        b: buffer
        c: command -> input command
        f: file -> input file path
        ii: input
        il: inputlist
        id: inputdialog
        ic: confirm
        ig: getchar
#### :TF -buffer
    in: from whole buffer
        If set tf.in(), middle will read in data from tf.in()
        Example:
            let tf = transformer#cmd("Trans")
            let M = transformer#middle()
            call tf.in(M.buf(%:.))
            " current line
    out: Replacing whole buffer

#### Visual :TF
    in: From select content
    out: Replacing original select content

#### :TF -cmd
    in: Let user input cmd, then get data by command return.
    out: vim echo

#### :TF -file [file path]
    in: input file path by user.
        Let user input file path if no have path in arguments.
    out: vim echo

#### :TF -input
#### :TF -inputlist
#### :TF -inputdialog
#### :TF -inputsecret
#### :TF -confirm
#### :TF -getchar
    in: Let user input string
        or select
    out: vim echo

#### ["x]TF
    in: From register
    out: Replacing original register


### Middle

#### pipe (M.pipe)
    M.pipe('exec').out(M.sh())

    via pipe run shell command
    out-from: shell output

#### function (M.func, M.fn)
    M.func('expand("%:p")')
    M.fn('func-name') == M.func('func-name(@{data})')

    out-from: return

#### vimscript (M.exec)
    M.exec('"line:".getline(".")') -ret

    out-from: assignment

#### data (M.data)
    M.data('I like vim.')

#### null (M.null)
    M.null()

    out: null, Don't handle input message

#### shell (M.sh)
    M.sh().out(M.sh())
    M.sh('@{data} @{tmp}')

    run shell command, command is pipe message, if don't have arguments.
    otherwise command is first argument.
    out-from: shell output

#### tmp (M.tmp)
    M.tmp('filename.ext')

    write pipe message to temporary file.
    out: file content, @{path}, @{name}

#### file (M.file)
    M.file('path/to/filename')

    write pipe message to specified file.
    out: file content, @{path}, @{name}

#### register (M.reg)
    M.reg().out(M.reg())
    M.reg('a')

    write pipe message to register
    out: register content, @{register}

#### buffer[new] (M.buf)
    b bn bs bv bt ba

    M.buf('%').out(M.buf('%'))
    M.buf('%5')                     out: buffer fifth line
    M.buf('%5,9')                   out: buffer 5 to 9 line
    M.buf('n')                      out: new buffer
    M.buf('n&')                     out: new buffer on backstage
    M.buf('ns')                     out: new buffer split
    M.buf('ns&')                    out: new buffer split on backstage
    M.buf('nv')                     out: new buffer vsplit
    M.buf('nu5')                    out: new buffer in upward and height is 5
    M.buf('nr5')                    out: new buffer in rightward and width is 5
    M.buf('nd5')                    out: new buffer in downward and height is 5
    M.buf('nl5')                    out: new buffer in leftward and width is 5

#### select (M.select)
    M.select()

### String Interpolation

* normal
    * in: @{data}
    * out: @{tmp_path}
* tmp, file
    * out: @{path} @{name}
* register
    * out: @{reg}

