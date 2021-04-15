string.replace = function(s, pattern, repl)
    local i,j = string.find(s, pattern, 1, true)
    if i and j then
        local ret = {}
        local start = 1
        while i and j do
            table.insert(ret, string.sub(s, start, i - 1))
            table.insert(ret, repl)
            start = j + 1
            i,j = string.find(s, pattern, start, true)
        end
        table.insert(ret, string.sub(s, start))
        return table.concat(ret)
    end
    return s
end
function read_from_file(file_name)
  local f = assert(io.open(file_name, "r"))
  local string = f:read("*all")
  f:close()
  return string
end
function reset_post_body()
    local cjson = require "cjson";
    local request_method = ngx.var.request_method;

    local args = nil;
    if "GET" == request_method then
        args = ngx.req.get_uri_args();
        ngx.log(ngx.ERR, 'get data:', cjson.encode(args ));
    elseif "POST" == request_method then
        ngx.req.read_body();
        args = ngx.req.get_post_args();
        ngx.log(ngx.ERR, 'post data:', cjson.encode(args) );
    end

    ngx.req.read_body();
    local request_body = ngx.req.get_body_data();
    if request_body ==nil then 
       local body_file = ngx.req.get_body_file();
       if body_file then
       request_body= read_from_file(body_file);
        --[[local request_data = cjson.decode(request_body);
       request_data.method=string.gsub(request_data["method"], "eth_", "hpb_", 1);
       request_data.method=string.gsub(request_data["method"], "hpb_chainId", "net_version", 1);
       local json_data = cjson.encode(request_data); 
       ngx.log(ngx.ERR, 'json_data :', json_data);]]--

       local json_data=string.replace(request_body, '"method":"eth_', '"method":"hpb_', 1);
       json_data=string.replace(json_data, '"method":"hpb_chainId', '"method":"net_version', 1);
       
       ngx.req.set_body_data(json_data);
       else
          ngx.log(ngx.ERR, 'post data:', request_body);
       end
    else
       --[[local request_data = cjson.decode(request_body);
       request_data.method=string.gsub(request_data["method"], "eth_", "hpb_", 1);
       request_data.method=string.gsub(request_data["method"], "hpb_chainId", "net_version", 1);
       local json_data = cjson.encode(request_data);
       ngx.log(ngx.ERR, 'json_data :', json_data); ]]--

       local json_data=string.replace(request_body, '"method":"eth_', '"method":"hpb_', 1);
       json_data=string.replace(json_data, '"method":"hpb_chainId', '"method":"net_version', 1);
       

       ngx.req.set_body_data(json_data);
    end
end
return reset_post_body();
