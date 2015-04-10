wifi.sta.disconnect();
wifi.setmode(wifi.STATION);
wifi.ap.config({ssid="Shulyavka",pwd="0989021204!"});
wifi.sta.connect();

print(wifi.sta.getip());

gpio.mode(4, gpio.OUTPUT);
gpio.write(4, gpio.LOW);

gpio.mode(3,gpio.INPUT,gpio.PULLUP);

tmr.alarm(0,200,1,function()

local v = gpio.read(3);

if (v == 0) then
    gpio.write(4, gpio.HIGH);
    print("ON");
  else 
    gpio.write(4, gpio.LOW);
    print("OFF");
end

end)