" Change la forme du curseur selon le mode (block/line/underline)
let &t_SI = "\e[6 q"  " Insert: barre fine
let &t_SR = "\e[4 q"  " Replace: underscore
let &t_EI = "\e[2 q"  " Normal: block
