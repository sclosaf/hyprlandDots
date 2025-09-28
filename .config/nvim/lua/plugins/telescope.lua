return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    },
    opts = {
        defaults = {
            prompt_prefix = "🔍 ",
            selection_caret = " ",
            path_display = { "smart" },
            layout_config = {
                horizontal = {
                    preview_width = 0.6,
                },
            },
            file_ignore_patterns = {
                "node_modules",
                ".git/",
                "dist/",
                "%.lock",
            },
        },
        pickers = {
            find_files = {
                hidden = true,
            },
        },
    },
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find recently opened files" })
    end,
}
