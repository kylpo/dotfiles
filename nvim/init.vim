" vim: set foldmethod=marker:
" zM to fold all
" zr to open all folds
" za to toggle a fold
"
" ==============================================================================
" PLUGINS
" SETTINGS
" PLUGIN_SETTINGS
" FUNCTIONS
" KEYBINDINGS
" ==============================================================================

set nocompatible

" let g:python3_host_prog = '/Users/kylpo/.pyenv/versions/neovim3/bin/python'

" ============================================================================
" PLUGIN {{{
" ==============================================================================
" - Editor
" - Themes
" - Editing
" - Git
" - Movement
" - Searching
" - Syntaxes
" - ProjectConfig
" - Tools
" ==============================================================================

call plug#begin()

" ==============================================================================
" Editor
" ==============================================================================
"Plug 'tpope/vim-sensible'             " Sensible defaults

Plug 'jordwalke/VimAutoMakeDirectory' " Make directory if needed
Plug 'jordwalke/VimCloser'            " Go to Left when closing like everything else in the world
" Plug 'AndrewRadev/undoquit.vim'       " Re-open a quit window (like browser tabs)
Plug 'ntpeters/vim-better-whitespace' " Highlight whitespace
" Plug 'moll/vim-bbye'                  " Add :Bdelete command to close buffer without changing layout.
Plug 'wesQ3/vim-windowswap'           " Single command for grabbing then swapping windows.
Plug 'milkypostman/vim-togglelist'    " Allows binding key to toggle location and quickfix lists
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'jordwalke/VimSplitBalancer'     " window manager

Plug 'junegunn/goyo.vim'              " Zen mode
Plug 'junegunn/limelight.vim'         " Highlight code around cursor. Rest is grey
Plug 'junegunn/vim-peekaboo'          " Register preview on RHS with <doubleQuote> or @ key



" ==============================================================================
" Themes
" ==============================================================================
" Plug 'chriskempson/base16-vim'
Plug 'wincent/pinnacle'
" Plug 'dracula/vim'
" Plug 'jordwalke/VimCleanColors'       " Colorschemes
" Plug 'altercation/vim-colors-solarized'
" Plug 'quanganhdo/grb256'
" Plug 'daylerees/colour-schemes', { 'rtp': 'vim/' }
" Plug 'rakr/vim-one'


" ==============================================================================
" Editing
" ==============================================================================
Plug 'tpope/vim-repeat'                   " Dot operator for extensions
Plug 'tpope/vim-surround'                 " Edit surround
Plug 'tomtom/tcomment_vim'                " Commenter
Plug 'junegunn/vim-easy-align'            " Align lines based on a character
" Plug 'vim-scripts/YankRing.vim'           " Like Emacs' yankring
Plug 'vim-scripts/Parameter-Text-Objects' " Defines Parameter as a Text Object `viP`
Plug 'wellle/targets.vim'                 " Add more Text Objects like `cin` and `da,`
Plug 'sickill/vim-pasta'                  " Paste with indentation
" Plug 'tpope/vim-abolish'                  " Auto-correct spelling of some words
Plug 'MartinLafreniere/vim-PairTools'     " Auto-close pair, like ()
" Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'                    " <Space>u - open undoTree

" gs - open scratch window in insert mode. Pastes what is already selected.
Plug 'mtth/scratch.vim' " :Scratch

" leader<e> in Normal mode to 'edit' word, and replace it throughout file
Plug 'wincent/scalpel'

Plug 'sbdchd/neoformat'

" :Far foo bar **/*.py
" :Fardo
Plug 'brooth/far.vim'

" Repeat last macro with Enter if in normal buffer
" Plug 'wincent/replay'


" ==============================================================================
" Git
" ==============================================================================
Plug 'airblade/vim-gitgutter'             " Show git changes in gutter.
Plug 'tpope/vim-fugitive'                 " Git command helpers (:G*)

" Really good diff viewer. Select lines and press enter to see diff.
Plug 'junegunn/gv.vim'


" ==============================================================================
" Movement
" ==============================================================================
Plug 'bkad/CamelCaseMotion'
Plug 'kana/vim-textobj-user'                " For custom text objects, needed for all vim-textobj plugins.
" Plug 'Julian/vim-textobj-variable-segment'  " Variable (CamelCase or underscore) segment text object (iv / av).
" Plug 'whatyouhide/vim-textobj-xmlattr'      " HTML/XML attribute text object (ix / ax).
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-smooth-scroll'
Plug 'vim-scripts/matchit.zip'              " enhances % command to jump to corresponding html tags
Plug 'tpope/vim-rsi'                        " Readline key bindings for Vim (C-a, C-e etc.).
Plug 'justinmk/vim-sneak'


