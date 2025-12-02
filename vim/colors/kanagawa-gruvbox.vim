" ─────────────────────────────────────────────────────────────────────────────────
"                           CUSTOM THEME - Kanagawa x Gruvbox
" ─────────────────────────────────────────────────────────────────────────────────

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "kanagawa-gruvbox"

" ─────────────────────────────────────────────────────────────────────────────────
" Palette
" ─────────────────────────────────────────────────────────────────────────────────
let s:bg0       = "#1f1f28"
let s:bg1       = "#2a2a37"
let s:bg2       = "#363646"
let s:bg3       = "#504945"
let s:fg0       = "#dcd7ba"
let s:fg1       = "#c8c093"
let s:fg2       = "#928374"
let s:red       = "#ff5d62"
let s:orange    = "#ff7733"
let s:yellow    = "#d8a657"
let s:green     = "#98bb6c"
let s:cyan      = "#7daea3"
let s:blue      = "#7fb4ca"
let s:violet    = "#c678dd"
let s:pink      = "#ff79c6"

" ─────────────────────────────────────────────────────────────────────────────────
" Terminal colors
" ─────────────────────────────────────────────────────────────────────────────────
let g:terminal_ansi_colors = [
      \ s:bg0, s:red, s:green, s:yellow,
      \ s:blue, s:violet, s:cyan, s:fg1,
      \ s:bg3, s:red, s:green, s:yellow,
      \ s:blue, s:pink, s:cyan, s:fg0
      \ ]

" ─────────────────────────────────────────────────────────────────────────────────
" Highlight function
" ─────────────────────────────────────────────────────────────────────────────────
function! s:hl(group, fg, bg, attr)
  let l:cmd = "highlight " . a:group
  if a:fg != ""
    let l:cmd .= " guifg=" . a:fg
  endif
  if a:bg != ""
    let l:cmd .= " guibg=" . a:bg
  endif
  if a:attr != ""
    let l:cmd .= " gui=" . a:attr
  endif
  execute l:cmd
endfunction

" ─────────────────────────────────────────────────────────────────────────────────
" UI Elements
" ─────────────────────────────────────────────────────────────────────────────────
call s:hl("Normal",       s:fg0, s:bg0, "")
call s:hl("NormalFloat",  s:fg0, s:bg1, "")
call s:hl("Cursor",       s:bg0, s:fg0, "")
call s:hl("CursorLine",   "",    s:bg1, "NONE")
call s:hl("CursorColumn", "",    s:bg1, "")
call s:hl("ColorColumn",  "",    s:bg1, "")
call s:hl("LineNr",       s:bg3, "",    "")
call s:hl("CursorLineNr", s:orange, "", "bold")
call s:hl("VertSplit",    s:bg2, s:bg0, "")
call s:hl("StatusLine",   s:fg1, s:bg2, "")
call s:hl("StatusLineNC", s:fg2, s:bg1, "")
call s:hl("TabLine",      s:fg2, s:bg1, "")
call s:hl("TabLineFill",  s:fg2, s:bg0, "")
call s:hl("TabLineSel",   s:bg0, s:orange, "bold")
call s:hl("Pmenu",        s:fg0, s:bg1, "")
call s:hl("PmenuSel",     s:bg0, s:orange, "")
call s:hl("PmenuSbar",    "",    s:bg2, "")
call s:hl("PmenuThumb",   "",    s:fg2, "")
call s:hl("Visual",       "",    s:bg2, "")
call s:hl("Search",       s:bg0, s:yellow, "")
call s:hl("IncSearch",    s:bg0, s:orange, "")
call s:hl("MatchParen",   s:orange, s:bg2, "bold")
call s:hl("Folded",       s:fg2, s:bg1, "")
call s:hl("FoldColumn",   s:fg2, s:bg0, "")
call s:hl("SignColumn",   "",    s:bg0, "")
call s:hl("Directory",    s:blue, "", "")
call s:hl("Title",        s:orange, "", "bold")
call s:hl("ErrorMsg",     s:red, s:bg0, "bold")
call s:hl("WarningMsg",   s:yellow, "", "")
call s:hl("MoreMsg",      s:green, "", "")
call s:hl("Question",     s:green, "", "")
call s:hl("NonText",      s:bg3, "", "")
call s:hl("SpecialKey",   s:bg3, "", "")

" ─────────────────────────────────────────────────────────────────────────────────
" Syntax
" ─────────────────────────────────────────────────────────────────────────────────
call s:hl("Comment",      s:fg2, "", "italic")
call s:hl("Constant",     s:orange, "", "")
call s:hl("String",       s:green, "", "")
call s:hl("Character",    s:green, "", "")
call s:hl("Number",       s:pink, "", "")
call s:hl("Boolean",      s:orange, "", "")
call s:hl("Float",        s:pink, "", "")
call s:hl("Identifier",   s:fg0, "", "")
call s:hl("Function",     s:blue, "", "")
call s:hl("Statement",    s:violet, "", "")
call s:hl("Conditional",  s:violet, "", "")
call s:hl("Repeat",       s:violet, "", "")
call s:hl("Label",        s:yellow, "", "")
call s:hl("Operator",     s:red, "", "")
call s:hl("Keyword",      s:violet, "", "")
call s:hl("Exception",    s:red, "", "")
call s:hl("PreProc",      s:yellow, "", "")
call s:hl("Include",      s:violet, "", "")
call s:hl("Define",       s:violet, "", "")
call s:hl("Macro",        s:yellow, "", "")
call s:hl("PreCondit",    s:yellow, "", "")
call s:hl("Type",         s:cyan, "", "")
call s:hl("StorageClass", s:orange, "", "")
call s:hl("Structure",    s:cyan, "", "")
call s:hl("Typedef",      s:cyan, "", "")
call s:hl("Special",      s:orange, "", "")
call s:hl("SpecialChar",  s:orange, "", "")
call s:hl("Tag",          s:orange, "", "")
call s:hl("Delimiter",    s:fg1, "", "")
call s:hl("SpecialComment", s:fg2, "", "italic")
call s:hl("Debug",        s:red, "", "")
call s:hl("Underlined",   s:blue, "", "underline")
call s:hl("Error",        s:red, s:bg0, "bold")
call s:hl("Todo",         s:yellow, s:bg0, "bold")

" ─────────────────────────────────────────────────────────────────────────────────
" Diff
" ─────────────────────────────────────────────────────────────────────────────────
call s:hl("DiffAdd",      s:green, s:bg1, "")
call s:hl("DiffChange",   s:yellow, s:bg1, "")
call s:hl("DiffDelete",   s:red, s:bg1, "")
call s:hl("DiffText",     s:orange, s:bg2, "")

" ─────────────────────────────────────────────────────────────────────────────────
" Git Signs (if using gitgutter or similar)
" ─────────────────────────────────────────────────────────────────────────────────
call s:hl("GitGutterAdd",    s:green, "", "")
call s:hl("GitGutterChange", s:yellow, "", "")
call s:hl("GitGutterDelete", s:red, "", "")

" ─────────────────────────────────────────────────────────────────────────────────
" Spell
" ─────────────────────────────────────────────────────────────────────────────────
call s:hl("SpellBad",   s:red, "", "undercurl")
call s:hl("SpellCap",   s:yellow, "", "undercurl")
call s:hl("SpellLocal", s:cyan, "", "undercurl")
call s:hl("SpellRare",  s:violet, "", "undercurl")
