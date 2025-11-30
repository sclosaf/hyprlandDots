local motionMode = true

local modes = {'i','n','v'}
local keys = {
    "<Up>", "<Down>", "<Left>", "<Right>",
    "<Home>", "<End>", "<PageUp>", "<PageDown>",

    "<S-Up>", "<S-Down>", "<S-Left>", "<S-Right>",
    "<S-Home>", "<S-End>", "<S-PageUp>", "<S-PageDown>",

    "<C-Up>", "<C-Down>", "<C-Left>", "<C-Right>",
    "<C-Home>", "<C-End>", "<C-PageUp>", "<C-PageDown>",

    "<C-S-Up>", "<C-S-Down>", "<C-S-Left>", "<C-S-Right>",
    "<C-S-Home>", "<C-S-End>", "<C-S-PageUp>", "<C-S-PageDown>",

    "<D-Up>", "<D-Down>", "<D-Left>", "<D-Right>",
    "<D-Home>", "<D-End>", "<D-PageUp>", "<D-PageDown>",

    "<D-S-Up>", "<D-S-Down>", "<D-S-Left>", "<D-S-Right>",
    "<D-S-Home>", "<D-S-End>", "<D-S-PageUp>", "<D-S-PageDown>",

    "<D-C-Up>", "<D-C-Down>", "<D-C-Left>", "<D-C-Right>",
    "<D-C-Home>", "<D-C-End>", "<D-C-PageUp>", "<D-C-PageDown>",

    "<D-C-S-Up>", "<D-C-S-Down>", "<D-C-S-Left>", "<D-C-S-Right>",
    "<D-C-S-Home>", "<D-C-S-End>", "<D-C-S-PageUp>", "<D-C-S-PageDown>",
}

local function enableMotionMode()
    motionMode = true
    print("Motion mode ENABLED")
    vim.o.mouse = ""

    for _, k in ipairs(keys) do
        vim.keymap.set(modes, k, '<Nop>', {silent=true, noremap=true})
    end
end

local function disableMotionMode()
    motionMode = false
    print("Motion mode DISABLED")
    vim.o.mouse = "a"

    for _, k in ipairs(keys) do
        pcall(vim.keymap.del, modes, k)
    end
end

local function toggleMode()
    if motionMode then
        disableMotionMode()
    else
        enableMotionMode()
    end
end

vim.keymap.set('n', '<leader>m', toggleMode, {desc = "Motion mode", silent=true, noremap=true})

if motionMode then
    enableMotionMode()
else
    disableMotionMode()
end
