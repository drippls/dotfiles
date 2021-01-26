" NeoVIM Config - 2021

" ----------------------------------------------------------------
"              Plugins - Import/Calling - VimPlug
" ----------------------------------------------------------------

call plug#begin()
" Universal Color Scheme
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

" Lightline Status Bar
Plug 'itchyny/lightline.vim'

" Syntax Plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'

" Language Specific Plugins
Plug 'vim-python/python-syntax'
Plug 'rust-lang/rust.vim'
Plug 'mattn/emmet-vim'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'mattn/webapi-vim'

" Prose and Plane Text
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-litecorrect'

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

" CoC Settings
" ---------------
" Tab Completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" CoC Snippet Activation
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Python Provider Solution
if has('macunix')
	let g:python3_host_prog = '/usr/local/bin/python3' " -- Set python 3 provider
endif

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
 
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1

" Extra Syntax Highlighting
let python_highlight_all = 1
let g:syntastic_check_on_wq = 0

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

" Rust.vim
" Autoformat upon save
let g:rustfmt_autosave = 1
" Copy the url to the clipboard
let g:rust_clip_command = 'pbcopy'
" Check this out later: https://github.com/rust-lang/rust.vim#running-a-test-under-cursor

" Remapping Emmet Bindings
" Expand globally
let g:user_emmet_expandabbr_key = '<c-Shift-E>'


" ----------------------------------------------------------------
" 					Running files in NVIM buffers
" ----------------------------------------------------------------

" Run Python files in buffer
autocmd Filetype python nnoremap <buffer> <Right> :w<cr>:echo system('python3 "' . expand('%') . '"')<cr>

" Vimscript Files
autocmd Filetype vim nnoremap <buffer> <Right> :w<cr>:so %<cr>

" Rust Files
" Without Cargo
autocmd Filetype rust nnoremap <buffer> <Right> :w<cr>:echo system('rustc "' . expand('%') . '"')<cr>:echo system('./"' . expand('%:r') . '"')<cr>
" With Cargo
autocmd Filetype rust nnoremap <buffer> <S-Right> :w<cr>:vs +term<cr>A


" ----------------------------------------------------------------
" 					  General Editor Settings
" ----------------------------------------------------------------

" NAVIGATION
" --------------- 
" Maps ijkl for movement
map i <Up>
map j <Left>
map k <Down>
" Swaps i & h
nnoremap h i
nnoremap H I
" Split Movement
nmap <C-i> <C-w><Up>
nmap <C-k> <C-w><Down>
nmap <C-j> <C-w><Left>
nmap <C-l> <C-w><Right>


" DISPLAY
" --------------- 
set encoding=utf-8      " Encoding used for displaying file
set ruler           	" Show the cursor position all the time
set number          	" Show line numbers down the left
set relativenumber      " Show the distance between current line and others
set showmatch           " Highlight matching braces
set noshowmode          " Don't show the mode VIM is currently in
set scrolloff=15        " Adds lines at the end of the file to allow for scrolling


" EDITING
" --------------- 
" Generics
set nojoinspaces        " No extra '.' after joining lines
set shiftwidth=4        " Set indentation width to 4 columns
set tabstop=4           " Tab depth == 4 spaces
 
" Split Layouts
set splitbelow          " Creates active Split Below, :sp
set splitright          " Creates active Split Left, :vs
 
" Enable Folding
set foldmethod=indent   " Fold on indentation
set foldlevel=99	" Fully fold

" Spell Check and Corrections
autocmd Filetype text,markdown nnoremap <buffer> <Right> ]s
autocmd Filetype text,markdown nnoremap <buffer> <S-Right> z=
set complete+=kspell


" SEARCHING
" --------------- 
set hlsearch		" Highlights search results
set ignorecase		" Case-insensitive search
set incsearch		" Incremental searching
set smartcase		" Makes capital searchs case sensitive
set ignorecase		" But not for lowercase searches

" Double Press Esc to remove search highlight
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>
