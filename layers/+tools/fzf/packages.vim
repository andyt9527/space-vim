if g:spacevim.speed_up_via_timer
  MP 'junegunn/fzf',  { 'dir': '~/.fzf', 'do': function('spacevim#VimPlugPostUpdateHook', [v:false, './install --all']), 'on': [] }
  MP 'junegunn/fzf.vim', { 'on': [] }
  call timer_start(700, 'spacevim#defer#fzf')
else
  MP 'junegunn/fzf',  { 'dir': '~/.fzf', 'do': function('spacevim#VimPlugPostUpdateHook', [v:false, './install --all']) }
  MP 'junegunn/fzf.vim'
endif