" ==============================================================================
" Searching
" ==============================================================================
Plug 'haya14busa/incsearch.vim'
Plug 'wincent/loupe'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'gabesoft/vim-ags'
" Plug 'rking/ag.vim'
Plug 'wincent/ferret' " Search and Replace in project

" This plugin allows you to select some text using Vim's visual mode, then hit * and # to search for it elsewhere in the file.
Plug 'bronson/vim-visual-star-search'


" ==============================================================================
" Syntaxes
" ==============================================================================
" Plug 'pangloss/vim-javascript', { 'branch': 'develop' }
Plug 'pangloss/vim-javascript'
Plug 'vim-scripts/HTML-AutoCloseTag'
Plug 'flowtype/vim-flow'
" Plug 'mxw/vim-jsx'
Plug 'kylpo/vim-jsx/'
Plug 'galooshi/vim-import-js'
" Plug 'kylpo/vim-import-js'
Plug 'ruanyl/vim-fixmyjs'
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'tpope/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'
Plug 'GutenYe/json5.vim'
" Plug 'othree/xml.vim'

" Markdown preview for OS X via :Xmark
Plug 'junegunn/vim-xmark', { 'do': 'make' }

" Plug 'chrisbra/Colorizer'


" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
" Plug 'Quramy/tsuquyomi'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'ianks/vim-tsx'


" Plug 'othree/yajs.vim'
" Plug 'othree/es.next.syntax.vim'
" Plug 'othree/javascript-libraries-syntax.vim'
" let g:used_javascript_libs = 'underscore,react'


" ==============================================================================
" ProjectConfig
" ==============================================================================
Plug 'tpope/vim-projectionist'
Plug 'embear/vim-localvimrc'


" ==============================================================================
" Tools
" ==============================================================================
Plug 'ervandew/supertab'
" Plug 'SirVer/ultisnips'

Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
" Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'steelsojka/deoplete-flow'
" Plug 'mhartington/deoplete-typescript'

" Plug 'Valloric/YouCompleteMe'
" Plug 'w0rp/ale'
" Plug 'wincent/terminus'
" Plug 'christoomey/vim-tmux-navigator'

Plug 'prabirshrestha/async.vim'

call plug#end()

" }}}
" ============================================================================

" ==============================================================================
" FUNCTIONS {{{
" ==============================================================================

function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction


function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" mostly taken from https://github.com/samuelsimoes/vim-jsx-utils/blob/master/plugin/vim-jsx-utils.vim
function! JSXMultiLine()
  let l:previous_q_reg = @q
  let l:line = getline(".")
  let l:identation_length = len(matchstr(line, "^\[\\t|\\ \]*"))

  if &expandtab
    let l:padding = repeat(" ", (identation_length + &shiftwidth))
  else
    let l:padding = repeat("\t", identation_length + 1)
  endif

  let @q = substitute(line, "\\w\\+=[{|'|\"]", "\\n" . padding . "&", "g")
  let @q = substitute(getreg("q"), ">$", "\\n>", "g")
  let @q = substitute(getreg("q"), "/>$", "\\n/>", "g")

  let @q = substitute(getreg("q"), "\ \\n", "\\n", "g")

  execute "normal! 0d$\"qp"
  execute "normal! =at=at"

  let @q = previous_q_reg
endfunction

command! JSXMultiLine call JSXMultiLine()

" }}}
" ============================================================================

" ==============================================================================
" SETTINGS {{{
" ==============================================================================
filetype on
filetype plugin on
filetype plugin indent on
syntax on

au Filetype javascript setl sw=2 sts=2 et

" let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))




" originally from Wincent https://github.com/wincent/wincent/blob/master/roles/dotfiles/files/.vim/plugin/settings.vim
scriptencoding utf-8

set autoindent                        " maintain indent of current line
set backspace=indent,start,eol        " allow unrestricted backspacing in insert mode


" if exists('$SUDO_USER')
"   set nobackup                        " don't create root-owned files
"   set nowritebackup                   " don't create root-owned files
" else
"   set backupdir=~/local/.vim/tmp/backup
"   set backupdir+=~/.vim/tmp/backup    " keep backup files out of the way
"   set backupdir+=.
" endif

if exists('&belloff')
  set belloff=all                     " never ring the bell for any reason
endif

if has('linebreak')
  set breakindent                     " indent wrapped lines to match start
  if exists('&breakindentopt')
    set breakindentopt=shift:2        " emphasize broken lines by indenting them
  endif
endif

if exists('+colorcolumn')
  " Highlight up to 255 columns (this is the current Vim max) beyond 'textwidth'
  let &l:colorcolumn='+' . join(range(0, 254), ',+')
endif

set cursorline                        " highlight current line

