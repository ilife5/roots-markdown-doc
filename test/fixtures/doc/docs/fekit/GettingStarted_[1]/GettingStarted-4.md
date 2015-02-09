#Demo 4 - 组件化开发（使用篇）
*插入一段视频*
##index.html
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>demo 4 - 组件化开发（使用篇） </title>
	</head>
	<body>
		<div id="msg"></div>
		<script src="prd/helloworld.js"></script>
	</body>
	</html>

##helloworld.js
	var $ = require('jquery');
	var a = require('./widget/hello.js');
	var b = require('./widget/world.js');
	
	$('#msg').html( a.toString() + " " + b.toString() + " jQuery version: " + $().jquery );

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