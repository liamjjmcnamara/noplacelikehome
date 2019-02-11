set encoding=utf-8
scriptencoding utf-8
set shell=/bin/sh

" Environment
silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction

" Arrow Key Fix { https://github.com/spf13/spf13-vim/issues/780
if &term[:4] ==? 'xterm' || &term[:5] ==? 'screen' || &term[:3] ==? 'rxvt'
    inoremap <silent> <C-[>OC <RIGHT>
endif

"if filereadable(expand('~/.vimrc.bundles'))
    "source ~/.vimrc.bundles
"endif

filetype plugin indent on   " Automatically detect file types.
syntax on                   " Syntax highlighting
scriptencoding utf-8

if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif


" Most prefer to automatically switch to the current file directory when
" a new buffer is opened; to prevent this behavior, add the following to
" your .vimrc.before.local file:
"   let g:spf13_no_autochdir = 1
if !exists('g:spf13_no_autochdir')
    "autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    " Always switch to the current file directory
endif

"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
"set matchpairs+=<:>             " Match, to be used with %
set background=dark         " Assume a dark background
set guifont=Roboto\ Mono\ Light\ Nerd\ Font\ Complete:h14
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
let &titlestring = expand('%:p')
set autoindent                  " Indent at the same level of the previous line
set backspace=indent,eol,start  " Backspace for dummies
set backup                      " Backups are nice ...
set clipboard=unnamed
set colorcolumn=81,101
set cursorline                  " Highlight current line
set expandtab                   " Tabs are spaces, not tabs
set foldenable                  " Auto fold code
set foldlevel=99
set foldmethod=indent
set hidden                      " Allow buffer switching without saving
set history=1000                " Store a ton of history (default is 20)
set hlsearch                    " Highlight search terms
set ignorecase                  " Case insensitive search
set incsearch                   " Find as you type search
set iskeyword-=#                " '#' is an end of word designator
set iskeyword-=-                " '-' is an end of word designator
set iskeyword-=.                " '.' is an end of word designator
set laststatus=2
set linespace=0                 " No extra spaces between rows
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set fillchars+=vert:\ 
set nobackup
set nocursorline
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set norelativenumber
set nowrap                      " Do not wrap long lines
set number                      " Line numbers on
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set ruler                       " Show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=16
set scrolloff=3                 " Minimum lines to keep above and below cursor
set shiftwidth=2
set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
set showcmd                     " Show partial commands in status line and
set showmatch                   " Show matching brackets/parenthesis
set showmode                    " Display the current mode
set smartcase                   " Case sensitive when uc present
set softtabstop=4               " Let backspace delete indent
set spellsuggest=best,10
set splitbelow                  " Puts new split windows to the bottom of the current
set splitright                  " Puts new vsplit windows to the right of the current
set statusline =%<%f\                     " Filename
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
set statusline+=%w%h%m%r                 " Options
set statusline+=\ [%{&ff}/%Y]            " Filetype
set statusline+=\ [%{getcwd()}]          " Current dir
set synmaxcol=180
set tabpagemax=15               " Only show 15 tabs
set tabstop=4                   " An indentation every four columns
set tags=./.tags;/
set timeoutlen=300
set title
set ttimeoutlen=10
set ttyfast
set undofile                " So is persistent undo ...
set undolevels=1000         " Maximum number of changes that can be undone
set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
set updatetime=100
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore         " Allow for cursor beyond last character
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set winminheight=0              " Windows can be 0 line high
set wrap linebreak

let g:mapleader = ','
let g:maplocalleader = '_'

" Easier moving in tabs and windows
" The lines conflict with the default digraph mapping of <C-K>
" If you prefer that functionality, add the following to your
" .vimrc.before.local file:
"   let g:spf13_no_easyWindows = 1
if !exists('g:spf13_no_easyWindows')
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_
endif

" End/Start of line motion keys act relative to row/wrap width in the
" presence of `:set wrap`, and relative to line for `:set nowrap`.
" Default vim behaviour is to act relative to text line in both cases
" If you prefer the default behaviour, add the following to your
" .vimrc.before.local file:
"   let g:spf13_no_wrapRelMotion = 1
" Same for 0, home, end, etc
function! WrapRelativeMotion(key, ...)
    let l:vis_sel=''
    if a:0
        let l:vis_sel='gv'
    endif
    if &wrap
        execute 'normal!' l:vis_sel . 'g' . a:key
    else
        execute 'normal!' l:vis_sel . a:key
    endif
endfunction

" Map g* keys in Normal, Operator-pending, and Visual+select
noremap $ :call WrapRelativeMotion("$")<CR>
noremap <End> :call WrapRelativeMotion("$")<CR>
noremap 0 :call WrapRelativeMotion("0")<CR>
noremap <Home> :call WrapRelativeMotion("0")<CR>
noremap ^ :call WrapRelativeMotion("^")<CR>
" Overwrite the operator pending $/<End> mappings from above
" to force inclusive motion with :execute normal!
onoremap $ v:call WrapRelativeMotion("$")<CR>
onoremap <End> v:call WrapRelativeMotion("$")<CR>
" Overwrite the Visual+select mode mappings from above
" to ensure the correct vis_sel flag is passed to function
vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>

" Shortcuts
" Change Working Directory to that of the current file
"cmap cwd lcd %:p:h
"cmap cd. lcd %:p:h

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>
cmap w!! w !sudo tee % >/dev/null

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk
nnoremap ; :
cmap w!! w !sudo tee % > /dev/null
"nnoremap <space> za
vnoremap < <gv
vnoremap > >gv
nnoremap K kJ
nnoremap Q @q
nnoremap # *
nnoremap n nzz
nnoremap N Nzz
nnoremap T y$
nnoremap Y y$
nnoremap d "_d
vnoremap d "_d
vnoremap // y/<C-R>"<CR>
" buffer switching
map <Leader>n :bn<cr>
map <Leader>p :bp<cr>
map <Leader>d :bd<cr>
map <Leader>u :UndotreeToggle<cr>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
" tag jumping
nnoremap <Leader>k <C-]>
nnoremap <Leader>j <C-T>
"unmap <Leader>q
" vimprompt
map <Leader>q :VimuxPromptCommand<CR>
map <Leader>w :call VimuxRunCommand("fc -e : -1")<CR>
map <Leader>W :VimuxRunLastCommand<CR>
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>f :NERDTreeToggle<CR>
" Generate tags and cscope
map <Leader>T :!tagscope<CR>
map <Leader>z :terminal ++close zsh<CR>

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <Leader>ew :e %%
map <Leader>es :sp %%
map <Leader>ev :vsp %%
map <Leader>et :tabe %%
" Adjust viewports to the same size
map <Leader>= <C-w>=

