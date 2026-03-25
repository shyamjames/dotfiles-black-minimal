vim.o.background = "dark"

local ok_onedark, onedark = pcall(require, "onedark")
if ok_onedark then
    onedark.setup({
        style = "darker",
        colors = {
            bg0 = "#1a1a1a",
            fg = "#e6e6e6",
            red = "#ff6b6b",
            green = "#98c379",
            yellow = "#e5c07b",
            blue = "#61afef",
            purple = "#c678dd",
            cyan = "#56b6c2",
            grey = "#888888",
        },
    })
    onedark.load()
    return
end

local fallback = "monokai_pro"
local is_ok, _ = pcall(vim.cmd, "colorscheme " .. fallback)
if not is_ok then
    vim.notify("colorscheme " .. fallback .. " not found!")
end
