" Enable syntax processing
syntax enable

" Color theme
set background=dark
colorscheme solarized

" Folding
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " 10 nested fold max

" Indenting
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

" Search
set hlsearch            " highlight matches
set incsearch           " search as characters are entered

" UI
set cursorline          " highlight current line
set number              " show line numbers
set ruler               " display line and column numbers
set showmatch           " highlight matching [{()}]

" Highlight extra whitespaces
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

" Load filetype-specific indent files
filetype indent on

" Remaps
"
" space open/closes folds
nnoremap <space> za

" Vim-plug
call plug#begin('~/.vim/plugged')

Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'

" Add plugins to &runtimepath
call plug#end()

" NERDTree
"
" Open automatically if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open automatically ion opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Open with Ctrl+n
map <C-n> :NERDTreeToggle<CR>
" Close vim if NERDTree is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
