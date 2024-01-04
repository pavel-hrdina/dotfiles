vim.cmd("set hidden")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins ={
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...} 
}
local opts = {}

require("lazy").setup(plugins, opts)
require("gruvbox").setup()

vim.cmd.colorscheme "gruvbox"
