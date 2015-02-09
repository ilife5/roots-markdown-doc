#Demo 5 - 日历选择小案例
*插入一段视频*
##我们需要实现一个需求
快速建立一个页面，并在页面中加入一个日历选择框。

>*想一想，如果没有 fekit，你要怎么做呢？*


<div id="js-video"
     data-url="http://qtown.corp.qunar.com/accessible/video/2014/11/19/6aa551ca45b5230c4544691819ea2d43_play.flv"
     data-image="http://qtown.corp.qunar.com/accessible/cover/2014/11/19/08974a2ed9e67bfed0629dd9e9872bbf.flv.jpg"></div>

##开始
以下均以 windows 环境举例，其它环境大略相同：
###创建项目
打开命令行，请在 d:\ 下创建一个文件夹，名叫 test

	cd d:\test
	fekit init first-demo
	cd first-demo
在生成的 first-demo 目录中，存在 src 目录及 fekit.config 文件。
###源代码
请在 first-demo 目录中分别创建三个文件：
<table>
    <tr class="head">
      <th>文件路径</th><th>功能</th>
    </tr>
    <tr>
      <td>./index.html</td><td>标准的html页面，它将展示日历框</td>
    </tr>
    <tr>
      <td>./src/index.css</td><td>页面所使用到的样式表</td>
    </tr>
    <tr>
      <td>./src/index.js</td><td>页面所使用到的js代码</td>
    </tr>
</table>
三个文件的内容分别如下：

*./index.html*

	<!DOCTYPE html>
	<html>
	<head>
	    <meta charset='utf-8'>
	    <link rel="stylesheet" href="prd/index.css">
	</head>
	<body>
	    <input id="dp" />
	    <script src="prd/index.js"></script>
	</body>
	</html>

./src/index.css

	@import url('demo-datepicker');

./src/index.js

	require('demo-datepicker');
	$('#dp').qdatepicker( { ui : 'qunar' , maxDate : new Date(2010 , 7 , 11) , forceCorrect : false } );

###修改配置文件
打开 fekit.config ， 修改为以下内容：

	{
	    "compiler": "modular",
	    "dependencies": {
	        "demo-datepicker": "0.0.1"
	    }
	}

配置组件源，请在用户目录（windows就是开始菜单中的你的用户名那项)中建立 .fekitrc 文件, 内容为：

	{
		"registry" : "l-registry.fe.dev.cn6.qunar.com:3300"
	}

有同学说在windows下无法创建.fekitrc文件。 是因为windows默认不能以.开头起文件名。 只要进到cmd中，运行 notepad .fekitrc 就行了。 当然路径要保持正确啊。

###解决依赖并运行服务器
进入命令行，执行以下命令

	cd d:\test\first-demo
	fekit install
	fekit server -n

###完成
请打开浏览器，访问 <http://localhost>

###如何压缩
请修改 fekit.config 为以下内容

	{
	    "compiler": "modular",
	    "dependencies": {
	        "demo-datepicker": "0.0.1"
	    },
	    "export": [
	        "index.css" ,
	        "index.js"
	    ]
	}

进入命令行，执行以下命令:

	fekit min

现在查看 first-demo 目录，会出现一个 prd 和 ver 目录， 其中内容为

	├── prd
	│   ├── index@72725a82dd0e73cc32504c4c4986e815.js
	│   └── index@bb9a7d6d9b426f41d50c7003d6103d08.css
	├── src
	│   ├── index.css
	│   └── index.js
	└── ver
	    ├── index.css.ver
	    ├── index.js.ver
	    └── versions.mapping

prd 和 ver 就是压缩后的代码及对应的版本号。