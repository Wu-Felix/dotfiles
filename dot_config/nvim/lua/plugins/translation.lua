--翻译软件
return {
  {
    "potamides/pantran.nvim",
    keys = { "<leader>fy" },
    config = function()
      local pantran = require("pantran")
      pantran.setup({
        -- Default engine to use for translation. To list valid engine names run
        -- `:lua =vim.tbl_keys(require("pantran.engines"))`.
        default_engine = "yandex",
        -- Configuration for individual engines goes here.
        engines = {
          yandex = {
            -- Default languages can be defined on a per engine basis. In this case
            -- `:lua require("pantran.async").run(function()
            -- vim.pretty_print(require("pantran.engines").yandex:languages()) end)`
            -- can be used to list available language identifiers.
            fallback = {
              default_source = "auto",
              default_target = "zh",
            },
            --测试
          },
        },
        controls = {
          mappings = {
            edit = {
              n = {
                -- Use this table to add additional mappings for the normal mode in
                -- the translation window. Either strings or function references are
                -- supported.
                ["j"] = "gj",
                ["k"] = "gk",
              },
              i = {
                -- Similar table but for insert mode. Using 'false' disables
                -- existing keybindings.
                ["<C-y>"] = false,
                ["<C-a>"] = require("pantran.ui.actions").yank_close_translation,
              },
            },
            -- Keybindings here are used in the selection window.
            select = {
              n = {
                -- ...
              },
            },
          },
        },
      })

      local opts = { noremap = true, silent = true, expr = true }
      vim.keymap.set("n", "<Leader>fy", pantran.motion_translate, opts)
      vim.keymap.set("n", "<leader>fyy", function()
        return pantran.motion_translate() .. "_"
      end, opts)
      vim.keymap.set("x", "<leader>fy", pantran.motion_translate, opts)
    end,
  },
}
