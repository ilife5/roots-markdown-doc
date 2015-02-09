#Demo 1 - hello world
*插入一段视频*
##index.html
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>demo 1 - hello world </title>
	</head>
	<body>
		<script src="prd/helloworld.js"></script>
	</body>
	</html>

##helloword.js
	var a = require('./widget/hello.js');
	var b = require('./widget/world.js');
	
	alert( a.toString() + " " + b.toString() ); 

##hello.js
	module.exports = {
		toString : function(){
			return "hello ";
		}
	}

##world.js
	exports.toString = function(){
		return "world!";
	}

##fekit.config
	{
		"compiler" : "modular" ,
		"export" : [
			"helloworld.js"
		]
	}