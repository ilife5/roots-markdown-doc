#CLI命令（CLI Commands）
##config
###使用方法
    fekit config 查看fekit全局配置项
    fekit config -s,--set <key> <value> 增加一个配置项
    fekit config -d,--delete <key> 删除一个配置项
    fekit config -h,--help 查看帮助
###使用说明
配置fekit的环境变量，写入`.fekitrc`文件，文件要求json格式。

可能需要在指定（用户根目录下）新建`.fekitrc`文件
##export
###使用方法
    fekit export  导出文件配置到 fekit.config 'export' 列表中 
###使用说明
只可以导出 `src` 目录内的文件，要导出的文件头需要加 `/* [export] */` 或 `/* [export no_version] */`，`fekit.config` 文件中的`export`会生成。

	{
	   "path": "a.css",
	   "no_version": false/true
	}
多次导出会覆盖原先的结果。目前只支持.css与.js后缀。
##init
###使用方法
	fekit init [name]  可选参数 : name , 若添加 , 则会新建项目文件夹
###使用说明
新建一个fekit项目,若存在 fekit.config 文件,则无法新建。

新项目包含: src 文件夹, README.md , environment.yaml配置信息, fekit.config配置文件

默认配置信息为：

	local:
	    DEBUG: true
	dev:
	    DEBUG: true
	prd:
	    DEBUG: false
##install
###使用方法
	fekit install  根据 'fekit.config' 内的配置安装
	fekit install <name> [-c] 参数为组件名,安装指定组件最新版,并写入'fekit.config' 若加 '-c' 则为强制使用配置文件中的版本范围，如果没有配置文件或配置文件中没有配置，就不安装
	fekit install <name>@<version> [-c] 安装指定组件 ,并写入'fekit.config' ,若加 '-c' 则为强制使用配置文件中的版本范围，如果没有配置文件或配置文件中没有配置，就不安装
###使用说明
用来安装fekit组件。

需要使用 fekit config 指令来指定下载源。

若需使用 -c ，需要配置 fekit.config 中的依赖。
##login
###使用方法
	fekit login
###使用说明
需要先去fekit源进行注册，然后按提示输入用户名和密码。

注册地址: http://l-registry.fe.dev.cn6.qunar.com/signup。
##logout
###使用方法
	fekit logout
##min
###使用方法
	fekit min [-v] [-m] 
	压缩,合并项目文件 ,`-v` 与 `-m`为可选项 ,分别为  在 `/ver` 目录中只生成 version 文件 和在 `/ver` 目录中只生成 mapping 文件         
	把`dev`目录中的文件压缩到`prd`目录中
	
	fekit min -f <fname> [-n] [-c] [-o <path>] 
	指定编译某个文件, 而不是当前目录. 处理后默认将文件放在同名目录下并加后缀 min。
	可选项 `-n` , 不进行压缩处理, 如编译 coffee文件,若使用`-n` 则不会压缩编译后的js文件
	可选项 `-c` , 不分割 css 为多行形式,默认分割, 使用后css合并为一行
	可选项 `-o` ,  指定单个文件编译的输出位置, 默认在相同文件夹下
###使用说明
   
默认压缩引擎` js `使用`uglify-js`, css使用`uglifycss`。

支持编译的文件类型` coffee, css, js, handlebars, less, mustache, ng, ngc, sass, scss, string`。

使用是需要添加文件后缀名, 若重复编译则会覆盖先前的文件。
##pack
###使用方法
	fekit pack  合并项目文件
###使用说明
把`fekit.config`文件中`export`内的文件合并打包到`dev`目录中
##plugin
###使用方法
	fekit plugin -i <name>  npm install 的一个包装,实际安装插件名为‘fekit-extension-name’
	fekit plugin -u <name>  等效于 npm uninstall fekit-extension-name
###使用说明
此方法为npm install/uninstall 的一个包装，安装时需确保 fekit-extension-name 在npm中存在。
##publish
###使用方法
	fekit publish
###使用说明
操作需要先登录。
##server
###使用方法
	fekit server  -p <portNo>, --port        服务端口号, 一般无法使用 80 时设置, 并且需要自己做端口转发                     
	fekit server  -r <原路径名><路由后的物理路径>, --route       路由,将指定路径路由到其它地址, 物理地址需要均在当前执行目录下。转换旧项目(qzz)的url，方便开发
	fekit server  -c, --combine     指定所有文件以合并方式进行加载, 启动该参数则请求文件不会将依赖展开                    
	fekit server  -n, --noexport    默认情况下，/prd/的请求需要加入export中才可以识别。 指定此选项则可以无视export属性    
	fekit server  -t, --transfer    当指定该选项后，会识别以前的 qzz 项目 url                             
	fekit server  -b <目录名>, --boost       可以指定目录进行编译加速。                               
	fekit server  -s <ssl证书>, --ssl         指定ssl证书文件，后缀为.crt                                     
	fekit server  -m <mock文件>, --mock        指定mock配置文件                                            
	fekit server  -l, --livereload  是否启用livereload                                        
	fekit server  -h, --help        查看帮助
