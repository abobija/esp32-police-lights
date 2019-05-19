# esp32-police-lights
Police lights effect using ESP32

Using ESP32 for this kind of projects is obviously overkill but why not, let's play a little bit with LED's and Timers and sharpen our knowledge about Lua programming language.

## Usage
There is a interesting Lua class [`police-lights.lua`](https://github.com/abobija/esp32-police-lights/blob/master/police-lights.lua#L1) that I've written lately for making a LED dance choreography. All that is needed for making police lights effect is to pass a informations, to the `create` method, about blue and red LEDs PINs along with a choreography pattern, and  the Light Show can start.

## Demo
[![Police Lights Effect, police-lights.lua)](https://img.youtube.com/vi/Ao2iFeG7ehg/mqdefault.jpg)](https://www.youtube.com/watch?v=Ao2iFeG7ehg)

## Examples

Note: When all steps from the pattern are over, the pattern will be automatically restarted.

### Pattern 1

- Blue led ON, red led OFF. Hold that state for 100ms. Then both leds OFF for 50ms (default). Repeat that 3 times.
- Blue led OFF, and red led ON. Hold that state for 100ms. Then both leds OFF for 50ms (default). Repeat that 3 times.
- Both leds ON. Hold that state for 100ms. Then both leds OFF for 200ms. Repeat that 3 times.

```lua
require('police-lights').create({
    blue_pin = 12,
    red_pin  = 13,
    pattern  = {
        { blue = 1, red = 0, duration = 100, times = 3 },
        { blue = 0, red = 1, duration = 100, times = 3 },
        { blue = 1, red = 1, duration = 100, times = 3, off_duration = 200 }
    }
}).start()
```

### Pattern 2

- Both leds ON. Hold that state for 1 sec. Then both leds OFF for 1 sec.

```lua
require('police-lights').create({
    blue_pin = 12,
    red_pin  = 13,
    pattern  = {
        { blue = 1, red = 1, duration = 1000, off_duration = 1000 }
    }
}).start()
```

# Dependencies

- `gpio`
- `tmr`
