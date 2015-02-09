#部署（Rbuild）
*一段介绍的话*
##开发机
**修改配置文件：**

	sudo vim /home/q/nginx/conf/nginx.conf
**在nginx配置中加入：**

	worker_processes  1;
	
	pid     logs/nginx.pid;
	
	events {
	    worker_connections          1024;
	}
	
	http {
	    
	
	    include             mime.types;
	    default_type        application/octet-stream;
	    sendfile            on;
	    keepalive_timeout   65;
	    gzip  on;
	
	    server {
	        listen 443;
	        server_name                 qunarzz.com;
	        ssl on;
	        ssl_certificate             /home/q/nginx/conf/qunarzz.com.crt;
	        ssl_certificate_key         /home/q/nginx/conf/qunarzz.com.key;
	        ssl_session_timeout         5m;
	        ssl_protocols               TLSv1;
	        ssl_ciphers                 ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP;
	        ssl_prefer_server_ciphers   on;
	
	        root            /home/q/www/qunarzz.com;
	        concat          on;
	        
	        location ~ /prd/ {
	            #for fekit
	            rewrite ^(.*/)prd(/.*)@(\w+)\.(js|css)$ $1dev$2@dev.$4 last;  
	            #for qzz
	            rewrite ^(.*/)prd(/.*)-(\d+)\.(js|css)$ $1dev$2-dev.$4 last;
	        }
	        
	        location ~ /dev/ {
	            expires -1;
	            rewrite ^(.*?)-(\d+|[\d\.]+)\.(js|css)$ $1-dev.$3 last;
	        }
	
	    }
	
	    server {
	        listen          80;
	        server_name     qunarzz.com;
	        root            /home/q/www/qunarzz.com;
	        concat          on;
	
	        location ~ /prd/ {
	            #for fekit
	            rewrite ^(.*/)prd(/.*)@(\w+)\.(js|css)$ $1dev$2@dev.$4?_$3 last;
	            #for qzz
	            rewrite ^(.*/)prd(/.*)-(\d+)\.(js|css)$ $1dev$2-dev.$4 last;
	        }
	        
	        location ~ /dev/ {
	            expires -1;
	            rewrite ^(.*?)-(\d+|[\d\.]+)\.(js|css)$ $1-dev.$3 last;
	        }
	
	        error_page 404 = @fallback;
	        location  @fallback {
	            access_log logs/404.logs;
	            add_header X-Dev "true";
	            proxy_pass http://qunarzz.com;
	        }
	    }
	
	    server {        
	        listen		80;
		    server_name	qzz.dev.qunar.com;
	
	    	location / {
	    		add_header X-Dev "true";
	    		proxy_pass http://127.0.0.1;
	    		proxy_set_header Host qunarzz.com;
	    	}
	    }
	
	
	    server {
	    	listen	80;
	    	server_name source.qunar.com simg1.qunarzz.com simg2.qunarzz.com simg3.qunarzz.com simg4.qunarzz.com;
	    	add_header Access-Control-Allow-Origin *;
	
	    	location / {
	    	    proxy_intercept_errors on;
	    	    root /home/q/www/source.qunar.com;
	    	    error_page 404 = @fallback;
	    	}
	    	
	    	location @fallback {
	    	    proxy_set_header	Host	$host;
	    	    add_header    X-Dev	"true";
	    	    proxy_pass http://source.qunar.com;
	    	    access_log logs/fallback_404.log;
	    	}
	    }
	}
**重新加载配置：**

	sudo kill -HUP \`ps aux | grep nginx | grep master | awk '{print $2;}'\` 
##组件源重启
**登录 fekit.corp.qunar.com**

	启动nginx: sudo service nginx restart
	启动couchdb: sudo service couchdb restart
	启动server:  sudo pm2 restart fekit-package-server
	启动www: sudo pm2 restart fekit-package-www
##qzz dns 部署
**依赖 node , npm , nginx**

**安装 node 前的环境**

	sudo yum install gcc gcc-c++ automake autoconf libtoolize make
**安装 emergency-dns-server**

	sudo npm install emergency-dns-server -g
	sudo npm install iced-coffee-script -g
**启动 emergency-dns-server**

	sudo ednsd qunarzz.com:a:192.168.236.249 -u 192.168.101.18 &
	# 192.168.236.249 是光宇配置的 qzz 动态选择器
	# 192.168.101.18 是公司内部DNS
**然后需要配置自己机器的DNS**

