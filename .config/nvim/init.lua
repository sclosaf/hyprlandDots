vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.laststatus = 2

vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.cmdheight = 2

vim.opt.wildmenu = true
vim.opt.wildmode = { "list:longest", "full" }
vim.opt.wildoptions = "pum"
vim.opt.pumheight = 10

vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scroll = 1
vim.opt.mouse = "a"

vim.opt.background = "dark"
if vim.fn.has("termguicolors") == 1 then
  vim.opt.termguicolors = true
end

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.showmatch = true
vim.opt.matchtime = 5

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt_local.textwidth = vim.api.nvim_win_get_width(0) - 2

vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.clipboard = "unnamedplus"

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = false

vim.opt.autoread = true
vim.opt.autowrite = true

vim.opt.list = true
vim.opt.listchars = { tab = ">-", trail = "~", nbsp = "~" }

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

local man_settings = vim.api.nvim_create_augroup("man_settings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = man_settings,
  pattern = "man",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.foldmethod = "manual"
  end,
})

local cursorline_grp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = cursorline_grp,
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = cursorline_grp,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "markdown" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

vim.opt.errorbells = false
vim.opt.visualbell = true
vim.opt.belloff = "all"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nord").setup({})
      vim.cmd.colorscheme("nord")
    end,
  },
}, {
  install = {
    colorscheme = { "nord" },
  }
})

vim.cmd.colorscheme("nord")
