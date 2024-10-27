--游标操作
return {
  {
    "LeonHeidelbach/trailblazer.nvim",
    lazy = true,
    keys = { "<A-s>", "<A-d>" },
    config = function()
      -- local HOME = os.getenv("HOME")
      require("trailblazer").setup({
        auto_save_trailblazer_state_on_exit = false,
        auto_load_trailblazer_state_on_enter = false,
        -- custom_session_storage_dir = HOME .. "/.local/share/trail_blazer_sessions/",
        trail_options = {
          mark_symbol = "•", --  will only be used if trail_mark_symbol_line_indicators_enabled = true
          newest_mark_symbol = "󰝥", -- disable this mark symbol by setting its value to ""
          cursor_mark_symbol = "󰺕", -- disable this mark symbol by setting its value to ""
          next_mark_symbol = "󰬦", -- disable this mark symbol by setting its value to ""
          previous_mark_symbol = "󰬬", -- disable this mark symbol by setting its value to ""
        },
        mappings = {
          nv = {
            motions = {
              new_trail_mark = "<A-s>",
              track_back = "<A-d>",
              peek_move_next_down = "<A-J>",
              peek_move_previous_up = "<A-K>",
              move_to_nearest = "<A-n>",
              toggle_trail_mark_list = "<A-o>",
            },
            actions = {
              delete_all_trail_marks = "<A-L>",
              paste_at_last_trail_mark = "<A-p>",
              paste_at_all_trail_marks = "<A-P>",
              set_trail_mark_select_mode = "<A-t>",
              switch_to_next_trail_mark_stack = "<A-.>",
              switch_to_previous_trail_mark_stack = "<A-,>",
              set_trail_mark_stack_sort_mode = "<A-S>",
            },
          },
        },
        quickfix_mappings = { -- rename this to "force_quickfix_mappings" to completely override default mappings and not merge with them
          -- nv = {
          -- 	motions = {
          -- 		qf_motion_move_trail_mark_stack_cursor = "<CR>",
          -- 	},
          -- 	actions = {
          -- 		qf_action_delete_trail_mark_selection = "d",
          -- 		qf_action_save_visual_selection_start_line = "v",
          -- 	},
          -- 	alt_actions = {
          -- 		qf_action_save_visual_selection_start_line = "V",
          -- 	},
          -- },
          -- v = {
          -- 	actions = {
          -- 		qf_action_move_selected_trail_marks_down = "<C-j>",
          -- 		qf_action_move_selected_trail_marks_up = "<C-k>",
          -- 	},
          -- },
        },
      })
    end,
  },
}
