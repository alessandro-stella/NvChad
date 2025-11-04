require("nvchad.configs.lspconfig").defaults()

local servers = {
  "clangd",
  "cssls",
  "eslintls",
  "htmlls",
  "jsonls",
  "lua-language-server",
  "pyright",
  "selene",
  "tailwindcss-language-server",
  "vtsls",
  "yaml-language-server",
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
