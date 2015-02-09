#在 Fekit 环境中使用 velocity

##要解决的问题

将velocity(vm)的代码放到前端项目(qzz)中，并且解决发布联调的问题。

##为什么要这么做

- 前端工程师可以在项目中直接写 vm 模板
- 可以做以前做不到的事情，比如将 js 压缩后放到页面中
- 等等

##前提条件

- 需要升级fekit至 0.2.85
- 如果想看看后端是如何工作，必须安装java,maven，以及把maven按照公司的settings.xml进行设置

##DEMO
直接上实例：

前端项目: git@gitlab.corp.qunar.com:fe/q_dvelocity.git

后端项目: git@gitlab.corp.qunar.com:scmtest/dvelocity_web.git

###DEMO如何联调

DEMO要展示的，是在前端项目中针对 vm 目录中的修改如何同步到后端项目中。

###前端

执行 fekit pack && fekit sync, 这时 sync 会将你的代码上传到nexus仓库, 但前端可以完全不用关心这点。

###后端

执行 mvn clean package -Dmaven.test.skip=true -U

仔细观查 src/main/webapp/WEB-INF/refs/vm 中的内容，就是前端项目的内容

##如何实现的？

###[前端] refs
fekit.config 中，新增 refs 配置。 refs是个特殊目录，它是自动生成的，在部署的时候，它会按配置部署到后端项目中。 

关于配置，可以参考[官网的配置项说明](https://github.com/rinh/fekit#fekitconfig)

###[前端] pom.xml 中的版本号
在 pom.xml 有以下内容

	<!--version由bds生成的btag/rtag来决定-->
	<version>1.0.2-dev-SNAPSHOT</version>

其中 version 的内容，是在创建分支的时候，自动填写的。 所以它一般应该是*分支名-SNAPSHOT*，无需手动更改。

###[前端] fekit sync 变慢了
在 sync 的时候，发现会变慢。 其实是将代码上传到nexus仓库了。

###[后端] pom.xml 中的配置
基本没有变化，依照 [CM给的配置](http://wiki.corp.qunar.com/pages/viewpage.action?pageId=51547519) 即可。

###[后端] 如何得到前端的vm内容
让前端同学 fekit pack && fekit sync ，然后确认\*分支名-SNAPSHO\*填写正确，执行 mvn clean package -Dmaven.test.skip=true -U 即可。