local motionMode = true

local modes = {'i','n','v'}
local keys = {"<Up>", "<Down>", "<Left>", "<Right>", "<Home>", "<End>", "<PageUp>", "<PageDown>"}

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

