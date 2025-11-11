local options = {
  forge = {
    command = "forge",
    args = { "fmt", "--stdin" }, -- Usa stdin per lavorare con conform.nvim
  },

  formatters_by_ft = {
    lua = { "stylua" },
    solidity = { "forge" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
