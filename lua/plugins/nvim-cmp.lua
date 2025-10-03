return {
  "hrsh7th/nvim-cmp",
  lazy = false,
  dependencies = { { "roobert/tailwindcss-colorizer-cmp.nvim", config = true } },
  opts = function(_, opts)
    opts.formatting = {
      format = require("tailwindcss-colorizer-cmp").formatter,
    }
  end,
}
