-- ============================================================
--  Custom colorscheme: black-minimal
--  Matches the repo's #1a1a1a / #e6e6e6 Off-Black palette
-- ============================================================

local M = {}

M.colors = {
  bg        = "#1a1a1a",
  bg_alt    = "#242424",
  bg_sel    = "#303030",
  bg_ui     = "#2a2a2a",
  fg        = "#e6e6e6",
  fg_dim    = "#8a8a8a",
  fg_subtle = "#cfcfcf",

  black     = "#1a1a1a",
  red       = "#ff6b6b",
  green     = "#98c379",
  yellow    = "#e5c07b",
  blue      = "#61afef",
  magenta   = "#c678dd",
  cyan      = "#56b6c2",
  white     = "#e6e6e6",

  br_black  = "#888888",
  br_red    = "#ff6b6b",
  br_green  = "#98c379",
  br_yellow = "#e5c07b",
  br_blue   = "#61afef",
  br_mag    = "#c678dd",
  br_cyan   = "#56b6c2",
  br_white  = "#ffffff",

  -- extras
  orange    = "#d19a66",
  warning   = "#ebdbb2",
  error     = "#cc241d",
}

function M.setup()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
  vim.g.colors_name = "blackminimal"
  vim.opt.termguicolors = true

  local c = M.colors
  local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

  -- ── Editor basics ──────────────────────────────────────────
  hl("Normal",        { fg = c.fg,        bg = c.bg })
  hl("NormalFloat",   { fg = c.fg,        bg = c.bg_ui })
  hl("FloatBorder",   { fg = c.fg_dim,    bg = c.bg_ui })
  hl("Cursor",        { fg = c.bg,        bg = c.fg })
  hl("CursorLine",    {                   bg = c.bg_alt })
  hl("CursorLineNr",  { fg = c.fg,        bold = true })
  hl("LineNr",        { fg = c.fg_dim })
  hl("SignColumn",    {                   bg = c.bg })
  hl("ColorColumn",   {                   bg = c.bg_sel })
  hl("Visual",        {                   bg = c.bg_sel })
  hl("IncSearch",     { fg = c.bg,        bg = c.yellow })
  hl("Search",        { fg = c.bg,        bg = c.fg_subtle })
  hl("MatchParen",    { fg = c.yellow,    bold = true })

  -- ── Pmenu (auto-complete) ─────────────────────────────────
  hl("Pmenu",         { fg = c.fg,        bg = c.bg_ui })
  hl("PmenuSel",      { fg = c.bg,        bg = c.blue })
  hl("PmenuSbar",     {                   bg = c.bg_sel })
  hl("PmenuThumb",    {                   bg = c.fg_dim })

  -- ── Status / Split lines ──────────────────────────────────
  hl("StatusLine",    { fg = c.fg_subtle, bg = c.bg_sel })
  hl("StatusLineNC",  { fg = c.fg_dim,    bg = c.bg_alt })
  hl("WinSeparator",  { fg = c.bg_sel,    bg = c.bg })
  hl("TabLine",       { fg = c.fg_dim,    bg = c.bg_alt })
  hl("TabLineSel",    { fg = c.fg,        bg = c.bg_sel })
  hl("TabLineFill",   {                   bg = c.bg })

  -- ── Syntax tokens ─────────────────────────────────────────
  hl("Comment",       { fg = c.fg_dim,    italic = true })
  hl("Constant",      { fg = c.cyan })
  hl("String",        { fg = c.green })
  hl("Character",     { fg = c.green })
  hl("Number",        { fg = c.orange })
  hl("Boolean",       { fg = c.yellow })
  hl("Float",         { fg = c.orange })
  hl("Identifier",    { fg = c.fg })
  hl("Function",      { fg = c.blue })
  hl("Statement",     { fg = c.magenta })
  hl("Conditional",   { fg = c.magenta })
  hl("Repeat",        { fg = c.magenta })
  hl("Label",         { fg = c.magenta })
  hl("Operator",      { fg = c.fg_subtle })
  hl("Keyword",       { fg = c.magenta,   bold = true })
  hl("Exception",     { fg = c.red })
  hl("PreProc",       { fg = c.yellow })
  hl("Include",       { fg = c.blue })
  hl("Define",        { fg = c.magenta })
  hl("Macro",         { fg = c.yellow })
  hl("Type",          { fg = c.yellow })
  hl("StorageClass",  { fg = c.yellow })
  hl("Structure",     { fg = c.yellow })
  hl("Typedef",       { fg = c.yellow })
  hl("Special",       { fg = c.cyan })
  hl("Underlined",    { underline = true })
  hl("Error",         { fg = c.error,     bold = true })
  hl("Todo",          { fg = c.bg,        bg = c.yellow, bold = true })
  hl("Warning",       { fg = c.warning })

  -- ── Treesitter semantic tokens ────────────────────────────
  hl("@variable",           { fg = c.fg })
  hl("@variable.builtin",   { fg = c.red })
  hl("@variable.parameter", { fg = c.fg_subtle })
  hl("@field",              { fg = c.fg_subtle })
  hl("@property",           { fg = c.fg_subtle })
  hl("@function",           { fg = c.blue })
  hl("@function.builtin",   { fg = c.cyan })
  hl("@function.call",      { fg = c.blue })
  hl("@method",             { fg = c.blue })
  hl("@method.call",        { fg = c.blue })
  hl("@constructor",        { fg = c.yellow })
  hl("@keyword",            { fg = c.magenta, bold = true })
  hl("@keyword.function",   { fg = c.magenta, bold = true })
  hl("@keyword.return",     { fg = c.magenta })
  hl("@keyword.operator",   { fg = c.fg_subtle })
  hl("@conditional",        { fg = c.magenta })
  hl("@repeat",             { fg = c.magenta })
  hl("@exception",          { fg = c.red })
  hl("@operator",           { fg = c.fg_subtle })
  hl("@punctuation",        { fg = c.fg_subtle })
  hl("@comment",            { fg = c.fg_dim, italic = true })
  hl("@string",             { fg = c.green })
  hl("@string.escape",      { fg = c.cyan })
  hl("@number",             { fg = c.orange })
  hl("@float",              { fg = c.orange })
  hl("@boolean",            { fg = c.yellow })
  hl("@type",               { fg = c.yellow })
  hl("@type.builtin",       { fg = c.yellow })
  hl("@namespace",          { fg = c.fg_subtle })
  hl("@include",            { fg = c.blue })
  hl("@preproc",            { fg = c.yellow })
  hl("@tag",                { fg = c.blue })
  hl("@tag.attribute",      { fg = c.green })
  hl("@tag.delimiter",      { fg = c.fg_dim })

  -- ── Diagnostics ───────────────────────────────────────────
  hl("DiagnosticError",   { fg = c.red })
  hl("DiagnosticWarn",    { fg = c.warning })
  hl("DiagnosticInfo",    { fg = c.blue })
  hl("DiagnosticHint",    { fg = c.cyan })
  hl("DiagnosticVirtualTextError", { fg = c.red,     bg = c.bg_alt, italic = true })
  hl("DiagnosticVirtualTextWarn",  { fg = c.warning, bg = c.bg_alt, italic = true })
  hl("DiagnosticVirtualTextInfo",  { fg = c.blue,    bg = c.bg_alt, italic = true })
  hl("DiagnosticVirtualTextHint",  { fg = c.cyan,    bg = c.bg_alt, italic = true })
  hl("DiagnosticUnderlineError",   { undercurl = true, sp = c.red })
  hl("DiagnosticUnderlineWarn",    { undercurl = true, sp = c.warning })

  -- ── Git diff signs ────────────────────────────────────────
  hl("DiffAdd",     { fg = c.green })
  hl("DiffChange",  { fg = c.yellow })
  hl("DiffDelete",  { fg = c.red })
  hl("DiffText",    { fg = c.blue })
  hl("GitSignsAdd",    { fg = c.green, bg = c.bg })
  hl("GitSignsChange", { fg = c.yellow, bg = c.bg })
  hl("GitSignsDelete", { fg = c.red, bg = c.bg })
end

return M
