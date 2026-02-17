function! s:coc() abort
  MP 'neoclide/coc.nvim', { 'branch': 'release' }

  call timer_start(200, function('spacevim#plug#coc#Init'))

  " Load these two plugins in core/ftplugin/vim.vim
  MP 'Shougo/neco-vim',   { 'on': [] }
  MP 'neoclide/coc-neco', { 'on': [] }
endfunction

function! s:vim_lsp() abort
  MP 'prabirshrestha/async.vim'
  MP 'prabirshrestha/vim-lsp'
  MP 'mattn/vim-lsp-settings'
  if spacevim#load('ale')
    MP 'rhysd/vim-lsp-ale'
  endif
endfunction

" Default to coc.nvim, can be overridden to use vim_lsp
let g:spacevim_lsp_engine = get(g:, 'spacevim_lsp_engine', 'coc')

call s:{g:spacevim_lsp_engine}()
