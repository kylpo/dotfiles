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
Plug 'wesQ3/vim-windowswap'           " <leader>ww a window, nav to desired swap window, <leader>ww again
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
Plug 'chriskempson/base16-vim'
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
Plug 'ruanyl/vim-fixmyjs'
" Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'tpope/vim-markdown'
Plug 'elzr/vim-json'
Plug 'GutenYe/json5.vim'
" Plug 'othree/xml.vim'

" Markdown preview for OS X via :Xmark
Plug 'junegunn/vim-xmark', { 'do': 'make' }

" Plug 'chrisbra/Colorizer'


" Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" NOTE: be sure to :TsuOpen to see completions
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
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe'
" Plug 'Shougo/neocomplete.vim'
Plug 'w0rp/ale'
" Plug 'wincent/terminus'
" Plug 'christoomey/vim-tmux-navigator'

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

" Set .babelrc file to json format on open and new
autocmd BufNewFile,BufRead .babelrc,.eslintrc set filetype=json5

" set gq command to use prettierjs
" autocmd FileType javascript setlocal formatprg=prettier\ --stdin
" auto-format on save
" autocmd BufWritePre *.js :normal gggqG

" autocmd FileType javascript set formatprg=prettier\ --stdin

au Filetype javascript setl sw=2 sts=2 et

" auto-format on save
" augroup autoindent
"   au!
"   autocmd BufWritePre *.js :normal migg=G`i
" augroup End
au BufNewFile,BufRead *.ejs set filetype=html
au Filetype javascript setl sw=2 sts=2 et

" let g:tsuquyomi_debug = 1
" let g:tsuquyomi_tsserver_debug = 1
" let g:tsuquyomi_completion_detail = 1
" autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
" let g:tsuquyomi_use_local_typescript = 0


" set timeoutlen=1000 ttimeoutlen=0


" originally from Wincent https://github.com/wincent/wincent/blob/master/roles/dotfiles/files/.vim/plugin/settings.vim
scriptencoding utf-8

set autoindent                        " maintain indent of current line
set backspace=indent,start,eol        " allow unrestricted backspacing in insert mode

set nobackup
set nowritebackup
set noswapfile

set clipboard=unnamed

" if exists('$SUDO_USER')
"   set nobackup                        " don't create root-owned files
"   set nowritebackup                   " don't create root-owned files
"   set noswapfile                      " don't create root-owned files
" else
"   set backupdir=~/.vim/tmp/backup//
"   set directory=~/.vim/tmp/swap//
" endif

if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                    " don't create root-owned files
  else
    set undodir=~/.vim/tmp/undo
    set undofile                      " actually use undo files
  endif
endif


if exists('&belloff')
  set belloff=all                     " never ring the bell for any reason
endif

if has('linebreak')
  set breakindent                     " indent wrapped lines to match start
  if exists('&breakindentopt')
    set breakindentopt=shift:2        " emphasize broken lines by indenting them
  endif
endif

" if exists('+colorcolumn')
"   " Highlight up to 255 columns (this is the current Vim max) beyond 'textwidth'
"   let &l:colorcolumn='+' . join(range(0, 254), ',+')
" endif

set cursorline                        " highlight current line

set expandtab                         " always use spaces instead of tabs

if has('folding')
  if has('windows')
    set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif
  set foldmethod=marker               " not as cool as syntax, but faster
  " set foldlevelstart=99               " start unfolded
  "
endif

" unfold markdown files by default
"autocmd Syntax md,html normal zR
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md  setf markdown

autocmd FileType markdown exe "normal zR"


if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j                " remove comment leader when joining comment lines
endif

set formatoptions+=n                  " smart auto-indenting inside numbered lists
" set guifont=Source\ Code\ Pro\ Light:h13
set guioptions-=T                     " don't show toolbar
set hidden                            " allows you to hide buffers with unsaved changes without being prompted
set highlight+=@:ColorColumn          " ~/@ at end of window, 'showbreak'
set highlight+=N:DiffText             " make current line number stand out a little
set highlight+=c:LineNr               " blend vertical separators with line numbers
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
" set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
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

if has('termguicolors')
  " Don't need this in xterm-256color, but do need it inside tmux.
  " (See `:h xterm-true-color`.)
  if &term =~# 'tmux-256color'
    let &t_8f="\e[38;2;%ld;%ld;%ldm"
    let &t_8b="\e[48;2;%ld;%ld;%ldm"
  endif
endif


"Set color scheme
set background=dark
" colorscheme grb256
" colorscheme base16-tomorrow-night
" colorscheme spacegray
colorscheme dracula
" set t_Co=256

