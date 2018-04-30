filetype plugin indent on
syn on se title
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
syntax enable
colorscheme monokai
set number
execute pathogen#infect()
call pathogen#helptags()
autocmd vimenter * NERDTree