" if exists('$SUDO_USER')
"   set noswapfile                      " don't create root-owned files
" else
"   set directory=~/local/.vim/tmp/swap//
"   set directory+=~/.vim/tmp/swap//    " keep swap files out of the way
"   set directory+=.
" endif

set expandtab                         " always use spaces instead of tabs

if has('folding')
  if has('windows')
    set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif
  set foldmethod=marker               " not as cool as syntax, but faster
  " set foldlevelstart=99               " start unfolded

endif

" don't fold Markdown files by default
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md  setf markdown
autocmd FileType markdown exe "normal zR"

if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j                " remove comment leader when joining comment lines
endif

set formatoptions+=n                  " smart auto-indenting inside numbered lists
" set guifont=Source\ Code\ Pro\ Light:h13
set guioptions-=T                     " don't show toolbar
set hidden                            " allows you to hide buffers with unsaved changes without being prompted
" set highlight+=@:ColorColumn          " ~/@ at end of window, 'showbreak'
" set highlight+=N:DiffText             " make current line number stand out a little
" set highlight+=c:LineNr               " blend vertical separators with line numbers
set laststatus=2                      " always show status line
set lazyredraw                        " don't bother updating screen during macro playback

if has('linebreak')
  set linebreak                       " wrap long lines at characters in 'breakat'
endif

set list                              " show whitespace
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                                      " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
set nojoinspaces                      " don't autoinsert two spaces after '.', '?', '!' for join command
set number                            " show line numbers in gutter

if exists('+relativenumber')
  set relativenumber                  " show relative numbers in gutter
endif

set scrolloff=3                       " start scrolling 3 lines before edge of viewport
set sidescrolloff=3                   " same as scrolloff, but for columns
set shiftround                        " always indent by multiple of shiftwidth
set shiftwidth=2                      " spaces per tab (when shifting)
set shortmess+=A                      " ignore annoying swapfile messages
set shortmess+=I                      " no splash screen
set shortmess+=O                      " file-read message overwrites previous
set shortmess+=T                      " truncate non-file messages in middle
set shortmess+=W                      " don't echo "[w]"/"[written]" when writing
set shortmess+=a                      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o                      " overwrite file-written messages
set shortmess+=t                      " truncate file messages at start

if has('linebreak')
  let &showbreak='↳ '                 " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
endif

if has('showcmd')
  set showcmd                         " extra info at end of command line
endif

set smarttab                          " <tab>/<BS> indent/dedent in leading whitespace
set tabstop=2                         " spaces per tab

if v:progname !=# 'vi'
  set softtabstop=-1                  " use 'shiftwidth' for tab/bs at end of line
endif

if has('syntax')
  set spellcapcheck=                  " don't check for capital letters at start of sentence
endif

if has('windows')
  set splitbelow                      " open horizontal splits below current window
endif

if has('vertsplit')
  set splitright                      " open vertical splits to the right of the current window
endif

"set swapsync=                         " let OS sync swapfiles lazily
set switchbuf=usetab                  " try to reuse windows/tabs when switching buffers

if has('termguicolors')
  set termguicolors                   " use guifg/guibg instead of ctermfg/ctermbg in terminal
endif

set textwidth=120                      " automatically hard wrap at 120 columns
" set cc=+1

" if has('persistent_undo')
"   if exists('$SUDO_USER')
"     set noundofile                    " don't create root-owned files
"   else
"     set undodir=~/local/.vim/tmp/undo
"     set undodir+=~/.vim/tmp/undo      " keep undo files out of the way
"     set undodir+=.
"     set undofile                      " actually use undo files
"   endif
" endif

" set updatecount=80                    " update swapfiles every 80 typed chars

" if has('viminfo')
"   if exists('$SUDO_USER')
"     set viminfo=                      " don't create root-owned files
"   else
"     if isdirectory('~/local/.vim/tmp')
"       set viminfo+=n~/local/.vim/tmp/viminfo
"     else
"       set viminfo+=n~/.vim/tmp/viminfo " override ~/.viminfo default
"     endif
"
"     if !empty(glob('~/.vim/tmp/viminfo'))
"       if !filereadable(expand('~/.vim/tmp/viminfo'))
"         echoerr 'warning: ~/.vim/tmp/viminfo exists but is not readable'
"       endif
"     endif
"   endif
" endif

" if has('mksession')
"   if isdirectory('~/local/.vim/tmp')
"     set viewdir=~/local/.vim/tmp/view
"   else
"     set viewdir=~/.vim/tmp/view       " override ~/.vim/view default
"   endif
"   set viewoptions=cursor,folds        " save/restore just these (with `:{mk,load}view`)
" endif

if has('virtualedit')
  set virtualedit=block               " allow cursor to move where there is no text in visual block mode
