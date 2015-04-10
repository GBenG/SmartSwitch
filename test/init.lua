wifi.sta.disconnect()
wifi.setmode(wifi.STATION);
wifi.ap.config({ssid="Shulyavka",pwd="0989021204!"});
wifi.sta.connect()

print(wifi.sta.getip())

gpio.mode(4, gpio.OUTPUT);
gpio.write(4, gpio.LOW);
gpio.mode(3,gpio.INPUT,gpio.PULLUP);

srv=net.createServer(net.TCP) 
srv:listen(80,function(conn) 
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then 
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP"); 
        end
        local _GET = {}
        if (vars ~= nil)then 
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do 
                _GET[k] = v 
            end 
        end
        buf = buf.."<html><head><title>SPS::LED</title></head><body><h1>SPS LED Control</h1><form src=\"/\">Turn PIN <select name=\"pin\" onchange=\"form.submit()\">";
        local _on,_off = "",""
        if(_GET.pin == "ON")then
              _on = " selected=true";
              gpio.write(4, gpio.HIGH);
        elseif(_GET.pin == "OFF")then
              _off = " selected=\"true\"";
              gpio.write(4, gpio.LOW);
        end
        buf = buf.."<option".._on..">ON</opton><option".._off..">OFF</option></select></form></body></html>";
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)

print(wifi.sta.getip())