" Easier formatting
nnoremap <silent> <Leader>q gwip
nnoremap <Left>  :echo "No left for you!"<CR>
nnoremap <Right> :echo "No right for you!"<CR>
nnoremap <Up>    :echo "No up for you!"<CR>
nnoremap <Down>  :echo "No down for you!"<CR>
inoremap <C-l> <Right>

nnoremap <silent> <c-\><Left>   :TmuxNavigateLeft<cr>
nnoremap <silent> <c-\><Down>   :TmuxNavigateDown<cr>
nnoremap <silent> <c-\><Up>     :TmuxNavigateUp<cr>
nnoremap <silent> <c-\><Right>  :TmuxNavigateRight<cr>
nnoremap <silent> <c-\>h        :TmuxNavigateLeft<cr>
nnoremap <silent> <c-\>j        :TmuxNavigateDown<cr>
nnoremap <silent> <c-\>k        :TmuxNavigateUp<cr>
nnoremap <silent> <c-\>l        :TmuxNavigateRight<cr>
nnoremap <silent> <c-\><bslash> :TmuxNavigatePrevious<cr>
nnoremap <silent> <c-\><c-h>    :TmuxNavigateLeft<cr>

nnoremap z= i<C-X><C-S>
map <CR> o<Esc>

inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"

