" space-vim will use completor.vim for vim8 by default.
if g:spacevim.vim8
  let s:plugins = [
        \ 'maralla/completor.vim',
        \ 'maralla/completor-neosnippet',
        \ ]
else
  let s:plugins = ['lifepillar/vim-mucomplete']
endif

call extend(g:spacevim.plugins, s:plugins)
