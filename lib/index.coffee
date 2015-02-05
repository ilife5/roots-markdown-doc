path        = require "path"
jade        = require "jade"
_           = require "lodash"
fs          = require "fs"
minimatch   = require("minimatch")

module.exports = (opts) ->

  opts = _.defaults opts,
    files: ['docs/**/*.md', 'docs/*.md']
    opts: {}
    indent: "  "
    placeholder: "//- {{markdown}}"

  placeholderReg = new RegExp("\\n(([^\\n]*)" + opts.placeholder + ")")

  class MarkdownConversion
    constructor: (@roots) ->
      @category = "markdown"
      @layout   = layout_exec(fs.readFileSync(path.join(@roots.root, opts.layout), "utf-8"))
      @files    = opts.files
      @indent   = opts.indent
      @opts     = opts.opts
      if !@opts.basedir
        @opts.basedir = @roots.root

    fs: ->
      extract: true
      detect: (f) =>
        _.some(@files, minimatch.bind(@, f.relative))

    compile_hooks: ->
      before_file: (ctx) =>
        @md_content = ctx.content
      write: (ctx) =>
        if @layout
          content = @md_content.replace(/([^\n]+)/g, @layout.indent + @indent + "$1")
          content = @layout.layout.substring(0, @layout.index) + @layout.indent + ":markdown\n" + content + @layout.layout.substring(@layout.index)
          fn = jade.compile content, @opts
          path: path.join(ctx.roots.config.output_path(), "..", ctx.file_options._path),
          content: fn()

    layout_exec= (layout) ->
      regResult = layout.match(placeholderReg)

      if regResult
        layout: layout.replace(regResult[1], "")
        indent: regResult[2]
        index : regResult.index + 1


