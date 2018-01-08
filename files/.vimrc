set encoding=utf-8
scriptencoding utf-8

" Environment {

" Identify platform {
silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction


set shell=/bin/sh

" Arrow Key Fix {
    " https://github.com/spf13/spf13-vim/issues/780
    if &term[:4] == 'xterm' || &term[:5] == 'screen' || &term[:3] == 'rxvt'
        inoremap <silent> <C-[>OC <RIGHT>
    endif
" }

" Use before config if available {
    if filereadable(expand('~/.vimrc.before'))
        source ~/.vimrc.before
    endif
" }

" Use bundles config {
    if filereadable(expand('~/.vimrc.bundles'))
        source ~/.vimrc.bundles
    endif
" }

set background=dark         " Assume a dark background
filetype plugin indent on   " Automatically detect file types.
syntax on                   " Syntax highlighting
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
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

set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
set spell                           " Spell checking on
set hidden                          " Allow buffer switching without saving
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator

augroup gitpos
  " Instead of reverting the cursor to the last position in the buffer, we
  " set it to the first line when editing a git commit message
  autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END

" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
" To disable this, add the following to your .vimrc.before.local file:
"   let g:spf13_no_restore_cursor = 1
if !exists('g:spf13_no_restore_cursor')
    function! ResCur()
        if line("'\"") <= line("$")
            silent! normal! g`"
            return 1
        endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END
endif

" Setting up the directories {
    set backup                  " Backups are nice ...
    if has('persistent_undo')
        set undofile                " So is persistent undo ...
        set undolevels=1000         " Maximum number of changes that can be undone
        set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    endif

    " To disable views add the following to your .vimrc.before.local file:
    "   let g:spf13_no_views = 1
    if !exists('g:spf13_no_views')
        " Add exclusions to mkview and loadview
        " eg: *.*, svn-commit.tmp
        let g:skipview_files = [
            \ '\[example pattern\]'
            \ ]
    endif
" }

" Vim UI {

if !exists('g:override_spf13_bundles') && filereadable(expand('~/.vim/bundle/vim-colors-solarized/colors/solarized.vim'))
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast='normal'
    let g:solarized_visibility='normal'
    color solarized             " Load a colorscheme
endif

set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
set cursorline                  " Highlight current line

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
"highlight clear CursorLineNr    " Remove highlight color from current line number

if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
endif

if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    if !exists('g:override_spf13_bundles')
        set statusline+=%{fugitive#statusline()} " Git Hotness
    endif
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
"set matchpairs+=<:>             " Match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" Remove trailing whitespaces and ^M chars
" To disable the stripping of whitespace, add the following to your
" .vimrc.before.local file:
"   let g:spf13_keep_trailing_whitespace = 1

"augroup fileguff
  "autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:spf13_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
  ""autocmd FileType go autocmd BufWritePre <buffer> Fmt
  "autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
  "autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
  "" preceding line best in a plugin but here for now.

  "autocmd BufNewFile,BufRead *.coffee set filetype=coffee

  "" Workaround vim-commentary for Haskell
  "autocmd FileType haskell setlocal commentstring=--\ %s
  "" Workaround broken colour highlighting in Haskell
  "autocmd FileType haskell,rust setlocal nospell
"augroup END

" }

" Key (re)Mappings {

    " The default leader is '\', but many people prefer ',' as it's in a standard
    " location. To override this behavior and set it back to '\' (or any other
    " character) add the following to your .vimrc.before.local file:
    "   let g:spf13_leader='\'
    if !exists('g:spf13_leader')
        let g:mapleader = ','
    else
        let g:mapleader=g:spf13_leader
    endif
    if !exists('g:spf13_localleader')
        let g:maplocalleader = '_'
    else
        let g:maplocalleader=g:spf13_localleader
    endif

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

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " End/Start of line motion keys act relative to row/wrap width in the
    " presence of `:set wrap`, and relative to line for `:set nowrap`.
    " Default vim behaviour is to act relative to text line in both cases
    " If you prefer the default behaviour, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_no_wrapRelMotion = 1
    if !exists('g:spf13_no_wrapRelMotion')
        " Same for 0, home, end, etc
        function! WrapRelativeMotion(key, ...)
            let vis_sel=""
            if a:0
                let vis_sel="gv"
            endif
            if &wrap
                execute "normal!" vis_sel . "g" . a:key
            else
                execute "normal!" vis_sel . a:key
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
    endif

    " The following two lines conflict with moving to top and
    " bottom of the screen
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_no_fastTabs = 1
    if !exists('g:spf13_no_fastTabs')
        map <S-H> gT
        map <S-L> gt
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

    " Most prefer to toggle search highlighting rather than clear the current
    " search results. To clear search highlighting rather than toggle it on
    " and off, add the following to your .vimrc.before.local file:
    "   let g:spf13_clear_search_highlight = 1
    if exists('g:spf13_clear_search_highlight')
        nmap <silent> <leader>/ :nohlsearch<CR>
    else
        nmap <silent> <leader>/ :set invhlsearch<CR>
    endif

    " Shortcuts
    " Change Working Directory to that of the current file
    "cmap cwd lcd %:p:h
    "cmap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Easier formatting
    nnoremap <silent> <leader>q gwip

    " FIXME: Revert this f70be548
    " fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
    map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

" }

" Plugins {

" Misc {

" NerdTree {
    if isdirectory(expand('~/.vim/plugged/nerdtree'))
        map <C-e> <plug>NERDTreeTabsToggle<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nt :NERDTreeFind<CR>
        let g:NERDShutUp=1

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=0
    endif
" }

" Rainbow {
    if isdirectory(expand("~/.vim/bundle/rainbow/"))
        let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
    endif
"}

" Fugitive {
    if isdirectory(expand('~/.vim/bundle/vim-fugitive/'))
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gr :Gread<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>ge :Gedit<CR>
        " Mnemonic _i_nteractive
        nnoremap <silent> <leader>gi :Git add -p %<CR>
        nnoremap <silent> <leader>gg :SignifyToggle<CR>
    endif
"}



        "" Enable heavy omni completion.
        "if !exists('g:neocomplete#sources#omni#input_patterns')
            "let g:neocomplete#sources#omni#input_patterns = {}
        "endif
        "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        "let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
        "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
        "let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
" }
" Normal Vim omni-completion {
" To disable omni complete, add the following to your .vimrc.before.local file:
"   let g:spf13_no_omni_complete = 1
"    elseif !exists('g:spf13_no_omni_complete')
        " Enable omni-completion.
        "
"augroup filetypecomplete
        "autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        "autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        "autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
        "autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
"augroup END

 "   endif
" }


    " UndoTree {
        if isdirectory(expand('~/.vim/bundle/undotree/'))
            nnoremap <Leader>u :UndotreeToggle<CR>
            " If undotree is opened, it is likely one wants to interact with it.
            let g:undotree_SetFocusWhenToggle=1
        endif
    " }

    " indent_guides {
        if isdirectory(expand('~/.vim/bundle/vim-indent-guides/'))
            let g:indent_guides_start_level = 2
            let g:indent_guides_guide_size = 1
            let g:indent_guides_enable_on_vim_startup = 1
        endif
    " }

    " vim-airline {
        " Set configuration options for the statusline plugin vim-airline.
        " Use the powerline theme and optionally enable powerline symbols.
        " To use the symbols , , , , , , and .in the statusline
        " segments add the following to your .vimrc.before.local file:
        "   let g:airline_powerline_fonts=1
        " If the previous symbols do not render for you then install a
        " powerline enabled font.

        " See `:echo g:airline_theme_map` for some more choices
        " Default in terminal vim is 'dark'
        if isdirectory(expand('~/.vim/bundle/vim-airline-themes/'))
            if !exists('g:airline_theme')
                let g:airline_theme = 'solarized'
            endif
            if !exists('g:airline_powerline_fonts')
                " Use the default set of separators with a few customizations
                let g:airline_left_sep='›'  " Slightly fancier than '>'
                let g:airline_right_sep='‹' " Slightly fancier than '<'
            endif
        endif
    " }



" Functions {

    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " To specify a different directory in which to place the vimbackup,
        " vimviews, vimundo, and vimswap files/directories, add the following to
        " your .vimrc.before.local file:
        "   let g:spf13_consolidated_directory = <full path to desired directory>
        "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
        if exists('g:spf13_consolidated_directory')
            let common_dir = g:spf13_consolidated_directory . prefix
        else
            let common_dir = parent . '/.' . prefix
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists('*mkdir')
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo 'Warning: Unable to create backup directory: ' . directory
                echo 'Try: mkdir -p ' . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec 'set ' . settingname . '=' . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Initialize NERDTree as needed {
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, 'NERD_tree')
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction
    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line('.')
        let c = col('.')
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

    " Shell command {
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
    " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }

    function! s:ExpandFilenameAndExecute(command, file)
        execute a:command . " " . expand(a:file, ":p")
    endfunction

" }


" Settings
set nonumber
set number!
set spell!
set shiftwidth=2
set wrap linebreak nolist
set colorcolumn=81
set list
set clipboard=unnamed
set scrolloff=16
set tabstop=2
set expandtab
set timeoutlen=300 ttimeoutlen=300
set ttimeoutlen=10
set nobackup
set ttyfast
set tags=./tags;/
set foldmethod=indent
set foldenable
set foldlevel=99
set wildmode=list:longest,full
set synmaxcol=130
let g:matchparen_timeout = 20
let g:matchparen_insert_timeout = 20
let &titlestring = expand('%:p')
set title

" Remaps
nnoremap ; :
cmap w!! w !sudo tee % > /dev/null
nnoremap <space> za
nnoremap K kJ
nnoremap Q @q
nnoremap # *
nnoremap n nzz
nnoremap N Nzz
nnoremap T y$
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$
vnoremap // y/<C-R>"<CR>
" buffer switching
map <Leader>n :bn<cr>
map <Leader>p :bp<cr>
map <Leader>d :bd<cr>
map <Leader>u :UndotreeToggle<cr>
"nnoremap <Tab> :bnext<CR>
"nnoremap <S-Tab> :bprevious<CR>
" tag jumping
nnoremap <Leader>k <C-]>
nnoremap <Leader>j <C-T>

nnoremap <Left>  :echo "No left for you!"<CR>
nnoremap <Right> :echo "No right for you!"<CR>
nnoremap <Up>    :echo "No up for you!"<CR>
nnoremap <Down>  :echo "No down for you!"<CR>

" Prompt for a command to run map
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>f :NERDTreeToggle<CR>

" File extension colouring
function! NERDTreeHighlightFile(extension, fg)
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
 exec 'autocmd filetype nerdtree highlight ' . a:extension . ' ctermfg='. a:fg .' guifg='. a:fg
endfunction
call NERDTreeHighlightFile('txt', 'white')
call NERDTreeHighlightFile('erl', 'yellow')
call NERDTreeHighlightFile('hrl', 'darkblue')
call NERDTreeHighlightFile('beam', 'darkgray')
call NERDTreeHighlightFile('log', 'darkgray')
call NERDTreeHighlightFile('html', 'blue')
call NERDTreeHighlightFile('mk', 'white')
call NERDTreeHighlightFile('Makefile', 'white')
call NERDTreeHighlightFile('md', 'gray')
call NERDTreeHighlightFile('config', 'darkred')
let g:NERDTreeStatusline="%{matchstr(getline('.'), '\\s\\zs\\w\\(.*\\)')}"
let g:NERDTreeBookmarksSort = 0
let g:NERDTreeWinSize    = 30
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
let g:ale_erlang_erlc_options = '-I../include  -I../_build/default/lib -I../_build/test/lib -I~/code/id -I~/code/fredp -I../..'

let g:lt_location_list_toggle_map = '<Leader>l'
let g:lt_quickfix_list_toggle_map = '<Leader>x'

let g:airline_theme='distinguished'
let g:airline_section_c = ''
let g:airline_section_y = '' "      (fileencoding, fileformat)
let g:airline_section_error = '%q'
let g:airline#extensions#bufferline#enabled = 1
let g:airline_section_warning = '%{ALEGetStatusLine()}'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:bufferline_modified = '+'
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#show_close_button = 1
let g:airline#extensions#tabline#fnamemod     = ':t'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs    = 0
let g:airline#extensions#tabline#tab_nr_type  = 1 " tab number
let g:airline#extensions#tabline#show_splits  = 1
let g:Tlist_Show_One_File = 1

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

" Line numbers
highlight LineNr       ctermbg=234 ctermfg=239
"highlight CursorLineNr ctermbg=234 ctermfg=239
"highlight CursorLineNr ctermbg=234 ctermfg=202
"highlight CursorLine   ctermbg=black
highlight SpecialKey   ctermbg=234
" Sign column for Git
highlight clear SignColumn
highlight SignColumn ctermbg=234
highlight DiffAdd    ctermbg=234
highlight DiffDelete ctermbg=234
highlight DiffChange ctermbg=234
" Lint ale
highlight ALEErrorSign   ctermbg=234 ctermfg=1
highlight ALEWarningSign ctermbg=234 ctermfg=202
" Syntastic
highlight Error ctermbg=234 ctermfg=202
highlight Warning ctermbg=234 ctermfg=200
highlight Todo ctermbg=234 ctermfg=208

highlight Directory ctermfg='blue'
" popup menu
highlight Pmenu     ctermbg=0 ctermfg=202
" popup selected
highlight PmenuSel  ctermbg=202 ctermfg=0
highlight PmenuSbar ctermbg=0 ctermfg=202
set norelativenumber
set nocursorline
set spellsuggest=best,10

inoremap jj <ESC>
map <CR> o<Esc>

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

nnoremap <Leader>y :FZF<cr>

nnoremap z= i<C-X><C-S>
unmap <Leader>q
"unmap <Leader>nt
"unmap <Leader>fu
" vimprompt
map <Leader>q :VimuxPromptCommand<CR>
map <Leader>w :call VimuxRunCommand("fc -e : -1")<CR>
map <Leader>W :VimuxRunLastCommand<CR>
" Generate tags and cscope
map <Leader>T :!tagscope<CR>

augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
  "au InsertEnter * hi Normal ctermfg=234
  "au InsertLeave * hi Normal ctermfg=232
augroup END

augroup DeopleteLazy
  autocmd InsertEnter * call deoplete#enable()
augroup END

aug netrw_close
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"|q|endif
aug END

" Skeleton templates
augroup templates
  autocmd BufNewFile *.sh      0r ~/.vim/templates/skeleton.sh
  autocmd BufNewFile *.erl     0r ~/.vim/templates/skeleton.erl
  autocmd BufNewFile *.escript 0r ~/.vim/templates/skeleton.escript
  autocmd BufNewFile *.py      0r ~/.vim/templates/python.py
augroup END

augroup nerdtree
  autocmd StdinReadPre * let s:std_in=1
  "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTreeToggle | endif
augroup END

augroup filetypes
  autocmd FileType c,cpp,h,hpp setlocal foldmethod=syntax
  autocmd FileType erlang setlocal shiftwidth=0 tabstop=2 softtabstop=2 sw=2 ts=2 sts=2
  autocmd FileType python setlocal shiftwidth=2 tabstop=2 noexpandtab
  autocmd FileType nerdtree set norelativenumber
  autocmd FileType netrw    set nonumber
  autocmd FileType taglist  set nonumber norelativenumber
augroup END

augroup tmux_integration
  autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window \\<" . expand("%:t") . "\\>")
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=0
  autocmd BufEnter * let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
  autocmd BufEnter * call system("tmux rename-window \\<" . expand("%:t") . "\\>" )
augroup END

"nmap <leader><tab> <plug>(fzf-maps-n)

let g:minimap_show='<leader>M'
let g:minimap_update='minimap_update'
let g:minimap_close='minimap_close'
let g:minimap_toggle='minimap_toggle'
"augroup miniview
"  autocmd BufReadPost,FileReadPost,BufNewFile * call minimap#ShowMinimap()
"augroup END


let g:completor_python_binary = '/usr/bin/python'
let g:completor_erlang_omni_trigger = '.*'

" Use deoplete.
"let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 3
let g:deoplete#auto_complete_delay = 2
let g:deoplete#max_menu_width = 20
let g:tmuxcomplete#trigger = ''

colorscheme molokai_dark

" For cscope
let &runtimepath=&runtimepath . ',~/.vim/plugin'

" Erlang
set runtimepath^=~/.vim/bundle/vim-erlang-runtime
set runtimepath+=/usr/local/opt/fzf

" this should reflect the kerl setting
set runtimepath^=/usr/local/erlang/kredotp/bin/erl

" Use local gvimrc if available and gui is running {
    if has('gui_running')
        if filereadable(expand('~/.gvimrc.local'))
            source ~/.gvimrc.local
        endif
    endif
" }
