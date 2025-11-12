require "nvchad.options"

-- add yours here!

local o = vim.o
local opt = vim.opt

-- Disable visual line wrapping to prevent lines from breaking prematurely
o.wrap = false

-- Show cursor line highlighting for both screen line and line number
o.cursorlineopt = "both"

-- Enable absolute line numbers
o.number = true

-- Enable relative line numbers
o.relativenumber = true

-- Disable automatic line breaks when typing beyond a certain width
opt.textwidth = 0

-- Disable linebreak option which controls where lines break visually (only relevant if wrap is enabled)
opt.linebreak = false

-- Enable horizontal scrolling instead of wrapping when lines exceed screen width
opt.sidescroll = 1

-- Keep a margin of 5 columns when scrolling horizontally
opt.sidescrolloff = 5

-- Show at least 5 rows before and after the cursor
opt.scrolloff = 5

o.winborder = "single"
