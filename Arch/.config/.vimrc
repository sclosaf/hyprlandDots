" ====================
"  Basic Vim Behavior
" ====================
set nocompatible
filetype plugin indent on
syntax on

" ==================
"  UI Configuration
" ==================
set number relativenumber
set ruler
set cursorline
set laststatus=2
set noshowmode
set showcmd
set cmdheight=2
set wildmenu
set wildmode=list:longest,full
set wildoptions=pum
set pumheight=10
set scrolloff=8
set sidescrolloff=8
set splitbelow
set splitright
set scroll=1
set mouse=a

" Color and Theme
set background=dark
if has('termguicolors')
    set termguicolors
endif

" ==============
"  Text Editing
" ==============
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set showmatch
set wrap
set textwidth=80
set backspace=indent,eol,start
set clipboard=unnamedplus

" ========
"  Search
" ========
set incsearch
set hlsearch
set ignorecase
set smartcase

" =================
"  File Management
" =================
set nobackup
set nowritebackup
set noswapfile
set undofile
set undodir=~/.vim/undodir
set autoread
set autowrite

" =====================
"  Whitespace Handling
" =====================
set list
set listchars=tab:>-,trail:~,nbsp:~
highlight ExtraWhitespace ctermbg=red guibg=red ctermfg=white guifg=white
match ExtraWhitespace /\s\+$/
autocmd BufWritePre * :%s/\s\+$//e

" =========
"  Folding
" =========
set foldmethod=indent
set foldlevelstart=99

" ======================
"  Plugin Configuration
" ======================
call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
call plug#end()

let g:lightline = {
    \ 'colorscheme' : 'nord',
    \ 'active' : {
    \   'left' : [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modificed' ] ]
    \ },
    \ 'component_function' : {
    \   'filename' : 'LightlineFilename'
    \ },
    \ }

function! LightlineFilename()
    return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

colorscheme nord

" ===================
"  FileType Specific
" ===================
augroup man_settings
    autocmd!
    autocmd FileType man setlocal nonumber norelativenumber | setlocal foldmethod=manual
augroup END

augroup CursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

autocmd FileType text,markdown setlocal spell spelllang=en_us

" ==================
"  Visual and Sound
" ==================
set noerrorbells
set visualbell
set belloff=all
