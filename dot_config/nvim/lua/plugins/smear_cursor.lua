return {
  {
    "sphamba/smear-cursor.nvim",
    cond = function()
      if vim.g.neovide then
        return false
      end
      if vim.fn.has("win32") == 1 then
        return true
      else
        return false
      end
    end,
    opts = { -- Default  Range
      stiffness = 0.8, -- 0.6      [0, 1]
      trailing_stiffness = 0.5, -- 0.3      [0, 1]
      distance_stop_animating = 0.5, -- 0.1      > 0
      hide_target_hack = false, -- true     boolean
      cursor_color = "#c8d3f5",
    },
  },
}
