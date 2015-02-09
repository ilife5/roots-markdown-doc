#Demo 2 - 重复引用处理
*插入一段视频*
##index.html
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>demo 2 - 重复引用处理 </title>
	</head>
	<body>
		<script src="prd/page-1.js"></script>
		<script src="prd/page-2.js"></script>
	</body>
	</html>

##page-1.js
	var core = require("./core.js");
	document.write( "page 1:" + require("./dialog.js").getVersion() + "<br />" );

##core.js
	exports.getVersion = function(){
		return "core 1.0";
	}
	
	document.write("loaded -- core.js <br />");

##dialog.js
	var core = require("./core.js");
	
	exports.getVersion = function(){
		return "dialog 1.0 , " + core.getVersion();
	}

##page-2.js
	var core = require("./core.js");
	document.write( "page 2: " + core.getVersion() );

##fekit.config
	{
		"compiler" : "modular" ,
		"export" : [
			"page-1.js" ,
			{ "path" : "page-2.js" , "parents" : [ "page-1.js" ] }
		]
	}