###使用说明
mock文件,是一个针对域名作的代理服务配置文件：

	module.exports = {
	    "/exact/match/1": "exact.json",
	    "/exact/match/2": "exact.mockjson",
	    "/exact/match/3": "https://raw.githubusercontent.com/rinh/fekit/master/docs/mock/exact.json",
	    "/exact/match/4": "exact.js",
	    rules: [{
	        pattern: "/exact/match/5",
	        respondwith: "exact.json"
	    }, {
	        pattern: /^\/regex\/match\/a\/\d+/,
	        respondwith: "regex.json",
	        jsonp: "__jscallback"
	    }, {
	        pattern: /^\/regex\/match\/b\/\d+/,
	        respondwith: function(req, res, context) {
	            res.end(JSON.stringify(Object.keys(context)));
	        }
	    }]
	};
- key 可以是正则表达式, 也可以是字符串 * 默认的 value 是string, uri以后缀名或内容判断 ACTION 有四种类型 .json -> raw .js -> action .mockjson -> mockjson http:// 或 https:// -> proxy_pass
- 配置文件定义一个 node 模块
- key 或 pattern 属性是字符串，准确匹配 url（包括 query）
- pattern 属性是正则表达式，正则匹配 url
- jsonp 属性指定 jsonp 请求的回调函数名，默认为 "callback"
- value 或 respondwith 属性给定文件均为配置文件相对路径
- value 或 respondwith 属性有如下方案：
####raw
    配置案例
    "raw" : "./url.json"
如 `"/exact/match/1"`，`"/exact/match/5"`，`/^\/regex\/match\/a\/\d+/`，指定文件是 .json 文件，.json 文件内容原样返回
####mockjson
    配置案例
    "mockjson" : "./a.mockjson"
    使用方式见 https://github.com/mennovanslooten/mockJSON
如 "/exact/match/2"，指定文件是 .mockjson 文件，如下：

	{
	    "fathers|5-10": [{
	        "id|+1": 0,
	        "married|0-1": true,
	        "name": "@MALE_FIRST_NAME @LAST_NAME",
	        "sons": null,
	        "daughters|0-3": [{
	            "age|0-31": 0,
	            "name": "@FEMALE_FIRST_NAME"
	        }]
	    }]
	}
遵循 mockJSON 的写法，生成随机数据返回。
####proxy_pass
配置案例

    proxy_pass : 'http://l-hslist.corp.qunar.com'
如 "/exact/match/3"，代理请求指定地址，并将请求结果返回
####action

	配置案例
    "action" : "./url.js"

    在 url.js 中，必须存在
    module.exports = function( req , res , user_config , context ) {
        // res.write("hello");
    }
如 "/exact/match/4"，自定义请求处理函数，给定 js 文件代码如下：

	module.exports = function(req, res, context) {
	    res.end(JSON.stringify({
	        "exact": true
	    }));
	};
或如 `/^\/regex\/match\/b\/\d+/` 直接写在配置文件中。
##sync
###使用方法
	fekit sync
           -f, --file     更换成其它目录下的配置文件, 默认使用当前目录下的 .dev,见实例
           -n, --name     更换其它的配置名, 默认使用 dev ,见实例
           -i, --include  同 rsync 的 include 选项
           -e, --exclude  同 rsync 的 exclude 选项
           -x, --nonexec  上传后禁止执行 shell ,可配置
           -d, --delete   删除服务器上本地不存在的文件
           -h, --help     查看帮助
###使用说明
想要与服务器同步，需要配置`.dev`文件，

`.dev`文件配置实例：

	{
	    "dev": {
	        "host": "l-qzz1.fe.dev.cn6.qunar.com",
	        "path": "/home/q/www/qunarzz.com/ordercenter/",
	        "local": "./",
	        "user": "cc.zhuang",
	        "shell": "nginx -s reload",
	        "delete": true,
	        "nonexec": true,
	        "include": [],
	        "exclude": ".git"
	    },
	    "qa": {
	        "host": "l-qzz1.fe.dev.cn6.qunar.com",
	        "path": "/home/q/www/qunarzz.com/ordercenter/",
	        "local": "./",
	        "user": "cc.zhuang",
	        "shell": "nginx -s reload",
	        "delete": true,
	        "nonexec": true,
	        "include": [],
	        "exclude": ".git"
	    }
	
	}
##test
###使用方法
	fekit test
###使用说明    
用到了`mocha`框架，需要有test.js文件或`test`文件夹
##unpublish
###使用方法
	fekit unpublish <name>@<version>  version需要写成`0.0.0`形式
###使用说明    
需要先登录再操作。
##upgrade
###使用方法
	[sudo] fekit upgrade    更新自身及更新已安装扩展
###使用说明    
是全局安装，所以*nix用户需要使用`sudo`命令

而且似乎mac上未更新成功会回滚失败，需要重装一遍fekit？