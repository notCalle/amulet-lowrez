--- Amulet setup module for LowRez rendering
--
-- @see https://amulet.xyz
-- @module lowrez
-- @usage
-- > local lowrez = require'lowrez':new{...}
-- ... options are, with defaults:
-- show_perf_stats = false      -- debug overlay
-- width = 64                   -- lowrez 4K pixel display
-- height = 64                  -- lowrez 4K pixel display
-- scale = 8                    -- scale factor for initial window size
-- clear_color = vec4(0,0,0,1)  -- display background color
--
-- Optionally, call lowrez:window{...} to configure am.window options for the
-- singleton window.
--
-- Activate your scene graph by calling lowrez:activate{...} with the contents
-- for an am.group{...} that will be rendered under the lowrez constraints.
--
-- lowrez.scene contains the root group with your scene graph
--
-- You can pick tagged nodes from your graph by calling lowrez'tag'
--
-- lowrez:load'name' will require the module 'name', call its module:init
-- function if it exists, and then activate the scene graph in module.scene
--
-- @author Calle Englund &lt;calle@discord.bofh.se&gt;
-- @copyright &copy; 2019 Calle Englund
-- @license
-- The MIT License (MIT)
--
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
--
-- The above copyright notice and this permission notice shall be included
-- in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

local lowrez = ...

local _default = {
  width = 64,
  height = 64,
  scale = 8
}

local window = {}

function window:new(...)
  local opts = table.shallow_copy(_default)
  table.merge(opts, ... or {})

  local new = { scale = opts.scale }

  opts.physical_size = vec2(opts.width, opts.height) * opts.scale
  opts.scale = nil
  new[window] = am.window(opts)

  return setmetatable(new, self)
end

function window:__index(k)
  local f = rawget(window, "__get_" .. k)
  return f and f(self) or self[window][k]
end

function window:__newindex(k, v)
  local f = rawget(window, "__set_" .. k)
  if f then
    f(self, v)
  else
    self[window][k] = v
  end
end

function window:__get_scene()
  return self[window].scene'lowrez'
end

function window:__set_scene(scene)
  self[window].scene = am.postprocess(self[window]) ^ scene:tag'lowrez'
end

function lowrez.window(...)
  return window:new(...)
end
