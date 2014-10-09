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

set wildmenu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,euc-jp,cp932,iso-2022-jp
set fileencodings+=,ucs-2le,ucs-2

if exists('&ambiwidth')
  set ambiwidth=double
endif

" :Fmt などで gofmt の代わりに goimports を使う
let g:gofmt_command = 'goimports'

" Go に付属の plugin と gocode を有効にする
set rtp+=${GOROOT}/misc/vim
set rtp+=${GOPATH}/src/github.com/nsf/gocode/vim

" 保存時に :Fmt する
au BufWritePre *.go Fmt
au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4
au FileType go compiler go

" neobundle
set nocompatible
filetype off
if has('vim_starting')
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand($HOME . '/.vim/bundle/'))
filetype plugin indent on
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif
let g:neobundle_default_git_protocol='https'

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'thinca/vim-ref.git'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tomasr/molokai'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'

NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }


" 検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch
" Esc連打で検索時にハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR><Esc>

cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%

let g:neocomplcache_enable_at_startup = 1

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

autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
autocmd FileType aspvbs     setlocal sw=4 sts=4 ts=4 noet
autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
autocmd FileType css        setlocal sw=4 sts=4 ts=4 noet
autocmd FileType diff       setlocal sw=4 sts=4 ts=4 noet
autocmd FileType eruby      setlocal sw=4 sts=4 ts=4 noet
autocmd FileType html       setlocal sw=4 sts=4 ts=4 noet
autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
autocmd FileType javascript setlocal sw=4 sts=4 ts=4 noet
autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
autocmd FileType eruby      setlocal sw=2 sts=2 ts=2 et
autocmd FileType sh         setlocal sw=4 sts=4 ts=4 et
autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
autocmd FileType vb         setlocal sw=4 sts=4 ts=4 noet
autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
autocmd FileType wsh        setlocal sw=4 sts=4 ts=4 et
autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 noet
autocmd FileType xml        setlocal sw=4 sts=4 ts=4 noet
autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
autocmd FileType zsh        setlocal sw=2 sts=2 ts=2 et
autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et
autocmd FileType puppet     setlocal sw=2 sts=2 ts=2 et

" 80文字以上をハイライトhttp://vim-users.jp/2011/05/hack217/
set textwidth=0
if exists('&colorcolumn')
   set colorcolumn=+1
   " sh,perl,vim,...の部分は自分が使う
   " プログラミング言語のfiletypeに合わせてください
   autocmd FileType sh,perl,vim,ruby,python setlocal textwidth=80
endif

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

