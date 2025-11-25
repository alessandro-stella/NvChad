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
        enable = true, -- Abilita il rendering generale di LaTeX
        inline = {
          enable = true, -- Abilita la matematica inline ($...$)
        },
        block = {
          enable = true, -- Abilita i blocchi matematici ($$...$$)
          -- Puoi personalizzare l'aspetto del blocco se vuoi (opzionale)
          -- text = { "  LaTeX ", "Special" },
        },
      },
    }
  end,
}
