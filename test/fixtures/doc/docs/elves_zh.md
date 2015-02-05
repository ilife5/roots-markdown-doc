# 使用elves测试avalon.oniui

> 简单轻量的测试工具

![elves](https://raw.githubusercontent.com/ilife5/life/master/statics/images/elf.jpg)

## 安装

### 从npm上获取

全局初始化，可用于命令行工具。

```
npm install elves -g
```

如果只是想用在本地的nodejs项目中。

```
npm install elves --save
```

## 用法


```
Usage: elves [options]
       elves [options] <config>
       elves [options] <caseUrl>
       elves [options] <caseUrl> <pageUrl>

Options:

-h, --help               output usage information
-V, --version            output the version number
-r, --remoteServer       take test on remote server
-c, --configFile <file>  config file path. Default is test/config.json
```

更多用法请查看[elves 中文文档](https://github.com/ilife5/elves/blob/master/README_zh.md)

## 环境要求

**elves**使用**Node**，基于**PhantomJs**模拟页面。在安装**elves**之前需要安装**Node**，**PhantomJs**及其依赖的环境。

### windows

+ Python

    [Python](http://www.python.org/getit/windows)( [python2.7.3](http://www.python.org/download/releases/2.7.3#download) )

+ .Net FrameWork

    XP系统请安装.Net FrameWork4.0

    Win7请安装.Net FrameWork4.5

+ Visual Studio

    XP系统请安装[Microsoft Visual Studio C++ 2010 Express](http://go.microsoft.com/?linkid=9709949)

    Win7系统请安装Microsoft Visual Studio C++ 2012 Express

+ node

    [nodejs.org/download](http://nodejs.org/download/)

    记得下载安装之后运行以下命令更新npm

    ```
npm install npm -g
    ```
+ PhantomJs

    下载[phantomjs-1.9.8-windows.zip](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-windows.zip)并解压。如果解压的目录为<code>C:\bin\phantomjs</code>，将<code>C:\bin\phantomjs</code>放入环境变量中。

    输入如下指令，测试phantomjs是否已经就绪

    ```
phantomjs --version
    ```


### Mac

+ XCode Command Line Tools

+ PhantomJs

    直接下载安装文件[ phantomjs-1.9.8-macosx.zip ](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-macosx.zip)

    使用brew

    ```
brew update && brew install phantomjs
    ```

    或者使用port

    ```
sudo port selfupdate && sudo port install phantomjs
    ```
+ node

    [nodejs.org/download](http://nodejs.org/download/)

    记得下载安装之后运行以下命令更新npm

    ```
npm install npm -g
    ```

## 测试avalon.oniui

avalon.oniui有多个组件，每个组件有多个demo，elves基于这些demo来做测试。case就放置于组件目录下。

```
accordion/
├── avalon.accordion.css
├── avalon.accordion.doc.html
├── avalon.accordion.ex1.case.js
├── avalon.accordion.ex1.html
├── avalon.accordion.ex2.case.js
├── avalon.accordion.ex2.html
├── avalon.accordion.html
├── avalon.accordion.js
└── avalon.accordion.scss
datepicker/
├── avalon.datepicker.css
├── avalon.datepicker.scss
├── avalon.datepicker.html
├── avalon.datepicker.doc.html
├── avalon.datepicker.ex1.case.js
├── avalon.datepicker.ex1.html
└── avalon.datepicker.js
```
如上，demo的文件为avalon.accordion.ex1.html，case文件为avalon.accordion.ex1.case.js。

elves内置了**jquery**， **mocha**， **chai**。在写case时可以使用这些库。avalon.accordion.ex1.case.js内容为：

```
var expect = chai.expect;

describe('accordion', function(){
    describe('accordion.ex1.html', function(){

        var vmodel = avalon.vmodels.aa,
            root = $("[avalonctrl=aa]"),
            triggers = $(".oni-accordion-header", root),
            panels = $(".oni-accordion-content", root);

        it('#data长度为2', function(){
            expect(vmodel.data.length).to.equal(2);
        });

        it('#data初始化时的第一项toggle为false', function(){
            expect(vmodel.data[0].toggle).to.equal(false);
        });

        it('#第一个面板初始化时的第一项为不可见', function(){
            expect(panels.eq(0).is(":visible")).to.equal(false);
        });

        it('#点击第一个选项卡后，data的第一项toggle为true', function(){

            //模拟点击第一个选项卡
            triggers.eq(0).simulate("click");
            expect(vmodel.data[0].toggle).to.equal(true);
        });

        it('#点击第一个选项卡后，第一个面板可见', function(){
            expect(panels.eq(0).is(":visible")).to.equal(true);
        });

        it('#点击第二个选项卡后，data的第二项toggle为false', function() {
            //模拟点击第二个选项卡
            triggers.eq(1).simulate("click");
            expect(vmodel.data[1].toggle).to.equal(false);
        });

        it('#点击第二个选项卡后，第二个面板不可见', function() {
            expect(panels.eq(1).is(":visible")).to.equal(false);
        });

    })
});

```

### 关于事件模拟

因为phantomJs中对事件的触发支持不够完整，需要借助第三方库（jquery.simulate.js）对事件进行模拟。如上例中

```
//模拟点击第一个选项卡
triggers.eq(0).simulate("click");
```

### 开始测试

安装完elves并准备好case之后，直接在**avalon.oniui**根目录执行

```
elves
```

即可以看到如下运行结果

```
[elves log]  Searching for *.case.js...
[elves log]  3 cases testing，


  accordion
    accordion.ex1.html
      ✓ #data长度为2
      ✓ #data初始化时的第一项toggle为false
      ✓ #第一个面板初始化时的第一项为不可见
      ✓ #点击第一个选项卡后，data的第一项toggle为true
      ✓ #点击第一个选项卡后，第一个面板可见
      ✓ #点击第二个选项卡后，data的第二项toggle为false
      ✓ #点击第二个选项卡后，第二个面板不可见


  7 passing (16ms)



  accordion
    accordion.ex1.html
      ✓ #初始化时面板第一项的文案为标题1
      ✓ #点击setData后，面板有四项，第一项的文案为new title 1


  2 passing (32ms)



  accordion
    accordion.ex1.html
      ✓ #初始化时datepicker的toggle属性为false
      ✓ #初始化时datepicker的日历选择框隐藏
      ✓ #点击日历框，此时的toggle属性为true
      ✓ #点击日历框，展开datepicker，日历选择框显示


  4 passing (17ms)
```

## 使用travis-ci做持续集成及自动化测试



### 启用项目

+ 使用github账号登录[travis-ci.org](https://travis-ci.org)

+ 在[项目列表](https://travis-ci.org/profile)中，找到avalon.oniui并点击右侧的开关启用项目。

+ 在项目根目录下添加**.travis.yml**文件

### 配置.travis.yml


+ 设置node环境及版本

    ```
language: node_js
node_js:
  - "0.10"
    ```
+ 在测试开始前安装elves

    ```
language: node_js
node_js:
  - '0.10'
before_install:
  - "npm install elves -g"

    ```

+ 设置测试命令

    travis在node项目中默认使用<code>npm test</code>作为测试命令。

    在package.json中，添加测试脚本。

    ```
"scripts": {
    "test": "elves"
}
    ```