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
        { "<leader>te", "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree filesystem" },
        { "<leader>tE", "<cmd>cd ~/ | Neotree toggle<CR>", desc = "Toggle Neo-tree at home" },
        { "<leader>tr", "<cmd>cd / | Neotree toggle<CR>", desc = "Toggle Neo-tree at root" },
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
                    ["a"] = "add",
                    ["r"] = "rename",
                    ["y"] = "copy",
                    ["d"] = "delete",
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