endif
set visualbell t_vb=                  " stop annoying beeping for non-error errors
set whichwrap=b,h,l,s,<,>,[,],~       " allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries
set wildcharm=<C-z>                   " substitute for 'wildchar' (<Tab>) in macros
if has('wildignore')
  set wildignore+=*.o,*.rej           " patterns to ignore during file-navigation
endif
if has('wildmenu')
  set wildmenu                        " show options as list when switching buffers etc
endif
set wildmode=longest:full,full        " shell-like autocomplete to unambiguous portion


if has('inccommand')
  set inccommand=split                  " Incremental, live substite in neovim (v0.1.7+)
endif

" copy to system clipboard
set clipboard=unnamed,unnamedplus

set noswapfile     " Don't make backups.
set nowritebackup " Even if you did make a backup, don't keep it around.
set nobackup

"Set color scheme
set background=dark
colorscheme dracula

execute 'highlight Comment ' . pinnacle#italicize('Comment')
execute 'highlight JSXModifier ' . pinnacle#underline('Function')
" hi def link xmlNullTag Keyword
" hi def link xmlNullTag cssURL
hi def link xmlNullTag Comment
hi def link jsDecorator Keyword
hi def link jsDecoratorFunction Type
hi def link jsObjectKey String
hi def link jsFuncCall Function
hi def link jsThis cssURL


" Auto-source vimrc on save
autocmd bufwritepost init.vim source $MYVIMRC

" }}}
" ============================================================================

" ==============================================================================
" PLUGIN_SETTINGS {{{
" ==============================================================================
" - Editor
" - Editing
" - Git
" - Syntaxes
" - ProjectConfig
" - Tools
" ==============================================================================

" ==============================================================================
" Editor
" ==============================================================================
let g:toggle_list_copen_command="bo copen 30"
let g:toggle_list_lopen_command="bo copen 30"
" let g:NERDCustomDelimiters = { 'javascript.jsx': { 'left': '{/*', 'right': '*/}', 'leftAlt': '{/*', 'rightAlt': '*/}' } }

" --- NERDTree ---
" Close vim if the only window left
" open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" like vim-vinegar
let g:NERDTreeMapUpdir = '-'

" move up, but keep current dir expanded
let g:NERDTreeMapUpdirKeepOpen = 'u'

" prevent nerdtree from overriding ctrl-j/k
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'

" Ignore turds left behind by Mercurial.
let g:NERDTreeIgnore=['\.orig']

" The default of 31 is just a little too narrow.
let g:NERDTreeWinSize=40

" Disable display of '?' text and 'Bookmarks' label.
let g:NERDTreeMinimalUI=1

" Let <Leader><Leader> (^#) return from NERDTree window.
let g:NERDTreeCreatePrefix='silent keepalt keepjumps'

" show hidden files by default
let g:NERDTreeShowHidden=1

" Single-click to toggle directory nodes, double-click to open non-directory
" nodes.
let g:NERDTreeMouseMode=2

if has('autocmd')
  augroup WincentNERDTree
    autocmd!
    autocmd User NERDTreeInit call autocmds#attempt_select_last_file()
  augroup END
endif

" TComment
" ensure jsx attribues are commented with js's // syntax, not xml's
let g:tcomment#syntax_substitute = {
      \ '\C^javaScript\ze\(\u\|$\)': {'sub': 'javascript'},
      \ '\C^js\ze\(\u\|$\)': {'sub': 'javascript'},
      \ '\C^xmlTag\ze\(\u\|$\)': {'sub': 'javascript'},
      \ '\C^xmlNullTag\ze\(\u\|$\)': {'sub': 'javascript'},
      \ '\C^xmlModifierTag\ze\(\u\|$\)': {'sub': 'javascript'}
      \ }

" override default jsx_block to remove whitespace
call tcomment#DefineType('jsx_block',       '{/*%s */}')

" ==============================================================================
" Editing
" ==============================================================================
" TODO figure out why these autocmd settings break omnicomplete
" autocmd FileType javascript let g:pairtools_javascript_tagwrenchhook = 'tagwrench#BuiltinHTML5Hook'
" autocmd FileType javascript let g:pairtools_javascript_twexpander = 1
" autocmd FileType javascript let g:pairtools_javascript_tweraser   = 1
" autocmd FileType javascript let g:pairtools_javascript_tagwrench = 1
" autocmd FileType javascript let g:pairtools_javascript_apostrophe = 0
" autocmd FileType javascript let g:pairtools_javascript_jigsaw    = 1
" autocmd FileType javascript.jsx setlocal commentstring={/*\ %s\ */}
" autocmd FileType javascript set formatprg=prettier\ --stdin\ --semi\ false\ --single-quote\ --trailing-comma\ all\ --print-width\ 120
" autocmd BufWritePre *.js
"       \ Neoformat |
"       \ Fixmyjs

