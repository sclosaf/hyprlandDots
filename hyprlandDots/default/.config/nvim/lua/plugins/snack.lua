local header = require("config.header")

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    init = function()
        vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#b1d9ff" })
    end,
    ---@type snacks.Config
    opts = {
        dashboard = {
            enabled = true,
            preset = {
                keys = {
                    {
                        icon = " ",
                        key = "f",
                        desc = "Find File",
                        action = function()
                            require("telescope.builtin").find_files({
                                cwd = "/",
                                prompt_title = "Search from Root"
                            })
                        end
                    },
                    { icon = " ", key = "e", desc = "File Manager", action = ":Neotree toggle" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
                    { icon = " ", key = "c", desc = "Config", action = ":cd ~/.config/nvim/ | Neotree" },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },

            formats = {
                header = {
                    hl = "SkullHeader",
                },
                key = function(item)
                    return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]  ", hl = "special" } }
                end,
            },
            sections = function()
                local width = vim.o.columns
                local height = vim.o.lines

                local header_section = {
                    text = header.skull_header,
                    align = "center",
                }

                if width < 160 and height < 50 then
                    return {
                        {
                            icon = "󰘵 ",
                            title = "Options",
                            padding = 1,
                        },
                        {
                            section = "keys",
                            gap = 1,
                            padding = 2,
                            formats = { align = "center" },
                            indent = 1,
                        },
                        { section = "startup", },
                        {
                            pane = 2,
                            icon = " ",
                            title = "Recent Files",
                            padding = 1,
                        },
                        {
                            pane = 2,
                            section = "recent_files",
                            limit = 10,
                            gap = 1,
                            indent = 1,
                        },
                    }

                elseif width < 160 then
                    return {
                        header_section,
                        {
                            icon = "󰘵 ",
                            title = "Options",
                            padding = 1
                        },
                        {
                            section = "keys",
                            indent = 2,
                            gap = 1,
                        },
                    }

                else
                    return {
                        header_section,
                        {
                            pane = 2,
                            {
                                type = "padding",
                                size = "25%",
                            },
                            {
                                type = "padding",
                                size = "25%",
                            },
                            {
                                icon = "󰘵 ",
                                title = "Options",
                                padding = 1,
                            },
                            {
                                section = "keys",
                                indent = 2,
                                gap = 1
                            },
                            {
                                type = "padding",
                                size = 1,
                            },
                            {
                                icon = " ",
                                title = "Recent Files",
                                padding = 1,
                            },
                            {
                                section = "recent_files",
                                limit = 10,
                                indent = 2,
                                gap = 1
                            },
                            {
                                type = "padding",
                                size = "25%",
                            },
                            { section = "startup", },
                        }
                    }
                end
            end,
        },
        bigfile = { enabled = true },
        explorer = { enabled = false },
        indent = { enabled = false },
        input = { enabled = false },
        picker = { enabled = false },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    },
}
