-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'mrcjkb/rustaceanvim',
    -- make sure to install rust-analyzer with '$ rustup component add rust-analyzer'
    version = '^4', -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = { 'rust' },
  },
}
