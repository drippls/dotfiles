" Config file for VIM, edit with vim ~/.vimrc  |  :e ~/.vimrc

" Written on 18-6-2019 by Jude Lakkis
" Last Edited on 15-09-2020 by Jude Lakkis
" Use VIM instead of pure VI (this must be the first instruction)
set nocompatible
 
" ----------------------------------------------------------------
"              Plugins - Import/Calling - VimPlug
" ----------------------------------------------------------------

call plug#begin()
" Universal Colourscheme
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
 
" Lightline Status Bar
Plug 'itchyny/lightline.vim'
 
" General Syntax Plugins
Plug 'scrooloose/syntastic'
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-commentary'

" Snippets & Autocompletion
Plug 'msanders/snipmate.vim'
Plug 'ervandew/supertab'

" Terminal Commands
Plug 'kassio/neoterm'
 
" Language Specific Syntax Plugins
Plug 'vim-python/python-syntax'
Plug 'rust-lang/rust.vim'
Plug 'mattn/webapi-vim'
Plug 'plasticboy/vim-markdown'
Plug 'mattn/emmet-vim'
 
" Prose/Notes Plugins
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-litecorrect'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()


" ----------------------------------------------------------------
"                       Plugin - Settings
" ----------------------------------------------------------------

" Universal Colourscheme Settings
syntax on
set t_Co=256
set background=dark
colorscheme challenger_deep

" Enables true/enhanced colours if possible
if has('nvim') || has('termguicolors')
    set termguicolors
endif

" Lightline Status Bar Settings
set laststatus=2
" Changes theme to molokai
" Shows hexvalue of character on the right of the bar
let g:lightline = {
                \ 'colorscheme': 'molokai',
        \ 'active': {
        \ 'left': [ [ 'mode', 'paste' ],
        \ [ 'readonly', 'filename', 'modified', 'hexcharval' ] ]
        \ },
        \ 'component': {
        \ 'hexcharval': '0x%B',
        \ },
        \ }

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
 
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
 
" Extra Syntax Highlighting
let python_highlight_all = 1

" Vim Commenting
" Sending uncommon Unicode via 
" <Command-/> Single Line Comment
nmap ℔ gcc
" <Control-/> Combined Text Comment (Paragraphs)
nmap ₪  gcap

" VIM Pencil
augroup pencil
  autocmd!
  " autocmd FileType text,markdown,mkd,md call pencil#init({'wrap': 'soft'})
  autocmd FileType * call pencil#init({'wrap': 'soft'})
  " autocmd FileType markdown,mkd call pencil#init({'wrap': 'soft'})
augroup END

 " LiteCorrect
augroup litecorrect
  autocmd!
  autocmd FileType text call litecorrect#init()
  autocmd FileType markdown,mkd call litecorrect#init()
augroup END
 
" Markdown Preview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 1
let g:mkdp_browser = 'firefox'
" Double tap enter to kill any existing preview and load a new preview
autocmd Filetype markdown nnoremap <silent> <CR><CR> <Esc>:MarkdownPreview<CR><Esc>
" autocmd Filetype markdown nnoremap <silent> <CR><CR> <Esc>:MarkdownPreviewStop<CR>:MarkdownPreview<CR><Esc>

" Rust.vim
" Autoformat upon save
let g:rustfmt_autosave = 1
" Copy the url to the clipboard
let g:rust_clip_command = 'pbcopy'
" Check this out later: https://github.com/rust-lang/rust.vim#running-a-test-under-cursor

" SuperTab
" Keeps <Tab> and allowes for <S-Tab> to autocomplete
let g:SuperTabMappingTabLiteral = '<Tab>'
let g:SuperTabMappingForward = '<S-Tab>'


" ----------------------------------------------------------------
" 					Running files in NVIM buffers
" ----------------------------------------------------------------

" Python Files
" Only Line that works perfectly right now
autocmd Filetype python nnoremap <buffer> <Right> :w<cr>:echo system('python3 "' . expand('%') . '"')<cr>

" Vimscript Files
autocmd Filetype vim nnoremap <buffer> <Right> :w<cr>:so %<cr>

" Rust Files
" Without Cargo
autocmd Filetype rust nnoremap <buffer> <Right> :w<cr>:echo system('rustc "' . expand('%') . '"')<cr>:echo system('./"' . expand('%:r') . '"')<cr>

" I just can't figure this out right now, it's been hours… I'm giving up for today and saving my progress
" With Cargo
autocmd Filetype rust nnoremap <buffer> <S-Right> :w<cr>:vs +term<cr>A
" Rust Files /wo Cargo
" Not sure why I can't get this to work…
" autocmd Filetype rust nnoremap <buffer> <Right> :w<cr>sp | term rustc "%" <cr>

" Rust Files /w Cargo
" autocmd Filetype rust nnoremap <buffer> <S-Right> :w<cr>term cargo run<cr>
" autocmd Filetype rust nmap <Right> :split %>% terminal cargo run <CR>
" autocmd Filetype rust nmap <Right> :vs +terminal cargo run<CR>
" autocmd Filetype rust nnoremap <buffer> <S-Right> :w<cr>:echo system('cargo run "' . expand('%') . '"')<cr>

" ----------------------------------------------------------------
" 					  General Editor Settings
" ----------------------------------------------------------------

" Display Settings
" ----------------
 
set encoding=utf-8      " Encoding used for displaying file
set ruler           	" Show the cursor position all the time
set number          	" Show line numbers down the left
set relativenumber      " Show the distance between current line and others
set showmatch           " Highlight matching braces
set noshowmode          " Don't show the mode VIM is currently in
set scrolloff=15        " Adds lines at the end of the file to allow for scrolling

" Navigation
" ---------------------------------------------

" Maps ijkl for movement
map i <Up>
map j <Left>
map k <Down>
" Swaps i & h
noremap h i
noremap H I

" Split Movement
nmap <C-i> <C-w><Up>
nmap <C-k> <C-w><Down>
nmap <C-j> <C-w><Left>
nmap <C-l> <C-w><Right>

" Editing
" ---------------------------------------------

" Generics
set nojoinspaces        " No extra '.' after joining lines
set shiftwidth=4        " Set indentation width to 4 columns
set tabstop=4           " Tab depth == 4 spaces
 
" Split Layouts
set splitbelow          " Creates active Split Below, :sp
set splitright          " Creates active Split Left, :vs
 
" Enable Folding
set foldmethod=indent   " Fold on indentation
set foldlevel=99

" Regular Text Editing
autocmd Filetype text nnoremap <buffer> <Right> ]s
autocmd Filetype markdown  nnoremap <buffer> <Right> ]s
 
set complete+=kspell
 
" Searching
" ---------------------------------------------
 
" Highlights search results
set hlsearch
" Does a case-insensitive search
set ignorecase
" Does an incremental search
set incsearch
" Makes capital searches case sensitive
" While lowercase searches aren't
set ignorecase
set smartcase
" Double Press Esc to remove search highlight
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>
 
" File Output
" ---------------------------------------------
 
" Saves the file with utf-8
set fileencoding=utf-8
" Confirms :q command
set confirm
" Spell Check set to English
set spelllang=en
" Dictionary File
set spellfile=$HOME/Dropbox/vim/spell/en.utf-8.add
" Makes VIM read .md as markdown files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
" Turns on spell check for text and markdown files
" au BufReadPost,BufNewFile *.txt,*.md set spell
au BufNewFile,BufFilePre,BufRead *.html set filetype=html
