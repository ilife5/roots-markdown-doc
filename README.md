Roots markdown doc
=================

Roots markdown doc is a generator for makrdown files to build a doc。


### Installation

- make sure you are in your roots project directory

```
npm install markdown-doc --save
```

- modify your `app.coffee` file to include the extension, for example:

```
  	markdown       = require "markdown-doc"

	module.exports =
    	extensions: [markdown(layout: 'template/_content.jade', files: 'docs/**/*.md')]
    
```

### Options

##### files
String or array of strings ([minimatch](https://github.com/isaacs/minimatch) supported) pointing to one or more file paths to be built.

##### placeholder
A markdown placeholder in jade template to be replace.

template.jade:

```
div.container
        div#page
            //- {{markdown}}
```          

docs/helloworld.md

```
# markdown

hello world
```

should be compile to docs/helloworld.html


	<div class="container">
		<div id="page">
			<h1>markdown</h1>
			<p>hello world</p>
		</div>
	</div>


##### jade
Options to be passed into the jade.

```
	markdown        = require "markdown-doc"

	module.exports =
    	extensions: [markdown(layout: 'template/_content.jade', files: 'docs/**/*.md', jade 
    	pretty: true)]

```