return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    lazy = false,
    opts = {
        ensure_installed = {"cpp", "json", "java", "lua", "bash", "markdown", "markdown_inline", "strudel" },
        highlight = {enable = true},
        indent = {enable = true},
        auto_install = true
    }
}
