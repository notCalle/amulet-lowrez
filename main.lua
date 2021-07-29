noglobals()

local window = require'lowrez'.window{
  width = 64,
  height = 64,
  physical_size = vec2(64*8, 64*8),
  clear_color = vec4(.5,0,.5,1),
  title = "Hello LowRez"
}

am.load_script'hello.lua'(window)
