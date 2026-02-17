" Don't disable statusline when floating window is avaliable.
if !spacevim#load('fzf')
  finish
endif

" line number is not neccessary for fuzzy finder
setl laststatus=0 noshowmode noruler nonumber norelativenumber
" Clear the message
echo "\r"
augroup spacevimFZF
  autocmd!
  autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
