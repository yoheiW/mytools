" coding setting
syntax on

set number
set showtabline=2
set laststatus=2

set expandtab
set shiftwidth=4
set softtabstop=4

" mouse
"set mouse=a

" tab keymap
nnoremap tn :tabn<cr>
nnoremap tp :tabp<cr>

" vimdiff coler
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

if &compatible
  set nocompatible               " Be iMproved
endif

" dein setting

" Required:
set runtimepath+=$HOME/.vim/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$HOME/.vim')
  call dein#begin('$HOME/.vim')

  " Let dein manage dein
  " Required:
  call dein#add('$HOME/.vim/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimproc', {'build' : 'make'})
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/neocomplete.vim')

  call dein#add('scrooloose/nerdtree')
  call dein#add('jistr/vim-nerdtree-tabs')

  call dein#add('nathanaelkane/vim-indent-guides')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

"" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif


" pugin settings

""  vim-indent-guides
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_start_level = 1

"" vimshell
"vs シェルを起動
nnoremap <silent> 'v :VimShellTab<CR>
"vs ウインドウを分割してシェルを起動
nnoremap <silent> 's :VimShellPop<CR>
let g:vimshell_split_command="tabnew"

""  NERDTree
let NERDTreeShowHidden = 1
"let g:nerdtree_tabs_open_on_console_startup = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"autocmd vimenter * NERDTree
command Tree NERDTreeToggle
"nnoremap <silent><C-t> :Tree<CR>

"" vim setting

"" change status bar color by mode
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  echo a:mode
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

if has('unix') && !has('gui_running')
  " ESC後にすぐ反映されない対策
  inoremap <silent> <ESC> <ESC>
endif
