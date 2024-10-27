return {
  {
    -- amongst your other plugins
    {
      "akinsho/toggleterm.nvim",
      version = "*",
      config = function()
        require("toggleterm").setup({
          open_mapping = [[<c-\>]],
          -- 打开新终端后自动进入插入模式
          start_in_insert = true,
          -- 在当前buffer的下方打开新终端
          direction = "float",
          shade_filetypes = { "none", "fzf" },
        })

        local Terminal = require("toggleterm.terminal").Terminal
        local btm = Terminal:new({
          cmd = "btm",
          dir = "git_dir",
          direction = "float",
          float_opts = {
            border = "double",
          },
          -- function to run on opening the terminal
          on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
          end,
          -- function to run on closing the terminal
          on_close = function(term)
            vim.cmd("startinsert!")
          end,
        })

        function _btm_toggle()
          btm:toggle()
        end

        local gdu = Terminal:new({
          cmd = "gdu",
          dir = "git_dir",
          direction = "float",
          float_opts = {
            border = "double",
          },
          -- function to run on opening the terminal
          on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
          end,
          -- function to run on closing the terminal
          on_close = function(term)
            vim.cmd("startinsert!")
          end,
        })

        function _gdu_toggle()
          gdu:toggle()
        end
        vim.api.nvim_set_keymap("n", "<leader>btm", "<cmd>lua _btm_toggle()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>gdu", "<cmd>lua _gdu_toggle()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
      end,
    },
  },
}
