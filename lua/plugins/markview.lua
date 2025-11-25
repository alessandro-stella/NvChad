return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  dependencies = {
    "saghen/blink.cmp",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("markview").setup {
      latex = {
        enable = true,
        inline = {
          enable = true,
        },
        block = {
          enable = true,
        },
      },
    }
  end,
}
