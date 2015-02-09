#用户配置（Configuring Fekit）

##fekit.config 样板

    {
        "compiler" : false|modular|component,

        "name" : "hello1",
        "version" : "0.0.1",
        "author" : "rinh",
        "email" : "rinh@abc.com",
        "description" : "",
        "main" : "home", 

        "dependencies" : {
            "dialog" : "1.2.*"    
        }, 

        "alias" : {
            "core" : "./src/core"
        },

        "export" : [
            "./scripts/page-a.js",   
            { 
                "path" : "./scripts/page-b.js",
                "parents" : [ "./scripts/page-a.js" ]
            }, 
            {
                "path" : "./scripts/page-c.js" , 
                "no_version" : true
            }
        ],

        "scripts" : {
            "premin" : "./build/premin.js",
            "postmin" : "./build/premin.js",
            "prepack" : "./build/premin.js",
            "postpack" : "./build/premin.js", 
            "prepublish" : "./build/prepublish.js"
        }
    }

##fekit.config 详解
<table>
    <tr class="head">
      <th>配置项</th><th>值</th><th>说明</th>
    </tr>
    <tr class="light">
      <th colspan="3">编译方案配置项</th>
    </tr>
    <tr>
      <td>compiler</td><td>false|"modular"|"component"</td>
      <td>
         <b>配置项含义</b>：
            <br/>compiler，编译方案<br/><br/>
		 <b>取值</b>：
            <br/><b>false:</b> 使用普通模式编译。会将 import 和 require 引用的文件 inline 进文件中；
            <br/><b>"modular":</b> 使用模块化模式编译。会将 import 和 require 以<a href="https://github.com/amdjs/amdjs-api/wiki/AMD" target="_blank">标准AMD方案的变化(Asynchronous Module Definition)</a>进行处理, 模块内的内容将以exports或return对外提供接口；
            <br/><b>"component“:</b> 使用组件模式编译。<br/><br/>
         <b>默认值</b>：
            <br/>false
      </td>
    </tr>
    <tr class="light">
      <th colspan="3">组件编译方式配置项</th>
    </tr>
    <tr>
      <td>name</td><td>如："hello1"</td><td>组件名称标识符，string类型</td>
    </tr>
    <tr>
      <td>version</td><td>如："0.0.1"</td><td>组件版本号，string类型，遵循semver</td>
    </tr>
    <tr>
      <td>author</td><td>如："rinh"</td><td>组件作者名，string类型</td>
    </tr>
    <tr>
      <td>email</td><td>如："rinh@abc.com"</td><td>组件作者邮箱，string类型</td>
    </tr>
    <tr>
      <td>description</td><td>如：""</td><td>组件描述，string类型</td>
    </tr>
    <tr>
      <td>main</td><td>如："home"</td><td>指定某个文件作为包入口, 该路径以src目录为根。默认使用src/index</td>
    </tr>
    <tr class="light">
      <th colspan="3">依赖组件配置项</th>
    </tr>
    <tr>
      <td>dependencies</td><td>
         如：{ "dialog" : "1.2.*" } 
      </td>
      <td>依赖的组件</td>
    </tr>
    <tr class="light">
      <th colspan="3">别名配置项</th>
    </tr>
    <tr>
      <td>alias</td><td>
         如：{ "core" : "./src/core" } 
      </td>
      <td><b>配置项含义</b>：
            <br/>别名的配置, 该库作为编译时 @import url 和 require 使用
            <br/><br/><b>取值</b>：
            <br/>路径相对于当前fekit.config文件
      </td>
    </tr>
    <tr class="light">
      <th colspan="3">文件导出配置项</th>
    </tr>
	<tr>
      <td rowspan="4">export</td><td>
         如："./scripts/page-a.js" 
      </td>
      <td><b>配置项含义</b>：
            <br/>将要导出至 `prd` 和 `dev` 目录的文件列表。其中所有路径, 均相对于 `src` 目录
            <br/><br/><b>取值</b>：
            <br/>第一种配置方式, 直接写出要导出的文件相对路径</td>
    </tr>
    <tr>
      <td>
         如：<pre>
{ 
   "path" : "./scripts/page-b.js" ,
   "parents" : [ "./scripts/page-a.js" ]
}</pre>
      </td>
      <td><b>配置项含义</b>：
            <br/>将要导出至 `prd` 和 `dev` 目录的文件列表。其中所有路径, 均相对于 `src` 目录
            <br/><br/><b>取值</b>：
            <br/>第二种配置方式, 当要导出的文件, 在实际使用时有上级依赖, 则可以将上级依赖的文件加入`parents`节点</td>
    </tr>
    <tr>
      <td>
         如：<pre>
{
    "path" : "./scripts/page-c.js" , 
    "no_version" : true
}</pre>
      </td>
      <td><b>配置项含义</b>：
            <br/>将要导出至 `prd` 和 `dev` 目录的文件列表。其中所有路径, 均相对于 `src` 目录
            <br/><br/><b>取值</b>：
            <br/>允许某个文件不含版本号信息</td>
    </tr>
    <tr>
      <td>
         如：<pre>
{
    "path" : "./scripts/page-a.css" , 
    "domain_mapping" : 
         "domain.com => img1.domain.com
          img2.domain.com
          img3.domain.com
          img4.domain.com"
}</pre>
      </td>
      <td><b>配置项含义</b>：
            <br/>将要导出至 `prd` 和 `dev` 目录的文件列表。其中所有路径, 均相对于 `src` 目录
            <br/><br/><b>取值</b>：
            <br/>允许 css 使用 domain_mapping 功能</td>
    </tr>
    <tr class="light">
      <th colspan="3">自动化hook脚本配置项</th>
    </tr>
    <tr>
      <td>scripts</td><td>如：<pre>
{
    "premin" : "./build/premin.js" ,
    "postmin" : "./build/premin.js" ,
    "prepack" : "./build/premin.js" ,
    "postpack" : "./build/premin.js" , 
    "prepublish" : "./build/prepublish.js"
}</pre>
    </td><td><b>配置项含义</b>：<br/>自动化hook脚本。<br/><br/><b>取值</b>：<br/>
