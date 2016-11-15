"------------------------------------------------------------------------------
" VUNDLE PLUGIN CONFIGS
"------------------------------------------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to includise Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Searcher
Plugin 'rking/ag.vim'

" Swift syntax highlighting
Plugin 'keith/swift.vim'

" Build Xcode project from within vim
Plugin 'gfontenot/vim-xcode'

" Color schemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'w0ng/vim-hybrid.git'
Plugin 'nanotech/jellybeans.vim'
Plugin 'chriskempson/base16-vim'

" Filesystem explore
Plugin 'scrooloose/nerdtree.git'

" Git integration
Plugin 'tpope/vim-fugitive'

" Tmux integration
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'

" Fuzzy search
Plugin 'ctrlpvim/ctrlp.vim'

" Status/tabline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Completion
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'rdnetto/YCM-Generator'
"Plugin 'keith/sourcekittendaemon.vim'
Plugin 'mitsuse/autocomplete-swift'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"------------------------------------------------------------------------------
" EOF VUNDLE PLUGIN CONFIGS
"------------------------------------------------------------------------------

" Colors
"------------------------------------------------------------------------------
syntax enable           " enable syntax processing
set background=dark
colorscheme hybrid      " default colorscheme

" Spaces & indenting
"------------------------------------------------------------------------------
set tabstop=4           " number of visual spaces PER TAB character
set softtabstop=4       " number of spaces inserted when hitting tab
set shiftwidth=4        " number of spaces to add/remove when indenting
set expandtab           " tabs are spaces
set backspace=indent,eol,start " make backspace work after e.g. ctrl+A
"set list               " show invisible characters

" UI config
"------------------------------------------------------------------------------
set number              " show absolute line number on current line
set relativenumber      " show relative line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching brackets etc
set cc=80               " highlight column 80
set guioptions-=r       " remove right-hand scroll bar
set guioptions-=L       " remove left-hand scroll bar

" Searching
"------------------------------------------------------------------------------
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase          " ignore case ..
set smartcase           " .. unless search string contains caps
set path=**             " find files recursively with :find
set complete-=i         " do not scan included files for autocomplete (slow)

" Backup and swap files
"------------------------------------------------------------------------------
set nobackup            " no backup files
"set noswapfile          " no swap files
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//

" Mouse support
"------------------------------------------------------------------------------
set ttyfast
set mouse=a

" Key mappings
"------------------------------------------------------------------------------
imap jj <Esc>

map § ~
cnoremap § ~

" Save
nnoremap <silent> <C-S> :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>
nnoremap <silent> <leader>w :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>

" Quit
nnoremap <leader>q :q<CR>

" Show / in lower  right corner when pressing leader.
map <space> <leader>

" Open new tab
nnoremap <leader>t :tabnew<CR>

" Remove trailing blanks
nnoremap <leader>b :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Quick window switching
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

map <F5> :VimuxPromptCommand<CR>
map <F6> :VimuxRunLastCommand<CR>

"PLUGIN CONFIGS
"------------------------------------------------------------------------------

" Start NERDTree
"autocmd VimEnter * NERDTree
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
nnoremap <leader>e :NERDTreeToggle<CR>

" CtrlP configs
" Should make it faster ... should test more
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 0

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|o|d|dylib|swiftmodule|dia|swiftdeps)$',
  \ }

" Airline configs
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts=1
set laststatus=2 " show statusline by default

"OTHER
"------------------------------------------------------------------------------
set autoread

augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


"OS SPECIFIC
"------------------------------------------------------------------------------

let s:uname = system("echo -n \"$(uname)\"")

if has("win32") || s:uname=='MINGW64_NT-10.0'
    "Windows options here
    "set guifont=Courier_New:h11:cDEFAULT
    set guifont=Consolas:h11:b:cANSI
    "set guifont=Lucida_Console:h10
    "set guifont=courier_new:h11:b
    scriptencoding utf-8
    set encoding=utf-8
    set listchars=trail:·,tab:>\ ,eol:¬ " show invisible characters
else
  if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        "Mac options here
        set guifont=Menlo:h15
        set listchars=trail:·,tab:▸\ ,eol:¬ " show invisible characters
        set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.d
        let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
        set ttymouse=xterm2
    else
        "Linux options here
    endif
  endif
endif
