--[[
    Title          : Police lights simulator class
    Author         : Alija Bobija
    Author-Website : https://abobija.com
    GitHub Repo    : https://github.com/abobija/esp32-police-lights
    
    Dependencies:
        - gpio
        - tmr
]]

local PoliceLights = {}

PoliceLights.create = function(config)
    local self = {
        blue_pin = config.blue_pin,
        red_pin  = config.red_pin,
        pattern  = config.pattern
    }

    gpio.config({ gpio = self.blue_pin, dir = gpio.IN_OUT })
    gpio.config({ gpio = self.red_pin,  dir = gpio.IN_OUT })

    local function turn_off()
        gpio.write(self.blue_pin, 0)
        gpio.write(self.red_pin, 0)
    end

    -- Turn off both lights on startup
    turn_off()

    local step_index  = 0
    local count_down  = 0
    local step_finish = 0

    local function do_step(timer)
        local step = nil

        -- If step has finished lets turn off lights for certain amount of time
        -- Duration of this time is configurable with pattern step property "off_duration"
        -- Default off_duration is 50 ms
        if step_finish == 1 then
            step = self.pattern[step_index]
            turn_off()
            
            local off_interval = 50

            if step.off_duration ~= nil then
                off_interval = step.off_duration
            end
            
            timer:interval(off_interval)
            step_finish = 0

        -- Else if next step needs to start, lets apply light states
        else
            if count_down > 0 then
                count_down = count_down - 1
            else
                step_index = step_index + 1
                
                if step_index > #self.pattern then
                    step_index = 1
                end

                step = self.pattern[step_index]

                if step.times ~= nil then
                    count_down = step.times - 1
                end
            end

            if step == nil then
                step = self.pattern[step_index]
            end
    
            gpio.write(self.blue_pin, step.blue)
            gpio.write(self.red_pin, step.red)
    
            timer:interval(step.duration)
            step_finish = 1
        end

        timer:start()
    end
    
    self.start = function()
        local timer = tmr.create()
        timer:register(1000, tmr.ALARM_SEMI, do_step)
        do_step(timer)
    end
    
    return self
end

return PoliceLights