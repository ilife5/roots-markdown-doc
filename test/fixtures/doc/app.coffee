markdown        = require "../../.."
path            = require "path"
axis            = require 'axis'
rupture         = require 'rupture'
autoprefixer    = require 'autoprefixer-stylus'
js_pipeline     = require 'js-pipeline'
css_pipeline    = require 'css-pipeline'
dynamic_content = require 'dynamic-content'


module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf', 'template/**']

  extensions: [
    dynamic_content(              ),
    js_pipeline(files: ['assets/js/*.coffee', 'assets/js/*.js'], out: "/index.js", minify: true),
    css_pipeline(files: ['assets/css/*.styl', 'assets/css/theme/*.css'], out: "/index.css", minify: true),
    markdown(layout: 'template/_content.jade', opts: {
      pretty: true
    })
  ]

  stylus:
    use: [axis(), rupture(), autoprefixer()]
    sourcemap: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true
