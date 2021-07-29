# amulet-lowrez
[Amulet] setup module for LowRez rendering

## usage
In your `main.lua` for an [Amulet] project:
```lua
local lowrez = require'lowrez'

local window = lowrez.window{ ... }
```

`...` options are, with defaults:
- `width = 64`                   -- lowrez 4K pixel display
- `height = 64`                  -- lowrez 4K pixel display
- `scale = 8`                    -- scale factor for initial window size
- `clear_color = vec4(0,0,0,1)`  -- display background color

Setting `.scene` on a `lowrez.window` works just like a regular `window`, but
also takes care of postprocessing for proper pixelated scaling.

```lua
am.load_script'hello.lua'(window)
```

[Amulet]: https://www.amulet.xyz
