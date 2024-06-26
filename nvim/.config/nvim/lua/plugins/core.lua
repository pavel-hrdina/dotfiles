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
  -- configuration for none ls
  {
    "nvimtools/none-ls.nvim",
    event = "LazyFile",
    dependencies = { "mason.nvim" },
    init = function()
      LazyVim.on_very_lazy(function()
        -- register the formatter with LazyVim
        LazyVim.format.register({
          name = "none-ls.nvim",
          priority = 200, -- set higher than conform, the builtin formatter
          primary = true,
          format = function(buf)
            return LazyVim.lsp.format({
              bufnr = buf,
              filter = function(client)
                return client.name == "null-ls"
              end,
            })
          end,
          sources = function(buf)
            local ret = require("null-ls.sources").get_available(vim.bo[buf].filetype, "NULL_LS_FORMATTING") or {}
            return vim.tbl_map(function(source)
              return source.name
            end, ret)
          end,
        })
      end)
    end,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.root_dir = opts.root_dir
        or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
      opts.sources = vim.list_extend(opts.sources or {}, {
        -- Add formateers here using https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.ocamlformat,
      })
    end,
  },
  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = {
      multiline = true, -- render multi-line messages
    },
  },
  -- add langeuage servers to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        ocamllsp = {
          -- cmd = { ... }
          filetypes = { "ml", "ocaml", "reason" },
          -- capabilities = { ... }
          settings = {
            extendedHover = { true },
          },
        },
        bashls = {},
        cssls = {},
        terraformls = {},
        ansiblels = {},
        marksman = {},
        neocmake = {},
        yamlls = {
          capabilities = {
            textDocuments = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              new_config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas()
            )
          end,
          redhat = { telemetry = { enabled = false } },
          yaml = {
            keyOrdering = false,
            format = {
              enable = true,
            },
            validate = true,
            schemaStore = {
              -- Must disable built-in schemaStore support to use
              -- schemas from SchemaStore.nvim plugin
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
          },
        },
      },
      setup = {
        yamlls = function()
          -- Neovim < 0.10 does not have dynamic registration for formatting
          if vim.fn.has("nvim-0.10") == 0 then
            LazyVim.lsp.on_attach(function(client, _)
              if client.name == "yamlls" then
                client.server_capabilities.documentFormattingProvider = true
              end
            end)
          end
        end,
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
    -- add more treesitter parsers
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
          "bash",
          "html",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "yaml",
          "css",
          "ocaml",
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
  },
  {
    "theRealCarneiro/hyprland-vim-syntax",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = "hypr",
  },
}
