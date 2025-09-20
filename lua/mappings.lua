require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- Generate getter and setter for private field of java class
function GenerateJavaGetterSetter()
  -- Only for Java files
  local filename = vim.api.nvim_buf_get_name(0)
  if not filename:match "%.java$" then
    print "Only works in Java files"
    return
  end

  local line = vim.api.nvim_get_current_line()

  -- Match private field with type and name
  local type, name = string.match(line, "%s*private%s+([%w<>%[%]]+)%s+([%w_]+)%s*;")
  if not type or not name then
    print "Invalid line: need private field with type and name"
    return
  end

  local capitalizedName = name:sub(1, 1):upper() .. name:sub(2)
  local getterName = "get" .. capitalizedName
  local setterName = "set" .. capitalizedName

  -- Create getter and setter block
  local block = {}
  table.insert(block, "") -- empty line
  table.insert(block, "public " .. type .. " " .. getterName .. "() {")
  table.insert(block, "    return this." .. name .. ";")
  table.insert(block, "}")
  table.insert(block, "")
  table.insert(block, "public void " .. setterName .. "(" .. type .. " " .. name .. ") {")
  table.insert(block, "    this." .. name .. " = " .. name .. ";")
  table.insert(block, "}")

  -- Insert below current line
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, false, block)
  print("Getter and setter generated for: " .. name)
end

-- Generate toString() method for classes in java
function GenerateJavaToString()
  -- Only for Java files
  local filename = vim.api.nvim_buf_get_name(0)
  if not filename:match "%.java$" then
    print "Only works in Java files"
    return
  end

  local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local fields = {}

  for _, line in ipairs(buf_lines) do
    line = line:match "^%s*(.-)%s*$" -- trim spaces

    -- Must end with ;, not contain '=' (initialization) or 'this.'
    if line:sub(-1) == ";" and not line:find "=" and not line:find "this%." and line ~= "" then
      -- Split line into words
      local words = {}
      for w in line:gmatch "%S+" do
        table.insert(words, w)
      end
      if #words >= 2 then
        local name = words[#words]:gsub(";$", "")
        table.insert(fields, name)
      end
    end
  end

  if #fields == 0 then
    print "No fields found in the class"
    return
  end

  local className = vim.fn.expand("%:t"):gsub("%.java$", "")
  local block = {}
  table.insert(block, "")
  table.insert(block, "@Override")
  table.insert(block, "public String toString() {")

  local str = 'return "' .. className .. '[" + '
  for i, name in ipairs(fields) do
    str = str .. '"' .. name .. '=" + ' .. name
    if i < #fields then
      str = str .. ' + ", " + '
    end
  end
  str = str .. ' + "]";'
  table.insert(block, "    " .. str)
  table.insert(block, "}")

  -- Insert below cursor
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, false, block)
  print "toString() generated for all fields"
end

vim.api.nvim_set_keymap("n", "<leader>js", ":lua GenerateJavaGetterSetter()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>jt", ":lua GenerateJavaToString()<CR>", { noremap = true, silent = true })
