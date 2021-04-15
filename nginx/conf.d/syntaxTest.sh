basedir=$PWD/../../../openresty
docker run --rm -it -v $basedir/nginx/logs:/usr/local/openresty/nginx/logs -v $basedir/nginx/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf -v $basedir/nginx/lua:/usr/local/openresty/nginx/lua -v $basedir/nginx/conf.d:/etc/nginx/conf.d openresty/openresty openresty -t
