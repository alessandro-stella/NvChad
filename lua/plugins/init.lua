return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = function()
      require("todo-comments").setup()
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>tt",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>tT",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>ts",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>tl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>tL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>tQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
  },

  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = { { "roobert/tailwindcss-colorizer-cmp.nvim", config = true } },
    opts = function(_, opts)
      opts.formatting = {
        format = require("tailwindcss-colorizer-cmp").formatter,
      }
    end,
  },

  -- Disable useless snippets
  { "rafamadriz/friendly-snippets", enabled = false },

  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufReadPost",
    config = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require("ufo").setup {
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
      }
    end,
  },

  { "mfussenegger/nvim-jdtls" },

  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.icons").setup()
    end,
  },

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
