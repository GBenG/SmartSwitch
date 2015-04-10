wifi.sta.disconnect()
wifi.setmode(wifi.STATION);
wifi.ap.config({ssid="Shulyavka",pwd="0989021204!"});
wifi.sta.connect()
print(wifi.sta.getip())

gpio.mode(4, gpio.OUTPUT)
gpio.mode(3, gpio.INPUT)

function down()
  tmr.alarm(100, 1, function()
    timer = timer + 1
    -- ok
    if gpio.read(3) == 1 then
      print(timer)
      tmr.stop()
      if timer < 20 then
        switch()
      else
        -- ...
      end
      timer = 0
	  gpio.write(4, gpio.LOW);
    end
    tmr.wdclr()
  end)
end
gpio.trig(3, "down", function (gp)
  if timer == 0 then
    timer = 1
	gpio.write(4, gpio.HIGH);
    down()
  end  
end)