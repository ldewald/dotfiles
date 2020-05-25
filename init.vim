call plug#begin()
" A Vim plugin which shows a git diff in the 'gutter' (sign column).
Plug 'airblade/vim-gitgutter'
" Color scheme
Plug 'ayu-theme/ayu-vim'
" Syntax highlighting for .toml
Plug 'cespare/vim-toml'
" Full path fuzzy file
Plug 'ctrlpvim/ctrlp.vim'
" scrooloose/nerdcommenter ???
" Toggle code to comment
Plug 'ddollar/nerdcommenter'
" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'
" provides ALE indicator for the lightline vim plugin
Plug 'maximbaz/lightline-ale'
" Wrapper for prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'json', 'graphql', 'yaml', 'html'] }
" Wrapper for git
Plug 'tpope/vim-fugitive'
" Modify 'surrounding' pairs
Plug 'tpope/vim-surround'
" Asynchronous linting/fixing
Plug 'w0rp/ale'

Plug 'ervandew/supertab'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'

call plug#end()

let g:ale_fixers = {
  \ 'javascript': [
  \   'eslint',
  \   'prettier'
  \ ],
  \ 'python': ['autopep8', 'isort'],
  \ 'ruby': ['rubocop'],
  \ 'rust': ['rustfmt']
  \}

let g:ale_completion_enabled = 1

let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
colorscheme ayu
set colorcolumn=80

set number
set cursorline
set nowrap
set noshowmode

" After whitespace, insert the current directory into a command-line path
cnoremap <expr> <C-P> getcmdline()[getcmdpos()-2] ==# ' ' ? expand('%:p:h') : "\<C-P>"

inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
map <leader>/ <plug>NERDCommenterToggle<CR>
map <leader>f :ALEFix<CR>
map <leader>p :Prettier<CR>
nmap ; :
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

nmap du dt_
nmap cu ct_

set expandtab shiftwidth=2 softtabstop=2 smarttab
