local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local config = {}

local function resolve_dimensions()
  local width = config.width
  local height = config.height

  if not width and config.width_ratio then
    width = math.floor(vim.o.columns * config.width_ratio)
  end
  if not height and config.height_ratio then
    height = math.floor(vim.o.lines * config.height_ratio)
  end

  width = width or math.floor(vim.o.columns * 0.8)
  height = height or math.floor(vim.o.lines * 0.8)

  return width, height
end

local function create_floating_window()
  local width, height = resolve_dimensions()

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = vim.api.nvim_create_buf(false, true)

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window()
    vim.cmd.terminal()

    vim.cmd "startinsert"
  else
    if vim.api.nvim_buf_is_valid(state.floating.buf) then
      vim.api.nvim_buf_delete(state.floating.buf, { force = true })
    end
    if vim.api.nvim_win_is_valid(state.floating.win) then
      vim.api.nvim_win_close(state.floating.win, true)
    end
    state.floating = { buf = -1, win = -1 }
  end
end

local M = {}

M.setup = function(opts)
  config = opts or {}
  vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
end

return M
