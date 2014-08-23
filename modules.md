## SOURCE

### func, fn

### exec, data

### sh

### tmp, file

### reg

### buf

### select

### smart

## Middle

### pipe (exec)
    M.pipe('exec')

    via pipe run shell command
    inout: stdin
    output: stdout

### function (func fn)
    M.func('expand("%:p")')
    M.fn('func-name') == M.func('func-name({@data})')

    output: return

### vimscript (exec data null)
    M.exec('"line:".getline(".")')
    M.data('<strong></strong>')
    output: assignment

    M.null()
    output: null, Don't handle input message

### shell (sh)
    M.sh()
    M.sh('@{data} @{tmp}')

    run shell command, the command that is input data, if don't have arguments.
    otherwise command is first argument.

    output: stdout

### file (tmp file)
    M.tmp('filename.ext')

    write data to temporary file.
    output: file content, @{path}, @{fname}

    M.file('path/to/filename')

    write pipe message to specified file.
    output: file content, @{path}, @{fname}

### register (reg)
    M.reg()
    M.reg('a')

    write pipe message to register
    output: register content, @{reg}

### buffer (buf)
    M.buf('%')
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

### select
    M.select()

### smart

### watch

### select (M.select)

## String Interpolation

* normal
    * in: @{data}
* tmp, file
    * out: @{path} @{name}
* register
    * out: @{arg}
