-- ============================================================
--  Core editor options
-- ============================================================

local o = vim.opt

-- ── Indentation: 4-space tabs ────────────────────────────────
o.expandtab   = true   -- spaces instead of tabs
o.shiftwidth  = 4      -- indent step
o.tabstop     = 4      -- visual width of <Tab>
o.softtabstop = 4      -- editing feels like real tabs
o.smartindent = true   -- auto-indent after {, before }
o.cindent     = true   -- C-style indent (works for Java too)

-- ── System clipboard ─────────────────────────────────────────
o.clipboard = "unnamedplus"   -- sync with system clipboard (xclip / wl-clipboard)

-- ── UI ───────────────────────────────────────────────────────
o.number         = true
o.relativenumber = true
o.cursorline     = true
o.signcolumn     = "yes"
o.termguicolors  = true
o.laststatus     = 3          -- single global statusline
o.showmode       = false      -- mode shown in statusline instead
o.scrolloff      = 8

-- ── Search ───────────────────────────────────────────────────
o.ignorecase = true
o.smartcase  = true
o.hlsearch   = false
o.incsearch  = true

-- ── Splits ───────────────────────────────────────────────────
o.splitright = true
o.splitbelow = true

-- ── Misc ─────────────────────────────────────────────────────
o.swapfile     = false
o.backup       = false
o.undofile     = true
o.updatetime   = 250
o.timeoutlen   = 400
o.wrap         = false
o.fileencoding = "utf-8"
