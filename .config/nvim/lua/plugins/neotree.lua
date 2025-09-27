return {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    keys = {
        { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree filesystem" },
        { "<leader>E", "<cmd>cd ~/ | Neotree toggle<CR>", desc = "Toggle Neo-tree at home" },
        { "<leader>f", "<cmd>cd / | Neotree toggle<CR>", desc = "Toggle Neo-tree at root" },
        { "<leader>g", "<cmd>Neotree toggle git_status<CR>", desc = "Toggle Neo-tree git status" },
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
        })
    end,
}
