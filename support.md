# Support

## TEXT
* text2ISO (HTML ISO-8859-1)
* ISO2text

* text2ISOAsc
* ISOAsc2text

* text2URL
* URL2text

[pydave/textconv.vim](https://github.com/pydave/textconv.vim)

## html

* [x] html2jade  
    * [visionmedia/jade]()  
        `cat %s |　html2jade - --donotencode`
* [x] jade2html  
    * [donpark/html2jade]()  
        `cat %s | jade -- pretty`

* [x] haml2html  
    * [haml/haml]()  
        `cat %s | haml -s`
* [x] html2haml  
    * [haml/html2haml]()  
        `cat %s | html2haml -s`

* [x] slim2html  
    * [slim-template/slim]()  
        `cat %s | slimrb -sp`
* [x] html2slim  
    * [slim-template/html2slim]()  
        `cat %s | html2slim %s %t`


* [x] markdown2html  
    * [evilstreak/markdown-js]()  
        `cat %s | md2html`
    * [chjj/marked]()  
        `cat %s | marked`
* [ ] html2markdown  
    * **Not found**

* [ ] wiki2html  
    * [nricciar/wikicloth]()  
    * [vimwiki/vimwiki]()  
* [ ] html2wiki  
    * **Not found**



## js

* [x] coffee2js  
    * [jashkenas/coffee-script]()  
        `cat %s | coffee -scpb`
* [x] js2coffee  
    * [js2coffee/js2coffee]()  
        `cat %s | js2coffee`

* [x] livescript2js  
    * [gkz/LiveScript]()  
        `cat %s | livescript -spcb`
* [ ] js2livescript  
    * **Not found**


## css

* [x] stylus2css  
    * [learnboost/stylus]()
        `cat | stylus`
* [ ] css2styl  
    * [dciccale/css2stylus.js]()  
        `css2stylus %s`

* [x] less2css  
    * [less/less.js]()  
        `cat %s | lessc -`
* [ ] css2less  
    * [thomaspierson/libcss2less]()  
        `css2less %s`

* [x] sass2css  
    * [nex3/sass]()  
        `cat | sass -s`
* [ ] css2sass
    * [jpablobr/css2sass]()
        **Not found**

## expand

* emmet...