每一项均为 hook , 在 min 开始或结束后 与 pack 开始时或结束后会调用执行 指定位置的任意javascript文件。你可以使用全局变量 EXPORT_LIST，其结构为：<pre>
[ 
   { 
      url : '源文件文件的物理路径' , 
      path : '源文件相对于根目录的路径' , 
      ver : '编译后的version版本号' ,
      minpath : '编译后的相对于根目录的路径, 包含版本号'
   }  
]</pre>
ver与minpath只在postmin时才会有。
    </td>
    </tr>
    <tr class="light">
      <th colspan="3">自定义编译参数配置项</th>
    </tr>
    <tr>
      <td>min</td><td>如：<pre>
{
    "config" : {
        "uglifycss" : {}, 
        "uglifyjs" : {
            "ast_mangle" : {}, 
            "ast_squeeze" : {},
            "gen_code" : {}
        }
    }
}</pre>
    </td><td><b>配置项含义</b>：<br/>自定义编译参数<br/><br/><b>取值</b>：<br/>
    "uglifycss" : 参见：<a href="_blank">https://github.com/fmarcia/UglifyCSS</a>
	<br/>
    "uglifyjs" : 参见：<a href="_blank">https://github.com/mishoo/UglifyJS</a>
      </td>
    </tr>
    <tr class="light">
      <th colspan="3">发布其它文件配置项</th>
    </tr>
    <tr>
      <td>refs</td><td>如：<pre>
{
    "cp" : [ "ver" ],
    "sh" : "./auto.js"
}</pre>
    </td><td><b>配置项含义</b>：<br/>发布其它文件<br/><br/><b>取值</b>：<br/>
    "cp" : copy 命令 , 将 ver 目录复制到 refs 中
	<br/>
    "sh" : 自定义脚本, 当前目录为项目目录, 可以制定任意内容，全局对象可以使用path, file, cwd, refs_path</td>
    </tr>
</table>