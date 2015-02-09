#Fekit 如何支持https开发
##引言
在开发中，可能会遇到 <https://qunarzz.com> 这样的需求，如何使用 fekit 进行开发呢

##下载证书文件
请先下载以下文件，并放到同一个目录中（比如 c:\cert\）

[server.crt](http://wiki.corp.qunar.com/download/attachments/56428798/server.crt?version=1&modificationDate=1398255579000 "server.crt") 和 [server.key](http://wiki.corp.qunar.com/download/attachments/56428798/server.key?version=1&modificationDate=1398255584000 "server.key")

##启动选项
fekit 在 0.2.63 版本支持 https，使用方式为：

	fekit server -s c:\cert\server.crt

##浏览器端
<https://qunarzz.com>， 直接访问可能会被拦截，因为证书不是被信任的，可以点击临时信任解决这个问题。

如果想永久解决，请按这个操作 [添加自签发的SSL证书为受信任的根证书](http://cnzhx.net/blog/self-signed-certificate-as-trusted-root-ca-in-windows/)

##问题
注意： 这个证书解决的是 qunarzz.com 域名，如果你的 https 是其它域名，你需要生成自己的证书。 请[参考](http://wangye.org/blog/archives/732/)

443端口被vmware-hostd.exe占用的问题可参考 <http://www.cnblogs.com/minideas/p/3559508.html>