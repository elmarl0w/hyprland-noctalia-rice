-- CachyGreen — палитра CachyOS / Noctalia
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
vim.o.background = "dark"
vim.g.colors_name = "cachygreen"

local c = {
  bg        = "#0b1412",
  bg_alt    = "#111c19",
  bg_float  = "#131f1c",
  sel       = "#1f2f2b",
  line      = "#101b18",
  fg        = "#dfe6e3",
  fg_dim    = "#c2cec9",
  comment   = "#5f7570",
  border    = "#27403a",
  mint      = "#82dccc",
  spring    = "#5fd0a9",
  green     = "#7ee787",
  cyan      = "#a8e8dc",
  blue      = "#79c0ff",
  purple    = "#d2a8ff",
  yellow    = "#e3cf8a",
  orange    = "#ffab70",
  red       = "#ff7b72",
  dark      = "#00201b",
}

local function hl(g, o) vim.api.nvim_set_hl(0, g, o) end

-- Базовый UI
hl("Normal",        { fg = c.fg, bg = c.bg })
hl("NormalFloat",   { fg = c.fg, bg = c.bg_float })
hl("FloatBorder",   { fg = c.border, bg = c.bg_float })
hl("FloatTitle",    { fg = c.mint, bg = c.bg_float, bold = true })
hl("Cursor",        { fg = c.dark, bg = c.mint })
hl("CursorLine",    { bg = c.line })
hl("CursorLineNr",  { fg = c.mint, bold = true })
hl("LineNr",        { fg = "#3d4d48" })
hl("SignColumn",    { bg = c.bg })
hl("ColorColumn",   { bg = c.bg_alt })
hl("VertSplit",     { fg = c.border })
hl("WinSeparator",  { fg = c.border })
hl("Visual",        { bg = c.sel })
hl("Search",        { fg = c.dark, bg = c.spring })
hl("IncSearch",     { fg = c.dark, bg = c.mint })
hl("CurSearch",     { fg = c.dark, bg = c.mint, bold = true })
hl("MatchParen",    { fg = c.mint, bold = true, underline = true })
hl("Pmenu",         { fg = c.fg, bg = c.bg_float })
hl("PmenuSel",      { fg = c.dark, bg = c.mint, bold = true })
hl("PmenuSbar",     { bg = c.bg_alt })
hl("PmenuThumb",    { bg = c.border })
hl("StatusLine",    { fg = c.fg, bg = c.bg_alt })
hl("StatusLineNC",  { fg = c.comment, bg = c.bg_alt })
hl("TabLine",       { fg = c.comment, bg = c.bg_alt })
hl("TabLineSel",    { fg = c.dark, bg = c.mint, bold = true })
hl("TabLineFill",   { bg = c.bg })
hl("Folded",        { fg = c.comment, bg = c.bg_alt })
hl("NonText",       { fg = "#2c3c37" })
hl("Whitespace",    { fg = "#243430" })
hl("Directory",     { fg = c.mint })
hl("Title",         { fg = c.mint, bold = true })
hl("Question",      { fg = c.spring })
hl("ErrorMsg",      { fg = c.red })
hl("WarningMsg",    { fg = c.yellow })
hl("ModeMsg",       { fg = c.mint, bold = true })
hl("WinBar",        { fg = c.fg_dim, bg = c.bg })
hl("WinBarNC",      { fg = c.comment, bg = c.bg })

