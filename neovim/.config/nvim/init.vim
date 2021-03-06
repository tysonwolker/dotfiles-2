" vim: ft=vim
"
"             __
"     __  __ /\_\    ___ ___   _ __   ___
"    /\ \/\ \\/\ \ /' __` __`\/\`'__\/'___\
"  __\ \ \_/ |\ \ \/\ \/\ \/\ \ \ \//\ \__/
" /\_\\ \___/  \ \_\ \_\ \_\ \_\ \_\\ \____\
" \/_/ \/__/    \/_/\/_/\/_/\/_/\/_/ \/____/
"
"
"================================================================================
" Vim-Plug

" Automatic installation
" https://github.com/junegunn/vim-plug/wiki/faq#automatic-installation

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" General
if has('nvim')
  Plug 'Shougo/deoplete.nvim'      , { 'do': ':UpdateRemotePlugins' }
  Plug 'carlitux/deoplete-ternjs'  , { 'do': 'npm i -g tern' }
  Plug 'steelsojka/deoplete-flow'  , { 'do': 'npm i -g flow-bin' }
else
  Plug 'Valloric/YouCompleteMe'    , { 'do': './install.py --tern-completer' }
  Plug 'flowtype/vim-flow'         , { 'for': ['javascript'], 'do': 'npm i -g flow-bin' }
endif
Plug 'ternjs/tern_for_vim'         , { 'for': ['javascript'], 'do': 'npm i', 'on': [] }
Plug 'SirVer/ultisnips'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/fzf'                , { 'dir': '~/.fzf', 'do': 'yes \| ./install --all' } | Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mattn/emmet-vim'             , { 'for': ['html', 'htmldjango', 'jinja', 'jinja2', 'twig'] }
Plug 'dyng/ctrlsf.vim'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'wincent/terminus'
Plug 'junegunn/vim-easy-align'     , { 'on': ['<Plug>(EasyAlign)'] }
Plug 'moll/vim-bbye'
Plug 'mbbill/undotree'             , { 'on': ['UndotreeToggle'] }
Plug 'duggiefresh/vim-easydir'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/vim-peekaboo'
Plug 'tpope/vim-obsession'
Plug 'kshenoy/vim-signature'
Plug 'scrooloose/nerdtree'         , { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'wincent/pinnacle'
Plug 'wincent/loupe'
Plug 'jaawerth/nrun.vim'
Plug 'brooth/far.vim'

" Syntax
Plug 'kewah/vim-stylefmt'          , { 'on':  ['Stylefmt', 'StylefmtVisual'] }
Plug 'sheerun/vim-polyglot'
Plug 'moll/vim-node'               , { 'for': ['javascript'] }
Plug 'ap/vim-css-color'            , { 'for': ['css', 'sass', 'scss', 'less', 'stylus'] }
Plug 'stephenway/postcss.vim'      , { 'for': ['css'] }
" Plug 'the-lambda-church/merlin'    , { 'for': ['ocaml', 'reason'] }

" Linters & Code quality
Plug 'editorconfig/editorconfig-vim' , { 'on': [] }
Plug 'benekastah/neomake'          , { 'do': 'npm i -g flow-vim-quickfix' }

" Themes, UI & eye cnady
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'ahmedelgabri/one-dark.vim'
Plug 'joshdick/onedark.vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'romainl/flattened' " Solarized, without the bullshit.
Plug 'w0ng/vim-hybrid'
Plug 'chriskempson/base16-vim'
Plug 'atelierbram/Base2Tone-vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'
Plug 'lambdalisue/vim-gista'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'             , { 'on': 'GV' }

call plug#end()

syntax enable
filetype plugin indent on
"
" Load matchit.vim, but only if the user hasn't installed a newer version.
" https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim#L88
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Plugins settings
"================================================================================
let g:deoplete#enable_at_startup = 1

" Tab completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Github Auth for Gists
let g:gista#client#default_username = $GITHUB_USER
let g:gista#command#post#allow_empty_description = 1
let g:gista#command#post#interactive_description = 0

function! s:on_GistaPost() abort
  let gistid = g:gista#avars.gistid
  execute printf('Gista browse --gistid=%s', gistid)
endfunction
augroup my_vim_gista_autocmd
  autocmd! *
  autocmd User GistaPost call s:on_GistaPost()
augroup END

let g:github_user = $GITHUB_USER
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1
let g:gist_get_multiplefile = 1

" Overrrides
" =================
let s:vimrc_local = $HOME . '/.vimrc.local'
if filereadable(s:vimrc_local)
  execute 'source ' . s:vimrc_local
endif

" Project specific override
" =========================
let s:vimrc_project = $PWD . '/.local.vim'
if filereadable(s:vimrc_project)
  execute 'source ' . s:vimrc_project
endif


