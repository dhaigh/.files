set nocompatible

call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'jose-elias-alvarez/typescript.nvim'
call plug#end()

lua require('lang-server-config')
lua require('theming')

"fzf
let $FZF_DEFAULT_COMMAND = 'rg --fixed-strings --files --no-ignore-vcs --hidden -g "!node_modules/" -g "!.git/*" -g "!**/.git/*" -g "!*.pyc" -g "!frontend/coverage/*" -g "!target/debug/*" -g "!.DS_Store"'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --fixed-strings --hidden --column --line-number --no-heading --color=always --smart-case -g "!.git/*" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

"NERDTree
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let NERDTreeNaturalSort = 1
let NERDTreeCaseSensitiveSort = 1
let g:NERDTreeWinSize=50
nmap <leader>r :NERDTreeFind<cr>

"general
syntax on
set cursorline
set encoding=utf-8 nobomb
set nobackup
set nowrap
set nospell
set number
set ruler
set showtabline=2 "always show tab bar
set wildignore=*.class,.zsh_history,.zcompdump
set incsearch
set hlsearch
set relativenumber
set nojoinspaces "one space instead of two when doing gq
set textwidth=80
set suffixesadd=.js
set clipboard=unnamed "use system clipboard as unnamed register

"swap
set directory=~/.config/nvim/swaps

"tabs
set expandtab "<tab> produces spaces
set softtabstop=4 "num spaces with <tab>
set shiftwidth=4 "num spaces with < and >
set tabstop=8 "num spaces rendered by a tab character

"indentation
"set autoindent "autoindent
"set smartindent "indent on <cr>

"buffers and tabs
set hidden
nmap <tab> :bnext<cr>
nmap <s-tab> :bprevious<cr>
nmap <leader>q :bp <bar> bd #<cr>
nmap <leader>b :bufdo bd<cr>
nmap <leader>h :hide<cr>
nmap <c-t> :Files<cr>
nmap <c-space> :Buffers<cr>

"search current selection
vnoremap <leader>f "zy/<c-r>z<cr>

"open ts modules
nnoremap <c-p> 0f'lgf:noh<cr>

"clear search
nmap <c-n> :noh<cr>

"disable ex mode
nmap Q <nop>

"handy shortcuts
nnoremap ! g*
vnoremap ! y:Rg <c-r>"<cr>

"horizontal navigation
nnoremap <m-h> 4zh
nnoremap <m-l> 4zl

"window navigation
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"paragraph navigation
noremap <c-k> {
noremap <c-j> }

"remap <esc>
inoremap <c-c> <esc>

"make c not yank
nnoremap c "_c
nnoremap C "_C


"emacsy bash bindings
inoremap <c-a> <c-o>^
inoremap <c-d> <c-o>x
inoremap <c-e> <c-o>$
inoremap <c-k> <c-o>C
inoremap <c-l> <c-o>dw
inoremap <c-u> <c-o>S

"discard junk from default register when we use s/S
nnoremap s "_s
nnoremap S "_S
vnoremap s "_s

"keep default register when we use p/P
vnoremap p pgvy
vnoremap P Pgvy

"easier alias for $ (conveniently next to 0)
nnoremap - $
vnoremap - $h

"wq accidental capitals
command Wq wq
command WQ wq
command W w
command QQ qa!
command Q q
command Sort sort
command S sort

"open vimrc
command VR e ~/.config/nvim/init.vim
command VT e ~/.tmux.conf
command VZ e ~/.zshrc
command VL e ~/.config/nvim/lua/lang-server-config.lua

"make brackets useful
nnoremap ( F(
nnoremap ) f)
vnoremap ( F(
vnoremap ) f)

"emacs-inspired zz
nnoremap <m-l> zz

"feels nicer to have # and * next to each other. * is hard to reach
nnoremap $ *

"swap between files
nnoremap <leader><leader> <c-^>

"next tab
nnoremap T :tabn<cr>

"common things to type
inoremap <leader>p import pdb; pdb.set_trace()<esc>
inoremap <leader>r println!("{}",
inoremap <leader>c console.log(
inoremap <leader>d debugger;<esc>
inoremap <leader>e // eslint-disable-next-line<esc>

"clear whitespace on save
autocmd BufWritePre * %s/\s\+$//e

autocmd FileType typescript setlocal suffixesadd+=.ts,.tsx,.d.ts
autocmd FileType typescriptreact setlocal suffixesadd+=.ts,.tsx,.d.ts

"project-specific
set includeexpr=substitute(v:fname,'clipchamp_stack/','','')

autocmd FileType typescript setlocal suffixesadd+=.ts
set includeexpr=substitute(v:fname,'clipchamp_stack/','','')

"eslint_d
nnoremap <leader>f mF:%!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>`F