-- Синтаксис
hl("Comment",    { fg = c.comment, italic = true })
hl("Constant",   { fg = c.cyan })
hl("String",     { fg = c.green })
hl("Character",  { fg = c.green })
hl("Number",     { fg = c.orange })
hl("Boolean",    { fg = c.orange })
hl("Float",      { fg = c.orange })
hl("Identifier", { fg = c.fg })
hl("Function",   { fg = c.mint, bold = true })
hl("Statement",  { fg = c.purple })
hl("Conditional",{ fg = c.purple })
hl("Repeat",     { fg = c.purple })
hl("Label",      { fg = c.purple })
hl("Operator",   { fg = c.spring })
hl("Keyword",    { fg = c.purple })
hl("Exception",  { fg = c.red })
hl("PreProc",    { fg = c.blue })
hl("Include",    { fg = c.blue })
hl("Define",     { fg = c.blue })
hl("Macro",      { fg = c.blue })
hl("Type",       { fg = c.yellow })
hl("StorageClass",{ fg = c.yellow })
hl("Structure",  { fg = c.yellow })
hl("Typedef",    { fg = c.yellow })
hl("Special",    { fg = c.cyan })
hl("Delimiter",  { fg = c.fg_dim })
hl("Underlined", { fg = c.blue, underline = true })
hl("Todo",       { fg = c.dark, bg = c.yellow, bold = true })
hl("Error",      { fg = c.red })

-- Treesitter
hl("@variable",           { fg = c.fg })
hl("@variable.builtin",   { fg = c.red })
hl("@variable.parameter", { fg = c.fg_dim, italic = true })
hl("@property",           { fg = c.cyan })
hl("@field",              { fg = c.cyan })
hl("@function",           { fg = c.mint, bold = true })
hl("@function.builtin",   { fg = c.mint })
hl("@function.call",      { fg = c.mint })
hl("@method",             { fg = c.mint, bold = true })
hl("@constructor",        { fg = c.yellow })
hl("@keyword",            { fg = c.purple })
hl("@keyword.return",     { fg = c.red })
hl("@punctuation",        { fg = c.fg_dim })
hl("@punctuation.bracket",{ fg = c.fg_dim })
hl("@tag",                { fg = c.purple })
hl("@tag.attribute",      { fg = c.cyan })
hl("@type",               { fg = c.yellow })
hl("@constant",           { fg = c.cyan })
hl("@constant.builtin",   { fg = c.orange })
hl("@comment",            { fg = c.comment, italic = true })

-- Диагностика
hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn",  { fg = c.yellow })
hl("DiagnosticInfo",  { fg = c.blue })
hl("DiagnosticHint",  { fg = c.mint })
hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hl("DiagnosticUnderlineWarn",  { undercurl = true, sp = c.yellow })
hl("DiagnosticUnderlineInfo",  { undercurl = true, sp = c.blue })
hl("DiagnosticUnderlineHint",  { undercurl = true, sp = c.mint })

-- Git
hl("DiffAdd",    { bg = "#12301f" })
hl("DiffChange", { bg = "#16283a" })
hl("DiffDelete", { bg = "#3a1a1a" })
hl("DiffText",   { bg = "#1d3c56" })
hl("GitSignsAdd",    { fg = c.green })
hl("GitSignsChange", { fg = c.yellow })
hl("GitSignsDelete", { fg = c.red })

-- Плагины
hl("TelescopeNormal",       { fg = c.fg, bg = c.bg_float })
hl("TelescopeBorder",       { fg = c.border, bg = c.bg_float })
hl("TelescopeTitle",        { fg = c.dark, bg = c.mint, bold = true })
hl("TelescopeSelection",    { fg = c.fg, bg = c.sel, bold = true })
hl("TelescopeMatching",     { fg = c.mint, bold = true })
hl("NvimTreeNormal",        { fg = c.fg_dim, bg = c.bg_alt })
hl("NvimTreeFolderIcon",    { fg = c.mint })
hl("NvimTreeFolderName",    { fg = c.fg })
hl("NvimTreeOpenedFolderName", { fg = c.mint, bold = true })
hl("NvimTreeRootFolder",    { fg = c.spring, bold = true })
hl("NvimTreeGitDirty",      { fg = c.yellow })
hl("NvimTreeIndentMarker",  { fg = "#2c3c37" })
hl("IblIndent",             { fg = "#1c2c28" })
hl("IblScope",              { fg = "#2f4a44" })
hl("WhichKey",              { fg = c.mint })
hl("WhichKeyGroup",         { fg = c.spring })
hl("WhichKeyDesc",          { fg = c.fg })
hl("WhichKeyFloat",         { bg = c.bg_float })
