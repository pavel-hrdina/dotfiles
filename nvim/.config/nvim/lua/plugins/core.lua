-- My custom configuration

return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      transparent = true,
      colorscheme = "gruvbox",
    },
  },
  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = {
      multiline = true, -- render multi-line messages
    },
  },
  -- add bashls to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        bashls = {},
      },
    },
  },
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[        
░▒▓██████████►╬◄██████████▓▒░
░▒▓██►╔╦╦╦═╦╗╔═╦═╦══╦═╗◄██▓▒░
░▒▓██►║║║║╩╣╚╣═╣║║║║║╩╣◄██▓▒░
░▒▓██►╚══╩═╩═╩═╩═╩╩╩╩═╝◄██▓▒░
░▒▓██████████►╬◄██████████▓▒░
      ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
      opts.theme = "doom"
    end,
  },
}
