#Fekit 中使用 domain_mapping 分散 css 中背景图片域名
*一句话*

##配置格式

	{
	    "domain_mapping": "原域名1 原域名2 原域名3 => 新域名1 新域名2 新域名3"
	}

##方式一：文件级（单页面适用）
配置在 fekit.config 的 export 节点中：

	{
	    "export": [{
	        "path": "index.css",
	        "domain_mapping": "source.qunar.com => simg1.qunarzz.com simg2.qunarzz.com simg3.qunarzz.com"
	    }]
	}

##方式二：频道全局级（推荐）
配置在 fekit.config 的 export_global_config 节点中：

	{
	    "export_global_config": {
	        "domain_mapping": "source.qunar.com => simg1.qunarzz.com simg2.qunarzz.com simg3.qunarzz.com"
	    }
	}

优先级：文件级>频道全局级

##本地开发调试
只要启动了fekit server，剩下的都是自动滴。

##开发机host

	127.0.0.1 quanrzz.com # 或者任何一台你喜欢的qzz开发机IP
	192.168.237.71 source.qunar.com simg1.qunarzz.com simg2.qunarzz.com simg3.qunarzz.com simg4.qunarzz.com