return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
    'nvim-cmp',
  },
  config = function(_, opts)
    -- Setup obsidian.nvim
    require('obsidian').setup(opts)

    -- Create which-key mappings for common commands.
    local wk = require 'which-key'
    wk.add {
      {
        { '<leader>o', group = 'Obsidian' },
        { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = 'Backlinks' },
        { '<leader>oc', '<cmd>ObsidianTOC<cr>', desc = 'Contents (TOC)' },
        { '<leader>ol', '<cmd>ObsidianLinks<cr>', desc = 'Links' },
        { '<leader>om', '<cmd>ObsidianTemplate<cr>', desc = 'Template' },
        { '<leader>on', '<cmd>ObsidianQuickSwitch nav<cr>', desc = 'Nav' },
        { '<leader>oo', '<cmd>ObsidianOpen<cr>', desc = 'Open note' },
        { '<leader>op', '<cmd>ObsidianPasteImg<cr>', desc = 'Paste image' },
        { '<leader>oq', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Quick switch' },
        { '<leader>or', '<cmd>ObsidianRename<cr>', desc = 'Rename' },
        { '<leader>os', '<cmd>ObsidianSearch<cr>', desc = 'Search' },
        { '<leader>ot', '<cmd>ObsidianTags<cr>', desc = 'Tags' },
      },
    }
    wk.add {
      {
        mode = { 'v' },
        {
          '<leader>oe',
          function()
            local title = vim.fn.input { prompt = 'Enter title (optional): ' }
            vim.cmd('ObsidianExtractNote ' .. title)
          end,
          desc = 'Extract text into new note',
        },
        {
          '<leader>ol',
          function()
            vim.cmd 'ObsidianLink'
          end,
          desc = 'Link text to an existing note',
        },
        {
          '<leader>on',
          function()
            vim.cmd 'ObsidianLinkNew'
          end,
          desc = 'Link text to a new note',
        },
        {
          '<leader>ot',
          function()
            vim.cmd 'ObsidianTags'
          end,
          desc = 'Tags',
        },
      },
    }
  end,
  opts = {
    -- A list of workspace names, paths, and configuration overrides.
    -- If you use the Obsidian app, the 'path' of a workspace should generally be
    -- your vault root (where the `.obsidian` folder is located).
    -- When obsidian.nvim is loaded by your plugin manager, it will automatically set
    -- the workspace to the first workspace in the list whose `path` is a parent of the
    -- current markdown file being edited.
    --
    workspaces = {
      {
        name = 'personal',
        path = '~/vaults/Zettlkasten',
      },
      {
        name = 'Archiv',
        path = '~/vaults/Archiv',
        overrides = {
          new_notes_location = 'current_dir',
          -- notes_subdir = vim.NIL,
          disable_frontmatter = true,
        },
      },
    },

    templates = {
      folder = '5 - Šablony',
    },

    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },

    log_level = vim.log.levels.INFO,
  },
}