nnoremap <C-F> :FZF<cr>
nnoremap <Leader>y :FZF<cr>
set runtimepath+=/usr/local/opt/fzf

" NerdTree
if isdirectory(expand('~/.vim/plugged/nerdtree'))
    map <C-e> <plug>NERDTreeTabsToggle<CR>
    map <leader>e :NERDTreeFind<CR>
    nmap <leader>nt :NERDTreeFind<CR>
    let g:NERDShutUp=1
    let g:NERDTreeChDirMode=0
    let g:NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
    let g:NERDTreeKeepTreeInNewTab=1
    let g:NERDTreeMouseMode=2
    let g:NERDTreeQuitOnOpen=1
    let g:NERDTreeShowBookmarks=1
    let g:NERDTreeShowHidden=1
    let g:nerdtree_tabs_open_on_gui_startup=0
endif

" Stupid shift key fixes
if !exists('g:spf13_no_keyfixes')
    if has('user_commands')
        command! -bang -nargs=* -complete=file E e<bang> <args>
        command! -bang -nargs=* -complete=file W w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>
    endif
    cmap Tabe tabe
endif

" UndoTree 
if isdirectory(expand('~/.vim/plugged/undotree/'))
    nnoremap <Leader>u :UndotreeToggle<CR>
    " If undotree is opened, it is likely one wants to interact with it.
    let g:undotree_SetFocusWhenToggle=1
endif

if isdirectory(expand('~/.vim/plugged/vim-indent-guides/'))
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
endif

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

" See `:echo g:airline_theme_map` for some more choices
" Default in terminal vim is 'dark'
if isdirectory(expand('~/.vim/plugged/vim-airline-themes/'))
    if !exists('g:airline_theme')
        let g:airline_theme = 'solarized'
    endif
    if !exists('g:airline_powerline_fonts')
        " Use the default set of separators with a few customizations
        let g:airline_left_sep='›'  " Slightly fancier than '>'
        let g:airline_right_sep='‹' " Slightly fancier than '<'
    endif
endif

" Initialize directories {
function! InitializeDirectories()
    let l:parent = $HOME
    let l:prefix = 'vim'
    let l:dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }
    if has('persistent_undo')
        let l:dir_list['undo'] = 'undodir'
    endif
    " To specify a different directory in which to place the vimbackup,
    " vimviews, vimundo, and vimswap files/directories, add the following to
    " your .vimrc.before.local file:
    "   let g:spf13_consolidated_directory = <full path to desired directory>
    "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
    if exists('g:spf13_consolidated_directory')
        let l:common_dir = g:spf13_consolidated_directory . l:prefix
    else
        let l:common_dir = l:parent . '/.' . l:prefix
    endif

    for [l:dirname, l:settingname] in items(l:dir_list)
        let l:directory = l:common_dir . l:dirname . '/'
        if exists('*mkdir')
            if !isdirectory(l:directory)
                call mkdir(l:directory)
            endif
        endif
        if !isdirectory(l:directory)
            echo 'Warning: Unable to create backup directory: ' . l:directory
            echo 'Try: mkdir -p ' . l:directory
        else
            let l:directory = substitute(l:directory, ' ', "\\\\ ", 'g')
            exec 'set ' . l:settingname . '=' . l:directory
        endif
    endfor
endfunction
call InitializeDirectories()

" Initialize NERDTree as needed
function! NERDTreeInitAsNeeded()
    redir => l:bufoutput
    buffers!
    redir END
    let l:idx = stridx(l:bufoutput, 'NERD_tree')
    if l:idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
    endif
endfunction