" autocmd FileType javascript set formatprg=prettier\ --stdin\ --semi\ false\ --single-quote\ --trailing-comma\ all\
autocmd FileType javascript set formatprg=prettier-eslint\ --stdin
" autocmd BufWritePre *.js Neoformat

" Use formatprg when available
let g:neoformat_try_formatprg = 1

" ==============================================================================
" Git
" ==============================================================================
let g:Gitv_OpenHorizontal = 1
let g:Gitv_WipeAllOnClose = 1
let g:Gitv_DoNotMapCtrlKey = 1


" ==============================================================================
" Syntaxes
" ==============================================================================
au BufRead,BufNewFile *.json set filetype=json

" Set .babelrc file to json format on open and new
autocmd BufNewFile,BufRead .babelrc,.eslintrc set filetype=json5

let g:jsx_ext_required = 0
au BufRead,BufNewFile *.flow set filetype=javascript
let g:javascript_plugin_flow = 1

" let g:closetag_filenames = "*.html,*.js"

" use linting tool installed locally in node_modules folder
let g:fixmyjs_use_local = 1

" ==============================================================================
" ProjectConfig
" ==============================================================================
let g:localvimrc_ask = 0

" https://github.com/wincent/wincent/blob/57a3bf2001/roles/dotfiles/files/.vim/after/plugin/projectionist.vim
let g:projectionist_heuristics = {
      \   '*': {
      \     '*.c': {
      \       'alternate': '{}.h',
      \       'type': 'source'
      \     },
      \     '*.h': {
      \       'alternate': '{}.c',
      \       'type': 'header'
      \     },
      \
      \     '*.js': {
      \       'alternate': [
      \         '{dirname}/{basename}.test.js',
      \         '{dirname}/__tests__/{basename}-test.js',
      \         '{dirname}/__tests__/{basename}-mocha.js'
      \       ],
      \       'type': 'source'
      \     },
      \     '*.test.js': {
      \       'alternate': '{basename}.js',
      \       'type': 'test',
      \     },
      \     '**/__tests__/*-mocha.js': {
      \       'alternate': '{dirname}/{basename}.js',
      \       'type': 'test'
      \     },
      \     '**/__tests__/*-test.js': {
      \       'alternate': '{dirname}/{basename}.js',
      \       'type': 'test'
      \     },
      \     '*.re': {
      \       'alternate': [
      \         '{}_test.re',
      \         '{}.rei'
      \       ],
      \       'type': 'source'
      \     },
      \     '*.rei': {
      \       'alternate': [
      \         '{}.re',
      \         '{}_test.re',
      \       ],
      \       'type': 'header'
      \     },
      \     '*_test.re': {
      \       'alternate': [
      \         '{}.rei',
      \         '{}.re',
      \       ],
      \       'type': 'test'
      \     }
      \   }
      \ }


" ==============================================================================
" Tools
" ==============================================================================
"
" Omnicomplete on CTRL space
" Since iterm will inevitably send a <Nul> on CTRL-Space (because it's not a
" GUI app), we need to make sure that those <Nul> will be mapped to <C-Space>
" instead
inoremap <C-Space> <C-x><C-o>
imap <buffer> <Nul> <C-Space>
smap <buffer> <Nul> <C-Space>

" " Enable auto-completion by default
" let g:deoplete#enable_at_startup = 1
"
" if !exists('g:deoplete#omni#input_patterns')
"   let g:deoplete#omni#input_patterns = {}
" endif
"
" " let g:deoplete#disable_auto_complete = 1
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"
" " deoplete tab-complete
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"
" """""""""""""""""""""""""
" " 	NEOMAKE CONFIG
" """""""""""""""""""""""""
let g:neomake_logfile=$HOME.'/.log/neomake.log'
"
" let g:neomake_open_list = 2
" let g:neomake_place_signs = 1
"
" let g:neomake_javascript_enabled_makers = []
"
" if findfile('.eslintrc', '.;') !=# ''
"   let g:eslint_path = StrTrim(system('PATH=$(npm bin):$PATH && which eslint'))
"   if g:eslint_path != 'eslint not found'
"     let g:neomake_javascript_eslint_exe = g:eslint_path
"     let g:neomake_javascript_enabled_makers = g:neomake_javascript_enabled_makers + [ 'eslint']
"   endif
" endif
"
"   let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))
"
"   if g:flow_path != 'flow not found'
"     let g:neomake_javascript_flow_maker = {
"           \ 'exe': 'sh',
"           \ 'args': ['-c', g:flow_path.' --json 2>/dev/null | ~/Projects/flow-vim-quickfix/bin/flow-vim-quickfix'],
"           \ 'errorformat': '%E%f:%l:%c\,%n: %m',
"           \ 'cwd': '%:p:h' 
"           \ }
"     let g:neomake_javascript_enabled_makers = g:neomake_javascript_enabled_makers + [ 'flow']
"     let g:deoplete#sources#flow#flow_bin = g:flow_path
"     
"     let g:flow#flowpath = g:flow_path 
"   endif
"
" if !empty(g:neomake_javascript_enabled_makers)
"   autocmd! BufWritePost * Neomake
"   "autocmd! BufWritePost * Neomake
"   autocmd! QuitPre * let g:neomake_verbose = 0
" endif
"
" " vim-flow (for CTRL-Space suggestion only)
" " For flow check we use neomake 
" let g:flow#enable = 0
" let g:flow#omnifunc = 1
"

