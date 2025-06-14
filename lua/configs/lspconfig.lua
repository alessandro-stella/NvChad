require("nvchad.configs.lspconfig").defaults()

local servers = {
  "clangd",
  "css-lsp",
  "eslint-lsp",
  "html-lsp",
  "jdtls",
  "json-lsp",
  "lua-language-server",
  "pyright",
  "selene",
  "tailwindcss-language-server",
  "vtsls",
  "yaml-language-server",
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
