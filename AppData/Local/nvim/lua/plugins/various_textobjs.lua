--动态选择
return {
  {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
      require("various-textobjs").setup({
        useDefaultKeymaps = true,
        lookForwardLines = 10,
      })
      -- example: `an` for outer subword, `in` for inner subword
      vim.keymap.set({ "o", "x" }, "aS", function()
        require("various-textobjs").subword(false)
      end)
      vim.keymap.set({ "o", "x" }, "iS", function()
        require("various-textobjs").subword(true)
      end)
    end,
  },
}
