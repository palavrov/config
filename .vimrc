" .vimrc file
" by Atanas Palavrov
" CODIGI

set nocompatible              " be iMproved
filetype off                  " required!

filetype plugin indent on    " required
filetype plugin on

" Set max open tabs at startup
set tabpagemax=99

" Set no wrapping mode
set nowrap

" Write the old file when switching between files
"set autowrite

" Set timeout for <leader> key
set timeoutlen=1000

" Switch between buffers without save
set hidden

" Set color scheme
colorscheme solarized
set background=dark
let g:solarized_termcolors=256

" Must be after "colorscheme solarized" to avoid OSX messed colors
syntax enable

" Show command in bottom right
set showcmd

" Show line numbers
set number
set ruler

" Indent stuff
set smartindent
set autoindent

" Always show last status line
set laststatus=2

" Higher lines height
"set linespace=3

" Incremental search
set incsearch

" Highlight search
set hlsearch

" Case insensitive search
"set ignorecase
"set smartcase

" Hide GVIM toolbar
set go-=T

" Enable code folding
set foldenable

" Useful command-line completion
set wildmenu

" Auto-completion menu
set wildmode=list:longest

" Better autocomplete menu
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone

" Space instead of tab characters
set tabstop=4
set shiftwidth=4
set expandtab

" Replace visual selection
" http://stackoverflow.com/questions/676600/vim-replace-selected-text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Source the vimrc file after saving it. This way, you don't have to reload Vim to see the changes.
if has("autocmd")
 augroup myvimrchooks
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
 augroup END
endif

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" clang_complete
" http://blog.wuwon.id.au/2011/10/vim-plugin-for-navigating-c-with.html
let g:clang_auto_select=1
let g:clang_complete_auto=1
let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=0
let g:clang_snippets=1
let g:clang_snippets_engine="clang_complete"
let g:clang_conceal_snippets=0
let g:clang_exec="clang"
let g:clang_user_options=""
let g:clang_auto_user_options="path, .clang_complete"
let g:clang_use_library=1

" http://stackoverflow.com/questions/20645920/adding-clang-complete-to-homebrew-installed-vim-on-mac
let s:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
if isdirectory(s:clang_library_path)
    let g:clang_library_path=s:clang_library_path
endif

let g:clang_sort_algo="priority"
let g:clang_complete_macros=1
let g:clang_complete_patterns=1
nnoremap <Leader>q :call g:ClangUpdateQuickFix()<CR>

" Automatically enable auto-complete for HTML files
" https://docs.oseems.com/general/application/vim/auto-complete-html
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" Force 'Gdiff' to split the window vertically
" https://github.com/thoughtbot/dotfiles/issues/655#issuecomment-605019271
set diffopt-=internal
set diffopt+=vertical

" https://robots.thoughtbot.com/how-to-do-90-of-what-plugins-do-with-just-vim
set path+=**

" https://jaxbot.me/articles/setting-up-vim-for-react-js-jsx-02-03-2015
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" https://medium.com/swlh/ultimate-vim-typescript-setup-35b5ac5c8c4e
let g:coc_global_extensions = [ 'coc-clangd', 'coc-css', 'coc-html', 'coc-json', 'coc-sh', 'coc-tsserver' ]

" https://github.com/neoclide/coc.nvim
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-refactor)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
