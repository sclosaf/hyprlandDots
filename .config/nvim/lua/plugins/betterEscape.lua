return {
    "max397574/better-escape.nvim",
    config = function()
        require("better_escape").setup {
            mappings = {
                i = {
                    k = { j = "<Esc>" },
                    j = { k = "<Esc>" },
                },
                v = {
                    k = { j = "<Esc>" },
                    j = { k = "<Esc>" },
                },
            },
            timeout = 200,
            clear_empty_lines = true,
            keys = "<Esc>",
        }
    end
}
