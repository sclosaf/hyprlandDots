return {
    "uga-rosa/ccc.nvim",
    config = function()
        require("ccc").setup({
            highlighter = {
                auto_enable = true,
                lsp = true,
            },
        })

        vim.keymap.set("n", "<leader>ccp", "<cmd>CccPick<CR>", { desc = "Color picker" })
        vim.keymap.set("n", "<leader>ccc", "<cmd>CccConvert<CR>", { desc = "Color convert" })
        vim.keymap.set("n", "<leader>cce", "<cmd>CccHighlighterEnable<CR>", { desc = "Enable color highlight" })
        vim.keymap.set("n", "<leader>ccd", "<cmd>CccHighlighterDisable<CR>", { desc = "Disable color highlight" })
        vim.keymap.set("n", "<leader>cct", "<cmd>CccHighlighterToggle<CR>", { desc = "Toggle color highlight" })
    end,
}