" Shell command
function! s:RunShellCommand(cmdline)
    botright new
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal noswapfile
    setlocal nowrap
    setlocal filetype=shell
    setlocal syntax=shell
    call setline(1, a:cmdline)
    call setline(2, substitute(a:cmdline, '.', '=', 'g'))
    execute 'silent $read !' . escape(a:cmdline, '%#')
    setlocal nomodifiable
    1
endfunction

command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)

function! s:ExpandFilenameAndExecute(command, file)
    execute a:command . ' ' . expand(a:file, ':p')
endfunction

" File extension colouring
function! NERDTreeHighlightFile(extension, fg)
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
 "exec 'autocmd filetype nerdtree highlight ' . a:extension . ' ctermfg='. a:fg .' guifg='. a:fg
 exec 'autocmd filetype nerdtree highlight ' . a:extension . ' ctermfg='. a:fg
endfunction

call NERDTreeHighlightFile('txt', 'gray')
call NERDTreeHighlightFile('erl', 'yellow')
call NERDTreeHighlightFile('hrl', 'darkblue')
call NERDTreeHighlightFile('beam', 'darkgray')
call NERDTreeHighlightFile('class', 'darkgray')
call NERDTreeHighlightFile('log', 'darkgray')
call NERDTreeHighlightFile('html', 'blue')
call NERDTreeHighlightFile('mk', 'white')
call NERDTreeHighlightFile('Makefile', 'white')
call NERDTreeHighlightFile('md', 'gray')
call NERDTreeHighlightFile('config', 'darkred')
call NERDTreeHighlightFile('py', 'green')
call NERDTreeHighlightFile('java', '226')
call NERDTreeHighlightFile('groovy', '226')
call NERDTreeHighlightFile('yml', '220')
call NERDTreeHighlightFile('png', '129')
call NERDTreeHighlightFile('jpg', '129')
call NERDTreeHighlightFile('gz', '88')
call NERDTreeHighlightFile('jar', '88')

"for g:ls_color in split($LS_COLORS,':')
  "if match(g:ls_color,'^\*') > -1
    "let g:fields = split(g:ls_color,';')
    "call NERDTreeHighlightFile(g:fields[0][2:-4],fields[3])
  "endif
"endfor

let g:NERDTreeStatusline="%{matchstr(getline('.'), '\\s\\zs\\w\\(.*\\)')}"
let g:NERDTreeBookmarks = 1
let g:NERDTreeBookmarksSort = 0
let g:NERDTreeWinSize    = 35
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI  = 1
let g:NERDTreeDirArrows  = 1
let g:NERDTreeShowHidden = 0
let g:tagbar_width = 30
let g:tagbar_sort  = 0
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 0
let g:indentLine_showFirstIndentLevel = '1'
let g:indentLine_concealcursor = 1
let g:matchparen_timeout = 20
let g:matchparen_insert_timeout = 20

let g:deoplete#auto_complete_start_length = 3
let g:deoplete#auto_complete_delay = 2
let g:deoplete#max_menu_width = 30
let g:tmuxcomplete#trigger = ''
let g:comfortable_motion_no_default_key_mappings = 1
let g:erlang_tags_auto_update = 1
let g:erlang_tags_ignore = ['rel','_build/default/rel', '_build/test', '_build/docs']
let g:erlang_tags_outfile = './.tags'

let g:indentLine_first_char    = '│'
let g:indentLine_color_dark = 1 " (default: 2)
let g:indentLine_color_term = '239'
let g:indentLine_faster = '1'
let g:indentLine_char   = ' '
let g:AutoPairs = {}
let g:ale_sign_error   = '⤬'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str   = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_statusline_format = ['%d⤬', '%d⚠', '⬥ ok']
let g:ale_erlang_erlc_options = '-I../include -I../src -I../../include  -I../_build/default/lib -I../_build/test/lib -I~/code/id -I~/code/fredp -I../..'
let g:ale_java_javac_options = '-sourcepath /Users/liam.mcnamara/code/scheme/scheme/app/src/gen/java;/Users/liam.mcnamara/code/scheme/scheme/app/src/main/java'
"let g:ale_java_javac_options = '-classpath .:/Users/liam.mcnamara/code/scheme/scheme_app_java/target/classes/:/Users/liam.mcnamara/code/scheme/scheme_app_java/target/scheme_app-0.1.0/WEB-INF/lib/*'

