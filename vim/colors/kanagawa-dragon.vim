" Dragon Fire colorscheme for Vim — Enhanced
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "kanagawa-dragon"

" ─── Palette ───
" bg:       #181616    bg_dim:   #0d0c0c    bg_light: #1D1C19
" bg_mid:   #282727    bg_edge:  #393836    fg_dim:   #625e5a
" fg:       #e0dcd4    fg_soft:  #9e9b93
" orange:   #fd5622    red:      #e53935    amber:    #ffab40
" green:    #87a987    blue:     #8ba4b0    coral:    #ff7a3d
" magenta:  #c4746e    violet:   #a292a3    teal:     #6a9589

" ─── UI Base ───
hi Normal        guifg=#e0dcd4 guibg=#181616 ctermfg=251  ctermbg=234
hi NormalFloat   guifg=#e0dcd4 guibg=#0d0c0c ctermfg=251  ctermbg=232
hi FloatBorder   guifg=#fd5622 guibg=#0d0c0c ctermfg=202  ctermbg=232
hi FloatTitle    guifg=#ffab40 guibg=#0d0c0c ctermfg=214  ctermbg=232  gui=bold
hi CursorLine    guibg=#1D1C19 ctermbg=235   cterm=NONE   gui=NONE
hi CursorColumn  guibg=#1D1C19 ctermbg=235
hi CursorLineNr  guifg=#fd5622 guibg=#1D1C19 ctermfg=202  ctermbg=235  gui=bold
hi LineNr        guifg=#625e5a ctermfg=241
hi SignColumn    guibg=#181616 ctermbg=234
hi VertSplit     guifg=#393836 guibg=NONE    ctermfg=238  ctermbg=NONE
hi WinSeparator  guifg=#393836 guibg=NONE    ctermfg=238  ctermbg=NONE
hi EndOfBuffer   guifg=#282727 guibg=NONE    ctermfg=236
hi NonText       guifg=#393836 ctermfg=238
hi SpecialKey    guifg=#393836 ctermfg=238
hi Conceal       guifg=#625e5a guibg=NONE    ctermfg=241
hi ColorColumn   guibg=#1D1C19 ctermbg=235
hi Whitespace    guifg=#393836 ctermfg=238

" ─── Popup / Menu ───
hi Pmenu         guifg=#e0dcd4 guibg=#1D1C19 ctermfg=251  ctermbg=235
hi PmenuSel      guifg=#181616 guibg=#fd5622 ctermfg=234  ctermbg=202
hi PmenuSbar     guibg=#282727 ctermbg=236
hi PmenuThumb    guibg=#fd5622 ctermbg=202
hi WildMenu      guifg=#181616 guibg=#fd5622 ctermfg=234  ctermbg=202  gui=bold

" ─── Tabs ───
hi TabLine       guifg=#625e5a guibg=#282727 ctermfg=241  ctermbg=236
hi TabLineSel    guifg=#181616 guibg=#fd5622 ctermfg=234  ctermbg=202  gui=bold
hi TabLineFill   guibg=#0d0c0c ctermbg=232

" ─── Selection / Search ───
hi Visual        guibg=#3d2020 ctermbg=52
hi VisualNOS     guibg=#3d2020 ctermbg=52
hi Search        guifg=#181616 guibg=#ffab40 ctermfg=234  ctermbg=214
hi IncSearch     guifg=#181616 guibg=#fd5622 ctermfg=234  ctermbg=202
hi CurSearch     guifg=#181616 guibg=#fd5622 ctermfg=234  ctermbg=202  gui=bold
hi MatchParen    guifg=#fd5622 guibg=#393836 ctermfg=202  ctermbg=238  gui=bold
hi Substitute    guifg=#181616 guibg=#e53935 ctermfg=234  ctermbg=160

" ─── StatusLine ───
hi StatusLine    guifg=#e0dcd4 guibg=#282727 ctermfg=251  ctermbg=236
hi StatusLineNC  guifg=#625e5a guibg=#1D1C19 ctermfg=241  ctermbg=235

" ─── Messages ───
hi ModeMsg       guifg=#fd5622 gui=bold ctermfg=202
hi MoreMsg       guifg=#87a987 ctermfg=108
hi Question      guifg=#8ba4b0 ctermfg=109
hi WarningMsg    guifg=#ffab40 ctermfg=214
hi ErrorMsg      guifg=#e53935 guibg=NONE ctermfg=160  gui=bold
hi Title         guifg=#fd5622 gui=bold ctermfg=202

" ─── Diagnostics ───
hi DiagnosticError   guifg=#e53935 ctermfg=160
hi DiagnosticWarn    guifg=#ffab40 ctermfg=214
hi DiagnosticInfo    guifg=#8ba4b0 ctermfg=109
hi DiagnosticHint    guifg=#6a9589 ctermfg=72
hi DiagnosticUnderlineError gui=undercurl guisp=#e53935
hi DiagnosticUnderlineWarn  gui=undercurl guisp=#ffab40
hi DiagnosticUnderlineInfo  gui=undercurl guisp=#8ba4b0
hi DiagnosticUnderlineHint  gui=undercurl guisp=#6a9589

