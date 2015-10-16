let $MYVIMRC = expand('<sfile>')
let $HOME = expand('<sfile>:h')

set fileformats=unix,dos,mac
set history=100
set ignorecase
set smartcase
set smarttab
set expandtab
set title
set wrapscan
set number
set ruler
set showcmd
set laststatus=2
set showmatch
set hlsearch
set ttyfast

set wildmenu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,euc-jp,cp932,iso-2022-jp
set fileencodings+=,ucs-2le,ucs-2

" 全角対策
if exists('&ambiwidth')
  set ambiwidth=double
endif

" Go に付属の plugin と gocode を有効にする
set rtp+=${GOROOT}/misc/vim
set rtp+=${GOPATH}/src/github.com/nsf/gocode/vim

call plug#begin('~/.vim/plugged')
Plug 'Shougo/unite.vim'
Plug 'Shougo/neocomplcache'
Plug 'Shougo/vimproc'
Plug 'tpope/vim-endwise'
Plug 'tomasr/molokai'
Plug 'ujihisa/unite-colorscheme'
Plug 'chrishunt/color-schemes'
Plug 'bling/vim-airline'
Plug 'Lokaltog/powerline'
Plug 'Lokaltog/powerline-fonts'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go'
Plug 'tpope/vim-rails'
Plug 'markcornick/vim-terraform'
Plug 'scrooloose/nerdtree'
Plug 'rking/ag.vim'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'Lokaltog/vim-easymotion'
Plug 'rhysd/unite-codic.vim'
Plug 'koron/codic-vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'nathanaelkane/vim-indent-guides'
call plug#end()

nnoremap <silent><C-e> :NERDTreeToggle<CR>

let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
if executable('ag')
  let g:ctrlp_use_caching = 0
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
"let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_open_new_file = 1
let g:ctrlp_clear_cache_on_exit = 0

"easymotion
let g:EasyMotion_do_mapping = 0 "Disable default mappings
nmap s <Plug>(easymotion-s2)

" gocode
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")

" 不可視文字の表示
set list
" タブ、半角スペースの表示
set listchars=tab:>-,trail:.

" 検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch
" Esc連打で検索時にハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" vim-indent-guides
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=110
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=140
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

nnoremap 1, 1gt<CR>
nnoremap 2, 2gt<CR>
nnoremap 3, 3gt<CR>
nnoremap 4, 4gt<CR>
nnoremap 5, 5gt<CR>
nnoremap 6, 6gt<CR>
nnoremap 7, 7gt<CR>
nnoremap 8, 8gt<CR>
nnoremap 9, 9gt<CR>

cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%

filetype plugin on
syntax enable
set t_Co=256
set background=dark
"colorscheme molokai
colorscheme base16-railscasts
highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight ColorColumn  ctermbg=237
highlight LineNr       ctermbg=236 ctermfg=240
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine   ctermbg=236
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=240 ctermfg=12
highlight IncSearch    ctermbg=0   ctermfg=3
highlight Search       ctermbg=0   ctermfg=9
highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=0   ctermfg=3
highlight SpellBad     ctermbg=0   ctermfg=1

nmap <Tab>      gt
nmap <S-Tab>    gT

set backspace=indent,eol,start

autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

autocmd FileType ruby setl autoindent
autocmd FileType ruby setl smartindent cinwords=if,else,for,while,try,except,finally,def,class
autocmd FileType ruby setl tabstop=2 expandtab shiftwidth=2 softtabstop=2

autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
autocmd FileType css        setlocal sw=4 sts=4 ts=4 noet
autocmd FileType diff       setlocal sw=4 sts=4 ts=4 noet
autocmd FileType html       setlocal sw=4 sts=4 ts=4 noet
autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
autocmd FileType javascript setlocal sw=4 sts=4 ts=4 noet
autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
autocmd FileType sh         setlocal sw=4 sts=4 ts=4 et
autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 noet
autocmd FileType xml        setlocal sw=4 sts=4 ts=4 noet
autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
autocmd FileType zsh        setlocal sw=2 sts=2 ts=2 et
autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et

let g:syntastic_mode_map = { 'mode': 'passive',
    \ 'active_filetypes': ['go'] }
let g:syntastic_go_checkers = ['go', 'golint']

"let g:syntastic_mode_map = { 'mode': 'passive',
"            \ 'active_filetypes': ['ruby'] }
"let g:syntastic_ruby_checkers = ['rubocop']

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