" Ultisnip 
" " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsSnippetDirectories=['myUltiSnippets']
let g:UltiSnipsExpandTrigger='<tab>'
" let g:UltiSnipsJumpForwardTrigger='<c-b>'
" let g:UltiSnipsJumpBackwardTrigger='<c-z>'
let g:UltiSnipsEditSplit='vertical' " If you want :UltiSnipsEdit to split your window.


if has('nvim')
  " == Shougo/deoplete.nvim ==
  let g:deoplete#enable_at_startup = 1
  let g:SuperTabDefaultCompletionType = "<c-n>"
  " == carlitux/deoplete-ternjs ==
  let g:tern_request_timeout = 1
  let g:tern_show_signature_in_pum = 0
  set completeopt-=preview

  " " let g:deoplete#disable_auto_complete = 1
  " autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  "
  " " deoplete tab-complete
  " inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
  "
  " if !exists('g:deoplete#omni#input_patterns')
  "   let g:deoplete#omni#input_patterns = {}
  " endi

  " == neomake/neomake ==
  " let g:neomake_open_list = 2
  " let g:neomake_place_signs = 1

  let g:neomake_javascript_enabled_makers = []

  " if findfile('.eslintrc', '.;') !=# ''
    let g:eslint_path = StrTrim(system('PATH=$(npm bin):$PATH && which eslint'))
    if g:eslint_path != 'eslint not found'
      let g:neomake_javascript_eslint_exe = g:eslint_path
      let g:neomake_javascript_enabled_makers = g:neomake_javascript_enabled_makers + [ 'eslint']
      "UNCOMMENT BELOW to --fix on neomake. Also uncomment au NeomakeFinished lower down
      " let g:neomake_javascript_eslint_maker = {
      "   \ 'args': ['-f', 'compact', '--fix'],
      "   \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
      "   \ '%W%f: line %l\, col %c\, Warning - %m'
      "   \ }
    endif
  " endif


  let g:neomake_warning_sign = {
        \ 'text': 'W',
        \ 'texthl': 'Type',
        \ }
  let g:neomake_error_sign = {
        \ 'text': 'E',
        \ 'texthl': 'ErrorMsg',
        \ }
"   let g:neomake_error_sign = {
"     \ 'text': '->',
"     \ 'texthl': 'Error',
"     \ }
" let g:neomake_warning_sign = {
"     \ 'text': '->',
"     \ 'texthl': 'Type',
"     \ }

  " if findfile('.flowconfig', '.;') !=# ''
    let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))

    if g:flow_path != 'flow not found'
      let g:deoplete#sources#flow#flow_bin = g:flow_path
      let g:neomake_javascript_flow_maker = {
        \ 'exe': 'sh',
        \ 'args': ['-c', g:flow_path.' --from=vim', '--show-all-errors'],
        \ 'errorformat': '%EFile "%f"\, line %l\, characters %c-%m,%C%m,%Z%m',
        \ }

      "     \ 'exe': 'sh',
      "     \ 'args': ['-c', g:flow_path.' --json 2> /dev/null | flow-vim-quickfix'],
      "     \ 'errorformat': '%E%f:%l:%c\,%n: %m',
      "     \ 'cwd': '%:p:h'
      "     \ }
      let g:neomake_javascript_enabled_makers = g:neomake_javascript_enabled_makers + [ 'flow']
      let g:neomake_jsx_enabled_makers = ['eslint', 'flow']

      " let g:neomake_javascript_flow_exe = g:flow_path
      " let g:neomake_jsx_flow_exe = g:flow_path

      let g:flow#flowpath = g:flow_path

      " vim-flow (for CTRL-Space suggestion only)
      " For flow check we use neomake
      let g:flow#enable = 0
      let g:flow#omnifunc = 1

    endif
  " endif

  if !empty(g:neomake_javascript_enabled_makers)

    " function! OnNeomakeFinished()
    "   silent checktime
    " endfunction
    "
    " augroup my_neomake
    "   au!
    "   autocmd User NeomakeFinished call OnNeomakeFinished()
    " augroup END

    au CursorHold,CursorHoldI * silent! checktime

    autocmd! BufEnter * Neomake
    autocmd! BufwritePost * Neomake
    autocmd! QuitPre * let g:neomake_verbose = 0
  endif
