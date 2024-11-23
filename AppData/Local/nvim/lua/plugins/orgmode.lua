return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    opts = {
      org_agenda_files = "~/OneDrive/orgfiles/**/*",
      org_default_notes_file = "~/OneDrive/orgfiles/refile.org",
      org_todo_keywords = { "TODO(t)", "NEXT", "|", "DONE" },
      ui = {
        folds = {
          colored = false,
        },
      },
      org_startup_folded = "inherit",
    },
    -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
    -- add ~org~ to ignore_install
    -- require("nvim-treesitter.configs").setup({
    --   ensure_installed = "all",
    --   ignore_install = { "org" },
    -- })
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "org" },
    opts = {
      markdown = {
        headline_highlights = false,
      },
    },
  },
}