let g:lt_location_list_toggle_map = '<Leader>l'
let g:lt_quickfix_list_toggle_map = '<Leader>x'

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   l:all_non_errors,
    \   l:all_errors
    \)
endfunction

let g:airline_theme='distinguished'
let g:airline_section_c = ''
let g:airline_section_y = '' "      (fileencoding, fileformat)
let g:airline_section_error = '%q'
let g:airline#extensions#bufferline#enabled = 1
let g:airline_section_warning = '%{LinterStatus()}'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 1
let g:airline#extensions#tabline#fnamemod     = ':t'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs    = 0
let g:airline#extensions#tabline#tab_nr_type  = 1 " tab number
let g:airline#extensions#tabline#show_splits  = 1
let g:bufferline_modified = '+'
let g:Tlist_Show_One_File = 1
let g:sneak#label = 1
let g:sneak#s_next = 1
let g:autoswap_detect_tmux = 1


" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~# 'iTerm.app'
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    let &t_SR = "\<esc>]50;CursorShape=2\x7" " Underline in replace mode
  endif
endif

colorscheme molokai_dark
" Line numbers
highlight visual ctermbg=240
highlight LineNr ctermbg=235 ctermfg=239
"highlight CursorLineNr ctermbg=234 ctermfg=239
"highlight CursorLineNr ctermbg=234 ctermfg=202
highlight clear CursorLine
highlight ColorColumn ctermbg=234
highlight SpecialKey  ctermbg=235
" Sign column for Git
highlight SignColumn  ctermbg=235
highlight DiffAdd     ctermbg=235
highlight DiffDelete  ctermbg=235
highlight DiffChange  ctermbg=235
" Lint ale
highlight ALEErrorSign   ctermbg=235 ctermfg=1
highlight ALEWarningSign ctermbg=235 ctermfg=202
highlight ALEInfoSign    ctermbg=235
" Syntastic
highlight Error   ctermbg=235 ctermfg=202
highlight Warning ctermbg=235 ctermfg=200
highlight Todo    ctermbg=235 ctermfg=208

highlight Directory ctermfg='blue'
" popup menu
highlight Pmenu     ctermbg=0 ctermfg=202
highlight PmenuSel    ctermbg=202 ctermfg=0
highlight PmenuSbar   ctermbg=0 ctermfg=202
highlight VertSplit   ctermbg=235

fu! SaveSession()
    "execute 'call mkdir(%:p:h/.vim)'
    execute 'mksession! $HOME/.vim/session.vim'
endfunction

fu! RestoreSession()
execute 'so $HOME/.vim/session.vim'
if bufexists(1)
    for l:buf in range(1, bufnr('$'))
        if bufwinnr(l:buf) == -1
            exec 'sbuffer ' . l:buf
        endif
    endfor
endif
endfunction

augroup sessions
  autocmd VimLeave * call SaveSession()
augroup END

" Strip whitespace {
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let l:_s=@/
    let l:l = line('.')
    let l:c = col('.')
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=l:_s
    call cursor(l:l, l:c)
endfunction

" function to try appending filetypes on filename to open
function! TryOpenExpand()
  if ! filereadable(@%)
    let l:file_erlang = @% . '.erl'
    let l:file_java= @% . '.java'
    if filereadable(l:file_erlang)
      execute 'bd'
      execute 'open' l:file_erlang
      set filetype=erlang
    elseif filereadable(l:file_java)
      execute 'bd'
      execute 'open' l:file_java
      set filetype=java
    endif
  endif
