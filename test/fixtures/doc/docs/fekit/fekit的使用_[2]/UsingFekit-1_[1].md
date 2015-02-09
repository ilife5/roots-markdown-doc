#使用Fekit代理

##为什么要使用fekit代理

使用代理可以截获任意请求，并把它改成你想要的内容或转发到其它服务器，过程如下：

请求www.163.com ----> |浏览器| ----> |fekit proxy| -----> |线上|

经过fekit proxy时，可以把 www.163.com 截获下来。

##如何使用
###最低版本要求
0.2.87

###配置 ~/fekit.hosts

	# 与一般的 hosts 配置一样
	127.0.0.1 qunarzz.com 
	
	# 可以将其它请求截获，由本地处理
	proxy_pass http://www.baidu.com/(.*)\.do http://127.0.0.1/123/baidu/$1.html

###使用

第一步：
fekit server -o 启动后会有log
[LOG] fekit proxy server 运行成功, 端口为 10180.

第二步：
将浏览器的代理服务器设置，设置为 127.0.0.1 ，端口是10180 即可