" Tagbar and Gutentags require Exuberant Ctags or Universal Ctags
" BSD ctags (macOS default) will NOT work

" Try to find the correct ctags executable
if executable('uctags')
  let g:tagbar_ctags_bin = 'uctags'
  let g:gutentags_ctags_executable = 'uctags'
elseif executable('ctags-exuberant')
  let g:tagbar_ctags_bin = 'ctags-exuberant'
  let g:gutentags_ctags_executable = 'ctags-exuberant'
elseif executable('/opt/homebrew/bin/ctags')
  " macOS Homebrew on Apple Silicon
  let g:tagbar_ctags_bin = '/opt/homebrew/bin/ctags'
  let g:gutentags_ctags_executable = '/opt/homebrew/bin/ctags'
elseif executable('/usr/local/bin/ctags')
  " macOS Homebrew on Intel
  let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
  let g:gutentags_ctags_executable = '/usr/local/bin/ctags'
endif

" Check if we have a working ctags
if !exists('g:tagbar_ctags_bin')
  echohl WarningMsg
  echom '[space-vim] BSD ctags detected. Tagbar/Gutentags require Universal Ctags.'
  echom '[space-vim] Please install: brew install universal-ctags'
  echohl None
endif
