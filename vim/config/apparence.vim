" Apparence
set number
set relativenumber
set cursorline
set cursorcolumn
set termguicolors
set background=dark
colorscheme kanagawa-dragon

" Transparent background (inherit terminal opacity)
augroup TransparentBG
  autocmd!
  autocmd ColorScheme * hi Normal guibg=NONE ctermbg=NONE
  autocmd ColorScheme * hi NormalFloat guibg=#0d0c0c
  autocmd ColorScheme * hi SignColumn guibg=NONE ctermbg=NONE
  autocmd ColorScheme * hi LineNr guibg=NONE ctermbg=NONE
  autocmd ColorScheme * hi CursorLineNr guibg=NONE ctermbg=NONE
  autocmd ColorScheme * hi EndOfBuffer guifg=#282727 guibg=NONE ctermbg=NONE
augroup END
doautocmd TransparentBG ColorScheme
