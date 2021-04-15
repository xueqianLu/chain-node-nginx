--[[local log = ngx.log
local cjson = require("cjson")
local chunk, eof = ngx.arg[1], ngx.arg[2]
local info = ngx.ctx.buf
chunk = chunk or ""
if info then
   ngx.ctx.buf = info .. chunk 
else
   ngx.ctx.buf = chunk
end
if eof then
   ngx.ctx.buffered = nil
   log(ngx.ERR, 'body :',ngx.arg[1])
   local body = cjson.decode(ngx.arg[1])
   log(ngx.ERR, 'post body :',body.result)
   if body.result==100 then
       body.result =269
       ngx.arg[1]=cjson.encode(body)
   else
   end
else
   ngx.arg[1] = nil 
end]]--
ngx.arg[1] = string.gsub(ngx.arg[1], "\"result\":\"100\"", "\"result\":\"269\"", 1);;
