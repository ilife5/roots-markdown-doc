#使用 Fekit 环境变量功能

在不同的环境(local,dev,prd)可以使用宏（即环境变量）来方便开发。

##使用场景
我们会在不同的环境设置一个接口的url：

**本地开发的时候：**

	var url = "http://l-test1.dev.cn6.qunar.com"

**开发机联调的时候：**

	var url = "http://l-test1.beta.cn6.qunar.com"

**发到线上后：**

	var url = "http://hotel.qunar.com"

所以需要一种机制，来根据环境变更 url 的内容。

##如何使用
###配置文件
在 fekit.config 同级目录，创建 environment.yaml(使用yaml格式) 内容为：

	local:
	    DEBUG: true
	
	dev:
	    DEBUG: true
	
	prd:
	    DEBUG: false

这样，在不同环境下，DEBUG变量的值就是不同的。

如果你更喜欢用 json ，也可以创建 environment.json 内容为：

	{
	 "local": {
	 	"DEBUG": true
	 } ,
	 "dev": {
	    "DEBUG": true
	 } ,
	 "prd": {
	    "DEBUG": false
	 }
	}

最后，如果你如力神一般洁癖，不想有那么多文件在根目录，也可以把配置写到 fekit.config

	{
	    "compiler": "modular",
	    "name": "macro",
	    "version": "0.0.0",
	    "dependencies": {},
	    "alias": {},
	    "export": [
	    	"index.js"
	    ],
	    "environment" : {
			 "local": {
			 	"DEBUG": true
			 } ,
			 "dev": {
			    "DEBUG": true
			 } ,
			 "prd": {
			    "DEBUG": false
			 }
		}
	}

###源码
在源码中，使用环境变量的方法是通过特殊的写法来调用，如：

	/*[变量名]*/
	var isDebug = /*[DEBUG]*/; 

编译后的结果就是：

	var isDebug = true; // 这是在本地的时候

###环境

**local :** 指的是使用 fekit server 的环境<br/>
**dev :** 指的是 fekit pack 后的代码环境<br/>
**prd :** 指的是 fekit min 后的代码环境