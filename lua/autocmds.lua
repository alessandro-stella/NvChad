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
