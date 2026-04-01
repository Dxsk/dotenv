" Indentation
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" Recherche
set incsearch
set hlsearch
set ignorecase
set smartcase
nnoremap <Esc> :nohlsearch<CR>

" UI
set wildmenu
set wildoptions=pum
set pumheight=12
set showcmd
set showmatch
set matchtime=2
set signcolumn=yes
set fillchars=vert:│,fold:─,eob:\
set list
set listchars=tab:▸\ ,trail:·,extends:›,precedes:‹

" Pas de bruit
set belloff=all

" Performances
set lazyredraw
set ttyfast
set updatetime=250

" Splits
set splitbelow
set splitright

" Historique
set undofile
set undodir=~/.vim/undodir
set history=1000
