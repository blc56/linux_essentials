"vim-plug
"
call plug#begin()
" My bundles here:
" vim-scripts repos
" e.g. vim-scripts/a.vim on github
Plug 'vim-scripts/L9'
Plug 'vim-scripts/a.vim'
" Plug 'CSApprox'
" Plug 'matchit.zip'
Plug 'vim-scripts/renamer.vim'
Plug 'vim-scripts/repeat.vim'
Plug 'vim-scripts/YankRing.vim'
Plug 'powerman/vim-plugin-AnsiEsc'


"other repos
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'xolox/vim-misc'
" Plug 'xolox/vim-easytags'
" Plug 'luochen1990/rainbow'
" Plug 'majutsushi/tagbar'
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'ternjs/tern_for_vim'
" Plug 'https://bitbucket.org/madevgeny/yate.git'
" Plug 'rkitover/vimpager'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" deocomplete
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'
" Plug 'Shougo/deoplete.nvim'

" Java-completion
" https://averywagar.com/posts/2018/01/configuring-vim-for-java-development/
" Plug 'artur-shaik/vim-javacomplete2'
"Code linting
"Plugin 'dense-analysis/ale'

" All of your Plugins must be added before the following line
call plug#end()            " required

"deoplete configuration
" filetype plugin indent on    " required
" call deoplete#custom#option('sources', {
	" \ '_': ['buffer', 'tags'],
	" \ 'java': ['buffer', 'tags', 'javacomplete2', 'jc'], 
" \})

" Java-completion Configuration
" autocmd FileType java setlocal omnifunc=javacomplete#Complete
" remove un-used imports
" map \jr  <Plug>(JavaComplete-Imports-RemoveUnused)
" add un-used imports
" map \ja <Plug>(JavaComplete-Imports-AddMissing)

"ALE Configuration
"let g:ale_java_javac_classpath = javacomplete#server#GetClassPath()
"let g:ale_linters = {
"\  'cs':['syntax', 'semantic', 'issues'],
"\  'python': ['pylint'],
"\  'java': ['javac']
"\ }

set tabstop=4
set shiftwidth=4
set softtabstop=4
set nu " line #s
set noet "don't expand tabs to spaces
filetype plugin on 
" syntax on
set wrap " line wrapping
set lbr " clean wrapping
set textwidth=0 " default line wrap
" start scrolling when the cursor is this many lines from top/bottom 
set scrolloff=10 
set hlsearch " highlight searches
set incsearch " search incrementally
set wrapscan " automaticall "wrap" search around the file
" set guifont=monospace:h10
" set backupdir=~/tmp/vim_backups " don't store backups in current dir
set tabstop=4 " tab wdith expansion
set smarttab
set autoindent
set cindent
set smartindent
" make backspace key work w/o restrictions in insert mode
set backspace=indent,eol,start
set tags=tags;/ " default location of tags file, ; means search backwards until '/'
set noeb " no error bell
set nospell
" ignore whitespace
set diffopt+=iwhite

" enable colors
" this is needed for the csapprox plugin
"if &term =~ '^\(xterm\|screen\)$'
	"set t_Co=256
"endif
"colorscheme evening

" highlight current line
"set cursorline
set nocursorline
"hi cursorline ctermbg=black
"hi cursorline guibg=black
" only highlight current line in current window
"autocmd WinEnter * setlocal cursorline
"autocmd WinLeave * setlocal nocursorline

set statusline=%F%m%r%h%w\ [FMT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" remap visual blockwise selection (column mode)
noremap <C-e> <C-v>

" make ^c and ^v work in *nix
" vmap <C-x> "+x
" vmap <C-c> "+y
" vmap <C-v> "+p
" nmap <C-v> "+p
" imap <C-v> <C-r><C-o>+
" cmap <C-v> <C-r><C-o>+

" cd to directory of current file
map \c :cd <C-R>=expand("%:p:h") . "/" <Enter>

" remap movement on wrapped lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" open tags in new splits
map \s :sp<Enter>:exec("tag ".expand("<cword>"))<Enter>
map \v :vsp<Enter>:exec("tag ".expand("<cword>"))<Enter>
map ,s :sp<Enter>:tag 
map ,v :vsp<Enter>:tag 

" close the stupid omnicomplete cpp box when completed
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" iab <buffer> <unique> ,f <c-r>=fnamemodify(fnamemodify(getreg('%'), ':t'), ':r')<Enter>

" edit vimrc and reload
map ,r :sp ~/.nvimrc<Enter>
map <silent> ,R :source ~/.nvimrc<Enter>:filetype detect<Enter>:exe ":echo 'vimrc reloaded'"<Enter>

" line length limit
" match ErrorMsg '\%>80v.\+'

" Fuzzy file finder of awesomeness
" map \o :FufFile<Enter>
" FZF fuzzy finder
map \o :FZF<enter>
" https://stackoverflow.com/questions/2414626/unsaved-buffer-warning-when-switching-files-buffers
set hidden

" Preserve undo between sessions
set undofile
set undodir=~/.vim/undodir

" Easytags support for javacript
"let g:easytags_languages = { 
"\   'javascript': {
"\	 'cmd': 'jsctags',
"\	   'args': [], 
"\	   'fileoutput_opt': '-f',
"\	   'stdout_opt': '-f-',
"\	   'recurse_flag': ''
"\   }   
"\}

"Easytags use vim search path for tags
"let g:easytags_dynamic_files = 1
" Better easytags performance
"let g:easytags_async = 1
"let g:easytags_on_cursorhold = 1

" omni complete tweaks
"http://vim.wikia.com/wiki/VimTip1386
"insert longest common match
"set completeopt=longest,menuone,menu,preview
" http://vim.wikia.com/wiki/Improve_completion_popup_menu
"exit on escape
"inoremap <expr> <Esc>	  pumvisible() ? "\<C-e>" : "\<Esc>"
"inoremap <expr> <Esc>	  pumvisible() ? "\<Esc>\<Esc>" : "\<Esc>"
"remap enter to select the highlighted entry
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"auto select the first entry and keep typing to select matching entries
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  "\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" options for Deoplete
" ' let g:deoplete#enable_at_startup = 1

"override vims default settings for python files
au FileType python set ts=4 sw=4 noet
au FileType pyrex set ts=4 sw=4 noet
au FileType yaml set ts=2 sw=2 et

" enable rainbow parentheses
" let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" mapping for tag bar
"nmap <leader>r :TagbarToggle<CR>

" mapping for YATE tags earch
"nmap <leader>t :YATE<CR>

" use javascript syntax highlighting for json files
au FileType json set filetype=javascript

" command for inserting a warning comment line
command! InsertWarning :normal OTODO: XXX: BLC DEBUG FIXME!!!<ESC>\cc^
nmap <leader>w :InsertWarning<CR>

" make arrow keys work in terminal vims
"nnoremap <silent> <ESC>OA <UP>
"nnoremap <silent> <ESC>OB <DOWN>
"nnoremap <silent> <ESC>OC <RIGHT>
"nnoremap <silent> <ESC>OD <LEFT>
"inoremap <silent> <ESC>OA <UP>
"inoremap <silent> <ESC>OB <DOWN>
"inoremap <silent> <ESC>OC <RIGHT>
"inoremap <silent> <ESC>OD <LEFT>
"vnoremap <silent> <ESC>OA <UP>
"vnoremap <silent> <ESC>OB <DOWN>
"vnoremap <silent> <ESC>OC <RIGHT>
"vnoremap <silent> <ESC>OD <LEFT>
