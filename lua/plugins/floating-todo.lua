return {
  "alessandro-stella/floating-todo.nvim",
  lazy = false,
  config = function()
    require("floating-todo").setup { target_file = "~/todo.md" }

    vim.keymap.set("n", "<leader>td", ":Td<CR>", { desc = "Open ToDo", silent = true })
  end,
}
