" Statusline custom Dragon Fire
set laststatus=2
set noshowmode

function! StatusMode()
  let l:m = mode()
  if l:m ==# 'n'     | return '  NORMAL '
  elseif l:m ==# 'i' | return '  INSERT '
  elseif l:m ==# 'v' | return '  VISUAL '
  elseif l:m ==# 'V' | return '  V-LINE '
  elseif l:m ==# '' | return '  V-BLOCK '
  elseif l:m ==# 'c' | return '  COMMAND '
  elseif l:m ==# 'R' | return '  REPLACE '
  else                | return '  ' . toupper(l:m) . ' '
  endif
endfunction

function! StatusGit()
  let l:branch = ''
  silent! let l:branch = system('git -C ' . shellescape(expand('%:p:h')) . ' branch --show-current 2>/dev/null')
  let l:branch = substitute(l:branch, '\n', '', 'g')
  if l:branch != ''
    return '  ' . l:branch . ' '
  endif
  return ''
endfunction

function! StatusModified()
  return &modified ? ' [+]' : ''
endfunction

function! StatusReadonly()
  return &readonly ? ' [RO]' : ''
endfunction

" Highlight groups pour la statusline
hi StatusMode     guifg=#181616 guibg=#fd5622 gui=bold ctermfg=234 ctermbg=202
hi StatusModeI    guifg=#181616 guibg=#87a987 gui=bold ctermfg=234 ctermbg=108
hi StatusModeV    guifg=#181616 guibg=#8ba4b0 gui=bold ctermfg=234 ctermbg=109
hi StatusModeC    guifg=#181616 guibg=#ffab40 gui=bold ctermfg=234 ctermbg=214
hi StatusGit      guifg=#87a987 guibg=#282727 ctermfg=108 ctermbg=236
hi StatusFile     guifg=#e0dcd4 guibg=#1D1C19 ctermfg=251 ctermbg=235
hi StatusMod      guifg=#fd5622 guibg=#1D1C19 gui=bold ctermfg=202 ctermbg=235
hi StatusPos      guifg=#e0dcd4 guibg=#282727 ctermfg=251 ctermbg=236
hi StatusPercent  guifg=#181616 guibg=#fd5622 gui=bold ctermfg=234 ctermbg=202

" Statusline dynamique avec couleur par mode
function! UpdateStatusHighlight()
  let l:m = mode()
  if l:m ==# 'i'
    hi! link StatusMode StatusModeI
  elseif l:m ==# 'v' || l:m ==# 'V' || l:m ==# ''
    hi! link StatusMode StatusModeV
  elseif l:m ==# 'c'
    hi! link StatusMode StatusModeC
  else
    hi StatusMode guifg=#181616 guibg=#fd5622 gui=bold ctermfg=234 ctermbg=202
  endif
  return ''
endfunction

set statusline=
set statusline+=%{UpdateStatusHighlight()}
set statusline+=%#StatusMode#
set statusline+=%{StatusMode()}
set statusline+=%#StatusGit#
set statusline+=%{StatusGit()}
set statusline+=%#StatusFile#
set statusline+=\ %f
set statusline+=%#StatusMod#
set statusline+=%{StatusModified()}
set statusline+=%{StatusReadonly()}
set statusline+=%#StatusFile#
set statusline+=%=
set statusline+=%#StatusPos#
set statusline+=\ %l:%c\
set statusline+=%#StatusPercent#
set statusline+=\ %p%%\
