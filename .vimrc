call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'

Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }

call plug#end()

set nomodeline
set smartcase
