#Demo 3 - 功能展示
*插入一段视频*
##index.html
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>demo 3 - 功能展示 </title>
		<link href="prd/styles/page@1111111MD5.css" media="all">
	</head>
	<body>
		<p>
			<a href="https://github.com/rinh/fekit" target="_blank">
		</p>

		<script src="prd/page-1@11111.js"></script>
		<script src="prd/page-2@1111111MD5.js"></script>
	</body>
	</html>

##page.css
	@import url("./reset");
	@import url("./control");
	
	body { margin: 10px; }
	a { color: #f00; }

##page-1.js
	var core = require("qunar.core");
	var dialog = require("./dialog");
	
	console.log( require("./html.string") );

	document.write( "page 1:" + dialog.getVersion() + "<br />" );

##dialog.js
	var core = require("qunar.core");
	
	exports.getVersion = function(){
		return "dialog 1.0 , " + core.getVersion();
	}

##core.coffee
	exports.getVersion = () ->
		return "core 1.0"
	
	document.write("loaded -- core.js <br />")

##fekit.config
	{
		"compiler" : "modular" ,

		"alias" : {
			"qunar" : "./src/lib/qunar"
		} ,		

		"export" : [
			"styles/page.css" ,
			"page-1.js" ,
			"page-2.js"
		]
	}

##html.string
	<html>
		<head></head>
		<body>xxxx</body>
	</html>


