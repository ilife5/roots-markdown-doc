path        = require "path"
jade        = require "jade"
_           = require "lodash"
fs          = require "fs"
minimatch   = require("minimatch")
glob        = require("glob")

module.exports = (opts) ->

  opts = _.defaults opts,
    files: ['docs/**/*.md', 'docs/*.md']
    opts: {}
    indent: "  "
    placeholder: "//- {{markdown}}"

  placeholderReg = new RegExp("\\n(([^\\n]*)" + opts.placeholder + ")")

  class MarkdownConversion
    constructor: (@roots) ->
      @category                    = "markdown"
      @layout                      = layout_generate(fs.readFileSync(path.join(@roots.root, opts.layout), "utf-8"))
      @files                       = opts.files
      @indent                      = opts.indent
      @opts                        = opts.opts
      @roots.config.locals         ?= {}
      @roots.config.locals.catalog ?= {}
      @catalog                      = catalog_generator(opts.files)
      @compiled                     = false

      if !@opts.basedir
        @opts.basedir = @roots.root

    fs: ->
      extract: true
      detect: (f) =>
        _.some(@files, minimatch.bind(@, f.relative))

    compile_hooks: ->
      before_file: before_hook.bind(@)
      write: write_hook.bind(@)

    category_hooks: ->
      after: (ctx) =>
        ###**
         * reset catalog for next loop
        ###
        @compiled = false
        ctx.roots.config.locals.catalog = {}

    ###**
     * generate layout content, calculate the indent and index
    ###
    layout_generate= (layout) ->
      regResult = layout.match(placeholderReg)

      if regResult
        layout: layout.replace(regResult[1], "")
        indent: regResult[2]
        index : regResult.index + 1

    ###**
     * pipe ctx.content before file
     * save path information
     * save catalog information
    ###
    before_hook= (ctx) ->
      if !@compiled
        @compiled = true
        @roots.config.locals.catalog = @catalog
      @md_content = ctx.content

    ###**
     * generate content use jade and write
    ###
    write_hook= (ctx) ->
      if @layout
        content = @md_content.replace(/([^\n]+)/g, @layout.indent + @indent + "$1")
        content = @layout.layout.substring(0, @layout.index) + @layout.indent + ":markdown\n" + content + @layout.layout.substring(@layout.index)
        fn = jade.compile content, @opts
        path: path.join(ctx.roots.root, ctx.file_options._path)
        content: fn(ctx.roots.config.locals)
      else
        true

    get_catalog= (_path) ->
      _path = _path.split(path.sep)
      _path[_path.length - 2]

    catalog_generator= (files)->

      catalog = {}

      _.each Array.prototype.concat(files), (pattern) ->
        _.each glob.sync(pattern), (file) ->
          _name = path.basename file, ".md"
          _catalog = get_catalog(file)
          _path = file.replace ".md", ".html"

          catalog[_catalog] ?= []
          catalog[_catalog].push
            path: "/" + _path
            name: _name

      catalog