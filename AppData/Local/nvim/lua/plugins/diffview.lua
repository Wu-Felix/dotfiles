return {
  "sindrets/diffview.nvim",
  lazy = false,
  keys = {
    { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen" },
    {
      "<leader>dvf",
      "<cmd>DiffviewFileHistory %<cr> ",
      desc = "DiffviewFileHistory",
    },
    { "<leader>dvs", "<cmd>DiffviewOpen --untracked-file<cr>", desc = "DiffviewOpen staged" },
  },
}
