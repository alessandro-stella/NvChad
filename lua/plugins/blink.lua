return {
  { import = "nvchad.blink.lazyspec" },
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.enabled = function()
        local ft = vim.bo.filetype
        local ext = vim.fn.expand "%:e"

        if ft == "markdown" or ft == "text" or ext == "pl" or ext == "txt" then
          vim.notify "Autocompletion disabled"
          return false
        end
        return true
      end
    end,
  },
}
