--[[
    Title          : Simulating police lights effect
    Author         : Alija Bobija
    Author-Website : https://abobija.com
    GitHub Repo    : https://github.com/abobija/esp32-police-lights
]]

require('police-lights').create({
    blue_pin = 12,
    red_pin  = 13,
    pattern  = {
        { blue = 1, red = 0, duration = 100, times = 3 },
        { blue = 0, red = 1, duration = 100, times = 3 },
        { blue = 1, red = 1, duration = 100, times = 3, off_duration = 200 }
    }
}).start()