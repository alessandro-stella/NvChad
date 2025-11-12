require "nvchad.autocmds"

-- Show dashboard on last buffer close
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.schedule(function()
        vim.cmd "Nvdash"
      end)
    end
  end,
})

-- Configure jdtls for java projects
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function(_)
    require("configs.jdtls_setup"):setup()
  end,
})

-- Change tab from spaces to actual tab for text files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "text", "conf", "" },
  callback = function()
    vim.opt.expandtab = false
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.softtabstop = 0
  end,
})

-- Add rounded borders to popup
vim.api.nvim_create_autocmd("WinNew", {
  callback = function()
    local ok, win = pcall(vim.api.nvim_get_current_win)
    if not ok then
      return
    end

    local ok_buf, buf = pcall(vim.api.nvim_win_get_buf, win)
    if not ok_buf then
      return
    end

    local buftype = vim.bo[buf].buftype
    if buftype ~= "nofile" and buftype ~= "terminal" and buftype ~= "prompt" then
      return
    end

    local config = vim.api.nvim_win_get_config(win)
    if config.relative == "" then
      return
    end

    config.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
    vim.api.nvim_win_set_config(win, config)
  end,
})
