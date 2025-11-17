local M = {}

M.override_telescope_colors = function()
  local border_color = get_hypr_border_color() or "#FFFFFF" -- fallback bianco

  vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = border_color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = border_color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = border_color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = border_color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = border_color, bg = "NONE" })
end

return M
