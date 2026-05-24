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

vim.api.nvim_create_augroup("CreateDirs", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "CreateDirs",
    pattern = "*",
    callback = function()
        local file_path = vim.fn.expand("<afile>:p:h")
        if vim.fn.isdirectory(file_path) == 0 then
            vim.fn.mkdir(file_path, "p")
        end
    end,
})

vim.filetype.add({
  extension = {
    strudel = "strudel",
  },
})