" ─── Syntax ───
hi Comment       guifg=#625e5a ctermfg=241   gui=italic
hi Constant      guifg=#ff7a3d ctermfg=209
hi String        guifg=#87a987 ctermfg=108
hi Character     guifg=#87a987 ctermfg=108
hi Number        guifg=#ff7a3d ctermfg=209
hi Float         guifg=#ff7a3d ctermfg=209
hi Boolean       guifg=#ff7a3d ctermfg=209   gui=italic
hi Identifier    guifg=#e0dcd4 ctermfg=251
hi Function      guifg=#8ba4b0 ctermfg=109
hi Statement     guifg=#e53935 ctermfg=160   gui=NONE
hi Keyword       guifg=#fd5622 ctermfg=202
hi Conditional   guifg=#e53935 ctermfg=160
hi Repeat        guifg=#e53935 ctermfg=160
hi Label         guifg=#c4746e ctermfg=167
hi Operator      guifg=#fd5622 ctermfg=202
hi Exception     guifg=#e53935 ctermfg=160   gui=bold
hi PreProc       guifg=#fd5622 ctermfg=202
hi Include       guifg=#e53935 ctermfg=160
hi Define        guifg=#e53935 ctermfg=160
hi Macro         guifg=#c4746e ctermfg=167
hi PreCondit     guifg=#fd5622 ctermfg=202
hi Type          guifg=#ffab40 ctermfg=214   gui=NONE
hi StorageClass  guifg=#fd5622 ctermfg=202
hi Structure     guifg=#ffab40 ctermfg=214
hi Typedef       guifg=#ffab40 ctermfg=214
hi Special       guifg=#ff7a3d ctermfg=209
hi SpecialChar   guifg=#ff7a3d ctermfg=209
hi Tag           guifg=#fd5622 ctermfg=202
hi Delimiter     guifg=#9e9b93 ctermfg=247
hi SpecialComment guifg=#a292a3 ctermfg=138  gui=italic
hi Debug         guifg=#e53935 ctermfg=160
hi Underlined    guifg=#8ba4b0 gui=underline ctermfg=109
hi Ignore        guifg=#393836 ctermfg=238
hi Todo          guifg=#ffab40 guibg=NONE    ctermfg=214  gui=bold,italic
hi Error         guifg=#e53935 guibg=NONE    ctermfg=160  gui=bold

" ─── Diff ───
hi DiffAdd       guifg=#87a987 guibg=#1a2a1a ctermfg=108  ctermbg=235
hi DiffChange    guifg=#ffab40 guibg=#2a2418 ctermfg=214  ctermbg=235
hi DiffDelete    guifg=#e53935 guibg=#2a1818 ctermfg=160  ctermbg=235
hi DiffText      guifg=#ffab40 guibg=#393836 ctermfg=214  ctermbg=238  gui=bold
hi Added         guifg=#87a987 ctermfg=108
hi Changed       guifg=#ffab40 ctermfg=214
hi Removed       guifg=#e53935 ctermfg=160

" ─── Folding ───
hi Folded        guifg=#625e5a guibg=#1D1C19 ctermfg=241  ctermbg=235  gui=italic
hi FoldColumn    guifg=#625e5a guibg=NONE    ctermfg=241

" ─── Spelling ───
hi SpellBad      guisp=#e53935 gui=undercurl cterm=undercurl
hi SpellCap      guisp=#ffab40 gui=undercurl cterm=undercurl
hi SpellRare     guisp=#a292a3 gui=undercurl cterm=undercurl
hi SpellLocal    guisp=#6a9589 gui=undercurl cterm=undercurl

" ─── Git Signs (si plugin) ───
hi GitSignsAdd    guifg=#87a987 guibg=NONE ctermfg=108
hi GitSignsChange guifg=#ffab40 guibg=NONE ctermfg=214
hi GitSignsDelete guifg=#e53935 guibg=NONE ctermfg=160

" ─── Indent / Guides ───
hi IndentBlanklineChar        guifg=#282727 gui=nocombine ctermfg=236
hi IndentBlanklineContextChar guifg=#fd5622 gui=nocombine ctermfg=202

" ─── Terminal cursor ───
hi TermCursor    guibg=#fd5622 ctermfg=202
hi TermCursorNC  guibg=#393836 ctermfg=238

" ─── Markdown ───
hi markdownH1       guifg=#fd5622 gui=bold ctermfg=202
hi markdownH2       guifg=#e53935 gui=bold ctermfg=160
hi markdownH3       guifg=#ffab40 gui=bold ctermfg=214
hi markdownH4       guifg=#87a987 gui=bold ctermfg=108
hi markdownCode     guifg=#ff7a3d guibg=#1D1C19 ctermfg=209 ctermbg=235
hi markdownCodeBlock guifg=#9e9b93 guibg=#1D1C19 ctermfg=247 ctermbg=235
hi markdownBold     guifg=#e0dcd4 gui=bold ctermfg=251
hi markdownItalic   guifg=#a292a3 gui=italic ctermfg=138
hi markdownUrl      guifg=#8ba4b0 gui=underline ctermfg=109
hi markdownLinkText guifg=#6a9589 ctermfg=72
