var http = require('http')
var url = require('url')
var mjAPI = require("mathjax-node")

mjAPI.config({
  MathJax: {
    TeX: {
      Macros: {
        iddots: "{\\kern3mu\\raise1mu{.}\\kern3mu\\raise6mu{.}\\kern3mu\\raise12mu{.}}",
        oiint: "{\\bigcirc}\\kern-11.5pt{\\int}\\kern-6.5pt{\\int}",
        oiiint: "{\\bigcirc}\\kern-12.3pt{\\int}\\kern-7pt{\\int}\\kern-7pt{\\int}",
      }
    }
  },
  displayErrors: false
});
mjAPI.start()

http.createServer(function(req, res){
    var math = url.parse(req.url, true).query.tex
    math = math.replace(/^\/tex\d?\//, '')
    mjAPI.typeset({format: 'TeX', svg: true, math: math}, function(data){
        if(data.errors) {
            res.writeHeader(400)
            res.end()
        } else {     
            res.writeHeader(200, {
                'Content-Type': 'image/svg+xml'
            })
            res.end(data.svg)
        }
    })   
}).listen(9999)