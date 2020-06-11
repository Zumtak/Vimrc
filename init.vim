"Configure Plug
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'rhysd/vim-clang-format'
Plug 'neomake/neomake'
Plug 'cloudhead/neovim-fuzzy'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'bling/vim-airline'
Plug 'liuchengxu/vista.vim'
Plug 'vim-scripts/vim-stay' " Save cursor position and folds when closing file
Plug 'Konfekt/FastFold'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline-themes'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'}
call plug#end()

"Ctrl-Space to use clang-format
nnoremap <C-Space> :ClangFormat<CR>
vnoremap <C-Space> :ClangFormat<CR>

let g:clang_format#detect_style_file = 1

:highlight NeomakeSign guifg=Yellow guibg=#dc322f gui=bold
let g:neomake_warning_sign={'text': '•', 'texthl': 'NeomakeSign'}
let g:neomake_error_sign={'text': '!', 'texthl': 'NeomakeSign'}

"Map Alt+Arrows to move lines
nnoremap <M-Up> :m-2<CR>==
nnoremap <M-Down> :m+<CR>==
inoremap <M-Up> :m-2<CR>==gi
inoremap <M-Down> :m+<CR>==gi
vnoremap <M-Up> :m '<-2<CR>gv=gv
vnoremap <M-Down> :m '>+1<CR>gv=gv
nnoremap <M-Space> :ClangFormat<CR>

" Invert k and j letter for up and down
nnoremap j k
nnoremap k j

" Quick save
nnoremap m :wa<CR>

" Switch buffer quickly
nnoremap <M-Right> :bn<CR>
nnoremap <M-Left> :bp<CR>

"Use the clipboard as default register
set clipboard=unnamedplus

" Managing buffer
let g:airline#extensions#tabline#enabled = 1

" Ignore file with NerdTree
let NERDTreeIgnore = ['\.o$', '\.gcda$', '\.gcno$']

"Configure header guard
function HeaderGuard(filename)
    let define = join(split(toupper(expand(a:filename)), '\.'), '_') . "_"
    call append(line('$'),[
                \"#ifndef " . define,
                \"#define " . define,
                \"","","",
                \"#endif /* !" . define . " */"])
    execute "normal! jjjj"
endfunction

"Configure epitech header
function WriteHeader()
    let projectName = input("Project Name : ")
    let fileDescription = input("File description : ")
    let extension = expand('%:e')
    let isHeader = extension == "hpp" || extension == "h"
    if &filetype == "make"
        call append(line(0), ["##", "## EPITECH PROJECT, 2019",
                    \"## " . projectName, "## File description:",
                    \"## " . fileDescription, "##"])
    else
        call append(line(0), ["/*", "** EPITECH PROJECT, 2019",
                    \"** " . projectName, "** File description:",
                    \"** " . fileDescription, "*/"])
    endif
    if isHeader
        call HeaderGuard(expand("%:t"))
    endif
endfunction
nnoremap <C-s> :call WriteHeader()<CR>

"Set fuzzy-search keybind
nnoremap <C-f> :FuzzyOpen<CR>

" Disable fold for markdown
let g:vim_markdown_folding_disabled = 1

"Configure coc.nvim to use tab to navigate completions and enter to confirm
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
nnoremap <C-c> <Plug>(coc-rename)
nnoremap <silent> K :call CocActionAsync('doHover')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-declaration)
set completeopt+=preview
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

let g:coc_snippet_prev = '<C-h>'
let g:coc_snippet_next = '<C-l>'

" Ultisnip config
let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" CocAction
nnoremap <C-c> :CocAction<CR>

"Configure vista
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'coc'
"let g:vista_echo_cursor_strategy = 'floating_win'

"Configure cpp highlighting
let g:cpp_member_variable_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1


set nocp
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set background=dark
set number
set relativenumber
set mouse=a
set colorcolumn=80
colorscheme PaperColor
autocmd VimEnter * NERDTree | wincmd p
