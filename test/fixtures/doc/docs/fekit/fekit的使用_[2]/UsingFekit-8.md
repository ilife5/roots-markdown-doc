#使用Fekit gist来管理你的代码片断
##fekit gist 是干什么用的？
- 当你为自己的技术分享写了一个demo，但它依赖很多js,css,image等文件，找不到地方放，怎么办？
- 当你希望有一个地方专门管理自己的代码片断，但是申请机器不靠谱，又没有比较合适的办法，怎么办？
- 当你希望有一个既提供http服务，又非常方便的支持上传下载，怎么办？
- 当你写了一个README.md，但是需要把它以编译方式show给别人看，怎么办？

以上一切，就是 fekit gist 主要解决的问题。

##fekit gist 如何工作？
请访问 <http://gist.corp.qunar.com>

- 专用域名
- 以用户名作为专用空间
- 你可以看别人的项目，但不能修改和下载
- 你可以把别人的项目克隆到自己目录中
- 自定义的编译模式，比如 .md<br/>
	编译版本: <http://gist.corp.qunar.com/hao.lin/README.md><br/>
	源码版本: <http://gist.corp.qunar.com/raw/hao.lin/README.md>

##如何使用
###安装
	npm install fekit-extension-gist -g

安装完后，在命令行输入fekit看看有没有gist指令，如果没有，需要如下操作：

**创建文件**

 	~/.fekit/.extensions/gist.js

文件内容是：

	exports.version = '0.0.6';
	exports.path = '/usr/local/lib/node_modules/fekit-extension-gist/index.js';

**注册用户**

首先需要有2个前提：<br/>
1. 请先用 fekit login 登录，如果已经登录就不用再做这步了<br/>
2. 需要在 l-registry.fe.dev.cn6 这台机器上有帐号，请用 cloud.corp.qunar.com 申请
确认好这2点后，只要

	fekit gist --register

就可以了。

###上传某个目录

假设在 /home/hao.lin/demo1 有这么个目录，其中有你写的代码：

	cd /home/hao.lin/demo1
	fekit gist
	[LOG] 上传 /home/hao.lin/demo1 至 http://gist.corp.qunar.com/hao.lin/demo1
	[ASK] 是否确认? (yes/no):

输入 y 或 yes 即可上传。

###下载某个目录

	fekit gist http://gist.corp.qunar.com/hao.lin/demo1

即可将 demo1 目录下载到当前目录中

###删除线上目录

	fekit gist -d http://gist.corp.qunar.com/hao.lin/demo1

###克隆别人的项目

	fekit gist -c http://gist.corp.qunar.com/hao.lin/demo1

当然不能克隆自己的项目哦！

###清空自己的线上目录！！

	mkdir empty_dir && cd empty_dir && fekit gist.

该方法基本上毁灭性质的，一旦操作基本不能恢复！！

###实现原理

其实基本上是使用了 rsync 的同步的功能。 所以你机器上一定要有 rsync 才能用哦！