return {
    "nvim-zh/better-escape.vim",
    event = "InsertEnter",
    config = function()
        vim.g.better_escape_interval = 150
    end
}