execute 'highlight Comment ' . pinnacle#italicize('Comment')
execute 'highlight JSXModifier ' . pinnacle#underline('Function')
hi def link jsDecorator Keyword
hi def link jsDecoratorFunction Type
hi def link jsObjectKey String
hi def link jsFuncCall Function
hi def link jsThis cssURL


" from wincent: https://www.youtube.com/watch?v=QcOxU1sOOuw
" function! s:CheckColorScheme()
"   if !has('termguicolors')
"     let g:base16colorspace=256
"   endif
"
"   let s:config_file = expand('~/.vim/.base16')
"
"   if filereadable(s:config_file)
"     let s:config = readfile(s:config_file, '', 2)
"
"     if s:config[1] =~# '^dark\|light$'
"       execute 'set background=' . s:config[1]
"     else
"       echoerr 'Bad background ' . s:config[1] . ' in ' . s:config_file
"     endif
"
"     if filereadable(expand('~/.vim/plugged/base16-vim/colors/base16-' . s:config[0] . '.vim'))
"       execute 'color base16-' . s:config[0]
"     else
"       echoerr 'Bad scheme ' . s:config[0] . ' in ' . s:config_file
"     endif
"   else " default
"     set background=dark
"     color base16-tomorrow-night
"   endif
"
"   execute 'highlight Comment ' . pinnacle#italicize('Comment')
"   execute 'highlight JSXModifier ' . pinnacle#decorate('undercurl', 'Type')
"   " execute 'highlight link EndOfBuffer ColorColumn'
"
"   " Allow for overrides:
"   " - `statusline.vim` will re-set User1, User2 etc.
"   " - `after/plugin/loupe.vim` will override Search.
"   doautocmd ColorScheme
" endfunction
"
" if v:progname !=# 'vi'
"   if has('autocmd')
"     augroup WincentAutocolor
"       autocmd!
"       autocmd FocusGained * call s:CheckColorScheme()
"     augroup END
"   endif
"
"   call s:CheckColorScheme()
" endif

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

" --- Airline ---
" if has("gui_macvim") || has("gui_vimr")
"   autocmd VimEnter * set guioptions+=e
" endif
" let g:airline_powerline_fonts = 1
" 
" let g:airline#extensions#branch#enabled = 0
" "let g:airline#extensions#hunks#enabled = 0
" let g:airline#extensions#hunks#non_zero_only = 1
" let g:airline_section_y = ''
" 
" set laststatus=2
" " Disable truncation
" let g:airline#extensions#default#section_truncate_width = {}

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


" ==============================================================================
" Tools
" ==============================================================================
" disable changing cursors since there is too much of a delay leaving insert-mode
" let g:TerminusCursorShape=1
let g:TerminusBracketedPaste=0

" " vim-flow (for CTRL-Space suggestion only)
" " For flow check we use neomake 
let g:flow#enable = 0
let g:flow#omnifunc = 1
"

" " NeoComplete
" " --------------------
" " Disable AutoComplPop.
" let g:acp_enableAtStartup = 0
" " Use neocomplete.
" let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
" let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" " Plugin key-mappings.
" inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()
"
" " Recommended key-mappings.
" " <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
"   " For no inserting <CR> key.
"   "return pumvisible() ? "\<C-y>" : "\<CR>"
" endfunction
" " <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" " <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"
" Enable heavy omni completion.
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns = {}
" endif

"
" if !exists('g:ycm_semantic_triggers')
"   let g:ycm_semantic_triggers = {}
" endif
" let g:ycm_semantic_triggers.javascript = ['re!(?=[a-zA-Z_]{2})']

" disable semantic completion for javascript
let g:ycm_filetype_specific_completion_to_disable = {
      \ 'javascript': 1
      \}

" default <C-Space> is not already bound in tmux
" let g:ycm_key_invoke_completion = '<C-/>'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
"
" " better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsSnippetDirectories=['myUltiSnippets']
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsEditSplit='vertical' " If you want :UltiSnipsEdit to split your window.

let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'

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

" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'

" Like vim-vinegar.
nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : fnameescape(expand('%:p:h'))<CR><CR>

" Move up a directory using "-" like vim-vinegar (usually "u" does this).
" nmap <buffer> <expr> - g:NERDTreeMapUpdir


" nnoremap <D-b> :CtrlPBuffer<CR>
"
" "Tcomment
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



" bind \ (backward slash) to grep shortcut
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" bind K to grep word under cursor
nmap <silent> K :Ag! <cword> <CR>

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

" nmap <Leader>dt vit<<ESC>kvat<ESC>dd`<da>dd
" nmap <Leader>dt vit<<ESC><C-o>kvat<ESC>dd`<da>dd
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


" }}}
" ============================================================================