else
  " let g:ale_sign_error = 'E'
  " let g:ale_sign_warning = 'W'

  " == scrooloose/syntastic ==
  " let g:syntastic_enable_signs=1
  " let g:syntastic_always_populate_loc_list=1
  " let g:syntastic_loc_list_height=15
  " let g:syntastic_json_checkers=['jsonlint']
  " let g:syntastic_javascript_checkers=['eslint']
  " " let g:syntastic_javascript_checkers = ['flow', 'eslint']
  " let g:syntastic_javascript_eslint_exec = 'eslint_d'
endif

" }}}
" ============================================================================

" ==============================================================================
" KEYBINDINGS {{{
" ==============================================================================
" - Normal
" - Visual
" - Insert
" - CommandLine
" - Leader
" ==============================================================================
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" == junegunn/fzf ==
nnoremap <C-T> :FZF<CR>
inoremap <C-T> <ESC>:FZF<CR>i

set wildcharm=<C-z>

" ==============================================================================
" Normal
" ==============================================================================
" Use jkl; for navigation
noremap ; l
noremap l k
noremap k j
noremap j h
" Store relative line number jumps in the jumplist if they exceed a threshold.
" nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
" nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'


"totally annoying default mapping for cap k
nmap K <nop>

" Repeat last macro if in a normal buffer.
nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

" map q to CamelCaseMotion, like atom's vim-mode
map <silent> q <Plug>CamelCaseMotion_w
map <silent> Q <Plug>CamelCaseMotion_b


" map iq and iQ motions
omap <silent> iq <Plug>CamelCaseMotion_iw
xmap <silent> iq <Plug>CamelCaseMotion_iw
omap <silent> iQ <Plug>CamelCaseMotion_ib
xmap <silent> iQ <Plug>CamelCaseMotion_ib

" clear search highlights on esc
nnoremap <silent> <esc>  :nohlsearch<return><esc>

