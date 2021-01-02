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

