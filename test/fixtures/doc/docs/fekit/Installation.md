#Fekit安装

*一段总结的话*

##前置环境
###Windows系统下前置环境准备

1. 安装 git bash,下载本地后执行； [[git下载](http://git-scm.com/download/)]
2. 安装 rsync,下载本地后解压到 c:\windows\system32(如果没权限，就解压到c:\rsync。 然后在环境变量的 Path 中，添加 ;c:\rsync;)； [[rsync下载](http://rsync.samba.org/)]
3. 安装svn； [[svn下载](http://tortoisesvn.net/downloads.html)]
4. 设置环境变量，右键 我的电脑->系统属性->高级->环境变量->系统变量，点击新建。变量名为 LANG 变量值为 en_US。

安装 git bash 后，查看桌面会出现 git bash 图标，双击打开，今后所有命令行操作均在此执行。


检查是否安装正确，请在 git bash 中调用 svn \ rsync 查看是否正确执行即可。
(打开 git bash，输入 svn ，回车，只要不报"找不到程序“之类的错误，就算正确。 rsync同理)

###MAC与Linux系统下前置环境准备
安装 svn, rsync, ssh

##Node.js安装
<http://nodejs.org/download/> 下载对应系统的安装文件进行安装

注：ubuntu下使用如下命令也可以安装node哦

    sudo apt-get install nodejs-legacy npm(注意不是node哦，而是nodejs-legacy)

##安装Fekit
先安装 node.js（至少要在0.10以上）<http://nodejs.org/download/>

    sudo npm install fekit -g

可能遇到的问题:

* 使用qzz shell的同学请更新 bin 这个目录，确保其中内容是 svn 最新版（最新已经在bin中取消 node.exe 及 npm.exe）

##安装Fekit扩展（不必须）
###安装

**check:** 检查项目文件使用

    npm install fekit-extension-check -g

**hf:** header&footer项目使用

    npm install fekit-extension-hf -g

**svn:** svn操作扩展

    npm install fekit-extension-svn -g

###注意事项
非windows，安装时需要注意权限。

如果出现：
*sh: node: Permission denied*  
这样的提示，请使用：

    npm config set user 0
    npm config set unsafe-perm true