" Auto indent pasted text
nnoremap p p=`]<C-o>

" Window and split navigation

nnoremap <C-h> <C-w>h
let g:BASH_Ctrl_j = 'off'
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nmap <c-Tab> :tabnext<Cr>
nmap <c-S-Tab> :tabprev<Cr>
nmap <D->> :vertical resize +10<CR>
nmap <D-<> :vertical resize -10<CR>

" When in diff mode - Command-Shift-J/K move to next change in diff.
nmap <D-K> [c
nmap <D-J> ]c

" Cursor keys to navigate errors
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

" Like vim-vinegar.
nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : fnameescape(expand('%:p:h'))<CR><CR>

" Move up a directory using "-" like vim-vinegar (usually "u" does this).
" nmap <buffer> <expr> - g:NERDTreeMapUpdir


" nnoremap <D-b> :CtrlPBuffer<CR>

"Tcomment
" nmap <D-/> gcc


" Make S always delete until the point where you'd want to start typing -
" with some indent plugins, or settings the desired behavior is lost - this
" restores it. (Doesn't always work - looking for better solution)
nmap S ddO

" Quick global shortcuts for toggling the location list or quickfix list
" TODO: Use overlay for this as well.
nmap <script> <silent> <D-r> :call ToggleLocationList()<CR>
nmap <script> <silent> <D-R> :call ToggleQuickfixList()<CR>


" Rename complete word in file
nnoremap <expr> <c-s> ':%s/\<'.expand('<cword>').'\>/'.expand('<cword>').'/g<Left><Left>'

" This allows you to stand anywhere on the token to replace, press "c>", print new token and then hit "." happily after that to replace next occurrence or "n" to skip unneeded
nnoremap c> *Ncgn

" open file in vertical split
nnoremap gvf :vertical wincmd f<CR>



" custom function to format current buffer
" nmap <D-M> :call Preserve("normal gg=G")<CR>


" bind \ (backward slash) to grep shortcut
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" bind K to grep word under cursor
nmap <silent> K :Ag! "<cword>" <CR>

" EasyMotion
" nmap s <Plug>(easymotion-s)
" nmap S <Plug>(easymotion-bd-w)

" MacVimSmartGUITabs
" map <D-Cr> :SmartGUITabsToggleFullScreen<CR>
" nmap <D-Cr> <Esc>:SmartGUITabsToggleFullScreen<CR>

"SmoothScroll
noremap <silent> <c-u> :call smooth_scroll#up(40, 20, 6)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(40, 20, 6)<CR>

" Uncomment a line; mirrors gcc (which comments/toggles a line).
nmap guu <Plug>TComment_Uncommentc


" re-open the window you just quit (like browser tabs)
map <D-T> <Esc>:Undoquit<CR>


" Yank overrides default 'p'
" map p <Plug>(miniyank-autoput)
" map P <Plug>(miniyank-autoPut)

"replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
"replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T



" ==============================================================================
" Visual
" ==============================================================================
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

"Tcomment
vmap gC :TCommentBlock<cr>
" vmap <D-s-/> <c-_>b

" EasyMotion
" vmap s <Plug>(easymotion-s)
" vmap S <Plug>(easymotion-bd-w)


" EasyAlign
vmap <Enter> <Plug>(EasyAlign)


" ExpandRegion
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" smooth_scroll is broken in visual mode currently - unmap
vnoremap <silent> <c-u> <c-u>
vnoremap <silent> <c-d> <c-d>


" ==============================================================================
" Insert
" ==============================================================================
imap <C-j> <esc>Ji
imap <C-o> <Esc>O
imap <S-Enter> <End><Cr>

"Emacs keybindings while inserting.
imap <C-k> <space><Esc>Da
imap <C-a> <Esc>I
map! <c-e> <End>
map! <c-f> <Right>
map! <c-b> <Left>
map! <c-d> <Delete>
"noremap! <M-b> <S-Left>
"noremap! <M-f> <S-Right>
" noremap! <c-n> <Down>
" noremap! <c-p> <Up>
inoremap <c-g> <c-p>

" Window and split navigation
imap <c-Tab> <Esc>:tabnext<Cr>
imap <c-S-Tab> <Esc>:tabprev<Cr>
imap <D->> <Esc>:vertical resize +10<CR>
imap <D->> <Esc>:vertical resize +10<CR>

" Since it makes sense to make c-d match the mac ox/emacs style forward
" delete, c-d can't be (shift left in insert mode). Given that, we can
" make a better mac os x combo for indenting and unindenting in insert
" mode. That frees up c-t
inoremap <D-]> <c-t>
inoremap <D-[> <c-d>

" MacVimSmartGUITabs
imap <D-Cr> <Esc>:SmartGUITabsToggleFullScreen<CR>





" ==============================================================================
" CommandLine
" ==============================================================================
" Need to map these once more for inc-search to work
cmap <c-a> <Home>
cmap <c-e> <End>
cmap <c-f> <Right>
cmap <c-b> <Left>
cmap <c-d> <Delete>



" `<Tab>`/`<S-Tab>` to move between matches without leaving incremental search.
" Note dependency on `'wildcharm'` being set to `<C-z>` in order for this to
" work.
cnoremap <expr> <Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>/<C-r>/' : '<C-z>'
cnoremap <expr> <S-Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>?<C-r>/' : '<S-Tab>'






" ==============================================================================
" Leader
" ==============================================================================
let mapleader = "\<Space>"
let maplocalleader = ","

noremap <leader>a :Ag! -Q <C-r>=expand('<cword>')<CR><CR>
nnoremap <Leader>o :CtrlP<CR>

nmap <Leader>a <Plug>(EasyAlign)
" nnoremap <Leader>/ :LustyBufferGrep<CR>

" open file under cursor
" nmap <Leader>f :CtrlP<CR><C-\>w
nmap <Leader>f :FZF<CR>
nmap <Leader>F :FZF<CR><C-\>w
nmap <Leader>b :Buffers<CR>

nmap <Leader>/ gcc

" <Leader>p -- Show the path of the current file (mnemonic: path; useful when
" you have a lot of splits and the status line gets truncated).
" nnoremap <Leader>p :echo expand('%')<CR>

" <Leader>pp -- Like <Leader>p, but additionally yanks the filename and sends it
" off to Clipper.
" nnoremap <Leader>pp :let @0=expand('%') <Bar> :Clip<CR> :echo expand('%')<CR>

" <LocalLeader>c -- Fix (most) syntax highlighting problems in current buffer
" (mnemonic: coloring).
nnoremap <silent> <Leader>c :syntax sync fromstart<CR>

nmap <Leader>s <Plug>(Scalpel)

nmap <Leader>dt va>Jdst

" Yank -- use cycle to go back in history
" map <leader>n <Plug>(miniyank-cycle)

" <LocalLeader>e -- Edit file, starting in same directory as current file.
" nnoremap <Leader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

" Git
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gpu :Gpush<CR>
nnoremap <Leader>gpl :Gpull<CR>
nnoremap <Leader>gb :Git branch<Space>
nnoremap <Leader>go :Git checkout<Space>

"map macro to Leader-m so q can be used for CamelCaseMotion
nnoremap <Leader>m q
vnoremap <Leader>m q

" custom function to format current buffer
nmap <Leader>p :call Preserve("normal gg=G")<CR>

" Format
nmap <Leader>n :Neoformat<CR>

" }}}
" ============================================================================
