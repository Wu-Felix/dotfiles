return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- Use the latest release instead of the latest commit (recommended)
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "ObsidianBacklinks",
      "ObsidianCheck",
      "ObsidianDailies",
      "ObsidianDebug",
      "ObsidianExtractNote",
      "ObsidianFollowLink",
      "ObsidianLink",
      "ObsidianLinkNew",
      "ObsidianLinks",
      "ObsidianNew",
      "ObsidianNewFromTemplate",
      "ObsidianOpen",
      "ObsidianPasteImg",
      "ObsidianQuickSwitch",
      "ObsidianRename",
      "ObsidianSearch",
      "ObsidianTOC",
      "ObsidianTags",
      "ObsidianTemplate",
      "ObsidianToday",
      "ObsidianToggleCheckbox",
      "ObsidianTomorrow",
      "ObsidianWorkspace",
      "ObsidianYesterday",
    },
    keys = {
      {
        "<leader>obf",
        "<cmd>ObsidianQuickSwitch<CR>",
        desc = "ObsidianQuickSwitch",
      },
      {
        "<leader>obg",
        "<cmd>ObsidianSearch<CR>",
        desc = "ObsidianSearch",
      },
      {
        "<leader>obn",
        "<cmd>ObsidianNew<CR>",
        desc = "ObsidianNew",
      },
      {
        "<leader>obc",
        "<cmd>ObsidianToggleCheckbox<CR>",
        desc = "ObsidianToggleCheckbox",
      },
      {
        "<leader>obt",
        "<cmd>ObsidianTags<CR>",
        desc = "ObsidianTags",
      },
      {
        "<leader>obw",
        "<cmd>ObsidianWorkspace<CR>",
        desc = "ObsidianWorkspace",
      },
      {
        "<leader>obp",
        "<cmd>ObsidianPasteImg<CR>",
        desc = "ObsidianPasteImg",
      },
      {
        "<leader>obl",
        "<cmd>ObsidianLinks<CR>",
        desc = "ObsidianLinks",
      },
      {
        "<leader>obb",
        "<cmd>ObsidianBacklinks<CR>",
        desc = "ObsidianBacklinks",
      },
      {
        "<leader>obo",
        "<cmd>ObsidianOpen<CR>",
        desc = "ObsidianOpen",
      },
      {
        "<leader>obm",
        "<cmd>ObsidianTemplate<CR>",
        desc = "ObsidianTemplate",
      },
    },

    opts = {
      -- Define workspaces for Obsidian
      workspaces = {
        {
          name = "felix",
          path = "~/OneDrive/PARA/",
        },
      },

      -- Completion settings
      completion = {
        nvim_cmp = false, -- Disable completion using nvim-cmp
        blink = true,
      },
      notes_subdir = "area/notes", -- Subdirectory for notes
      new_notes_location = "area/notes", -- Location for new notes
      -- Settings for attachments
      attachments = {
        img_folder = "./image", -- Folder for image attachments
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format("![%s](/%s)", path.name, path)
        end,
      },
      -- Settings for daily notes
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "area/dailies",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%Y-%m-%d",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "daily-notes" },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil,
      },
      ui = {
        enable = false,
      },
      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "snacks.pick",
      },
      templates = {
        folder = "resource/templates",
      },
      -- Function to generate frontmatter for notes
      note_frontmatter_func = function(note)
        -- This is equivalent to the default frontmatter function.
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,

      -- Function to generate note IDs
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return suffix
      end,
      follow_url_func = function(url)
        print(url)
        vim.ui.open(url) -- need Neovim 0.10.0+
      end,
      follow_img_func = function(img)
        if os.getenv("SHELL") ~= "/bin/zsh" then
          print(img)
          vim.cmd("wezterm imgcat" .. img .. '"') -- Windows
        else
          vim.fn.jobstart({ "qlmanage", "-p", img }) -- Mac OS quick look preview
        end
      end,
    },
  },
}
