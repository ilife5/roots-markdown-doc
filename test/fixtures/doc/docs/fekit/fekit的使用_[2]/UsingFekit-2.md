#使用 Fekit 组件化
组件源：<http://l-registry.fe.dev.cn6.qunar.com>

##你的配置

公司内网有 fekit 组件源服务器，如果你想使用它，需要在你的用户主目录，放置一个文件：.fekitrc ， 内容为

	{
		"registry" : "l-registry.fe.dev.cn6.qunar.com:3300"
	}

##fekit.config

要成为一个包，在 fekit 项目内应包括 fekit.config 文件，它是用来安装及发布的依据。

	{
	     "name" : "包名称" , 
	     "author" : "rinh" , 
	     "email" : "rinh@abc.com" , 
	     //指定某个文件作为包入口, 该路径以src目录为根.  默认使用 src/index  
	     "main" : "home" ,                   
	     "version" : "1.2.3" , //遵循semver
	     "dependencies" : {
	           "dialog" : "1.2.x"    
	     } , 
	     "description" : "" , 
	     "scripts" : {}
	}

##README.md

你必须在项目根目录下，放置一个 README.md 文件，它的语法格式是 markdown（[请参考](http://wowubuntu.com/markdown/ "markdown"))

##如何安装，发布？

	fekit install xxx
	fekit publish 
	fekit unpublish xxxx@1.2.3