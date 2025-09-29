return {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    cmd = "Neotree",
    keys = {
        { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree filesystem" },
        { "<leader>E", "<cmd>cd ~/ | Neotree toggle<CR>", desc = "Toggle Neo-tree at home" },
        { "<leader>f", "<cmd>cd / | Neotree toggle<CR>", desc = "Toggle Neo-tree at root" },
        { "<leader>g", "<cmd>Neotree toggle git_status<CR>", desc = "Toggle Neo-tree git status" },
    },
    opts = {
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        window = {
            mappings = {
                ["<CR>"] = "open",
                ["<leader>e"] = "close_window",
                ["q"] = "close_window",
            },
        },
        filesystem = {
            follow_current_file = { enabled = true },
            group_empty_dirs = true,
            window = {
                mappings = {
                    ["h"] = "navigate_up",
                    ["l"] = "set_root",
                },
            },
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },
        buffers = {
            window = {
                mappings = {
                    ["bd"] = "buffer_delete",
                },
            },
        },
    },
}
