return {
  {
    "aktersnurra/no-clown-fiesta.nvim",
    priority = 1000,
    lazy = false,

    config = function()
      local opts = {
        theme = "dark",
        styles = {
          type = { bold = true },
          lsp = { underline = false },
          match_paren = { underline = true },
        },
      }

      require("no-clown-fiesta").load(opts)
    end,
  },
}