endfunction

augroup expandfilename
  "autocmd BufNewFile * call TryOpenExpand(@%)
  autocmd BufNewFile * call TryOpenExpand()
augroup END

augroup fileguff
  autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:spf13_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
  "autocmd FileType go autocmd BufWritePre <buffer> Fmt
  autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
  autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
  " preceding line best in a plugin but here for now.

  autocmd BufNewFile,BufRead *.coffee set filetype=coffee

  " Workaround vim-commentary for Haskell
  autocmd FileType haskell setlocal commentstring=--\ %s
  " Workaround broken colour highlighting in Haskell
  autocmd FileType haskell,rust setlocal nospell
  autocmd FileType yaml setlocal cursorcolumn
augroup END

augroup gitpos
  " Instead of reverting the cursor to the last position in the buffer, we
  " set it to the first line when editing a git commit message
  autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END

augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
augroup END

augroup DeopleteLazy
  autocmd InsertEnter * call deoplete#enable()
augroup END

aug netrw_close
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"|q|endif
augroup END

" Skeleton templates
augroup templates
  autocmd BufNewFile *.sh      0r ~/.vim/templates/skeleton.sh
  autocmd BufNewFile *.erl     0r ~/.vim/templates/skeleton.erl
  autocmd BufNewFile *.escript 0r ~/.vim/templates/skeleton.escript
  autocmd BufNewFile *.py      0r ~/.vim/templates/skeleton.py
  autocmd BufNewFile *.java    0r ~/.vim/templates/skeleton.java
augroup END

augroup nerdtree
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | execute 'NERDTreeToggle'| endif
augroup END

augroup filetypes
  autocmd FileType c,cpp,h,hpp setlocal foldmethod=syntax
  autocmd FileType erlang setlocal shiftwidth=0 tabstop=2 softtabstop=2 sw=2 ts=2 sts=2
  autocmd FileType python setlocal shiftwidth=2 tabstop=2 noexpandtab
  autocmd FileType nerdtree set norelativenumber
  autocmd FileType netrw    set nonumber
  autocmd FileType taglist  set nonumber norelativenumber
  autocmd Filetype json let g:indentLine_setConceal = 0
augroup END

augroup tmux_integration
  autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window \\<" . expand("%:t") . "\\>")
  "autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
  "autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=0
  autocmd BufEnter * let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
  autocmd BufEnter * call system("tmux rename-window \\<" . expand("%:t") . "\\>" )
augroup END

" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
" To disable this, add the following to your .vimrc.before.local file:
"   let g:spf13_no_restore_cursor = 1
function! ResCur()
    if line("'\"") <= line('$')
        silent! normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" For cscope
let &runtimepath=&runtimepath . ',~/.vim/plugin'

let g:ale_completion_enabled = 1
let g:ale_fixers = {'java': ['google_java_format']}

" Language Client
let g:LanguageClient_autoStart = 1
let g:LanguageClient_autoStop = 0
let g:LanguageClient_serverCommands = {
    \ 'java' : ['java-lang-server'],
    \ }

let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_NCM_LOG_LEVEL="DEBUG"
let $NVIM_NCM_MULTI_THREAD=0

"if executable('erlang_ls')
    "au User lsp_setup call lsp#register_server({
        "\ 'name': 'erlang_ls',
        "\ 'cmd': {server_info->['erlang_ls']},
        "\ 'whitelist': ['erlang'],
        "\ })
"endif

" Erlang
"set runtimepath^=~/.vim/plugged/vim-erlang-runtime
set runtimepath^=~/.vim/plugged/vim-erlang-tags

" this should reflect the kerl setting
"set runtimepath^=/usr/local/erlang/19.3/bin/erl

if has('gui_running')
    if filereadable(expand('~/.gvimrc.local'))
        source ~/.gvimrc.local
    endif
endif
