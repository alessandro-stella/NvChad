require("nvchad.configs.lspconfig").defaults()

local servers = {
  "clangd",
  "cssls",
  "eslint",
  "html",
  "jsonls",
  "lua_ls",
  "pyright",
  "tailwindcss",
  "vtsls",
  "yamlls",
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
