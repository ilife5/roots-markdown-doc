#Fekit 如何改写 document.write

##当遇到这种情况...

我们平时开发时，会使用 fekit server 进行本地调试。

比如某项目结构是：

	.
	├── README.md
	├── build
	│   ├── build.coffee
	│   └── runtime.coffee
	├── fekit.config
	├── index.html
	└── src
	    ├── loader.js
	    ├── moduleA.js
	    ├── moduleB.js
	    └── moduleC.js
loader.js 依赖 jquery。

##依赖渲染的普通模式
启动 fekit server 后，

当加载 <http://localhost/prd/loader.js> 后，内容为：

	document.write('<script src="http://localhost/fekit_modules/jquery/prd/jquery.js?no_dependencies=true"></script>');
	document.write('<script src="http://localhost/fekit_modules/jquery/prd/index.js?no_dependencies=true"></script>');
	document.write('<script src="http://localhost/prd/loader.js?no_dependencies=true"></script>');

##自定义渲染模式
当出于某些目的，想把返回的结果变为：

	loader.load('http://localhost/fekit_modules/jquery/prd/jquery.js?no_dependencies=true')
	loader.load('http://localhost/fekit_modules/jquery/prd/index.js?no_dependencies=true')
	loader.load('http://localhost/prd/loader.js?no_dependencies=true')

只要配置 fekit.config 中的

	"development":{
	    "custom_render_dependencies" : "./build/runtime.coffee"
	}

##请参考项目
<http://gist.corp.qunar.com/hao.lin/loader-test>

##注意！！！
该功能只影响 fekit server 生成的代码，不会影响最终内容。 也就是，如果你依赖这种模式做 lazyload，它也只会在本地开发的时候有作用。