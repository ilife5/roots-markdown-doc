#Fekit ver 文件部署方式
目前, fekit min 后，会生成2种不同的version，如下面例子：

	├── prd
	│   ├── loader@fe769d38cb00b17ba0f1e9bd47c65711.js
	│   ├── moduleA@74ee0c143d4c353b478652feaaea343c.js
	│   ├── moduleB@a4ac5f422a22a41ac6efbf42e377de0f.js
	│   └── moduleC@817dc24c667eec004cab96b26a24256c.js
	├── src
	│   ├── loader.js
	│   ├── moduleA.js
	│   ├── moduleB.js
	│   └── moduleC.js
	└── ver
	    ├── loader.js.ver
	    ├── moduleA.js.ver
	    ├── moduleB.js.ver
	    ├── moduleC.js.ver
	    └── versions.mapping

##/ver/ 目录
其中包含所有与 /prd/ 下文件路径一致的版本号文件。 如：

>/prd/loader@fe769d38cb00b17ba0f1e9bd47c65711.js 这个文件就有对应的版本号文件为 /ver/loader.js.ver

而 ver目录中的内容大概会这么用：

在 html/jsp/php 页面中：

	源码为：
	<script src="http://qunarzz.com/hotel_fekit/prd/scripts/base@<!-- include("/ver/scripts/base.js.ver") -->.js"></script>
	上线后变为：
	<script src="http://qunarzz.com/hotel_fekit/prd/scripts/base@d7dadc627df2c525fc695a60bcba9f18.js"></script>

**使用这种方案，因为没有缓存，所以在发布 app 项目后可以不重启即生效，但会增加io压力。**

##mapping 文件

fekit min 后会生成 /var/versions.mapping ，内容如：

	loader.js#fe769d38cb00b17ba0f1e9bd47c65711
	moduleA.js#74ee0c143d4c353b478652feaaea343c
	moduleB.js#a4ac5f422a22a41ac6efbf42e377de0f
	moduleC.js#817dc24c667eec004cab96b26a24256c

所以，使用 jsp/php 的项目，可以读取这个文件后形成一个 HashMap。 然后在页面中

	源码为：
	<script src="http://qunarzz.com/hotel_fekit/prd/scripts/base@<%=VERSION_MAP.get("loader.js")%>.js"></script>
	上线后变为：
	<script src="http://qunarzz.com/hotel_fekit/prd/scripts/base@d7dadc627df2c525fc695a60bcba9f18.js"></script>

**使用这种方案，一般都是在发布后先读取 versions.mapping 文件并缓存。 优点是没有 io压力， 但发布 app 后需要重新读取 versions.mapping。**