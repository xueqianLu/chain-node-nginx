basedir=$PWD/../openresty
docker run --privileged=true --restart=always  --net=host  --name openresty -v $basedir/nginx/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf -v $basedir/run:/var/run/openresty -v $basedir/nginx/lua:/usr/local/openresty/nginx/lua -v $basedir/nginx/conf.d:/etc/nginx/conf.d -v $basedir/nginx/logs:/usr/local/openresty/nginx/logs -it openresty/openresty
