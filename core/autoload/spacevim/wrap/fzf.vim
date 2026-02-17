" ----------------------------------------------
" fzf wrapper functions
" ----------------------------------------------
function! s:ensure_fzf() abort
  if !exists('g:loaded_fzf')
    call plug#load('fzf', 'fzf.vim')
  endif
endfunction

function! spacevim#wrap#fzf#File() abort
  call s:ensure_fzf()
  Files
endfunction

function! spacevim#wrap#fzf#Buffers() abort
  call s:ensure_fzf()
  call spacevim#plug#fzf_base#buffers()
endfunction

function! spacevim#wrap#fzf#BLines() abort
  call s:ensure_fzf()
  BLines
endfunction

function! spacevim#wrap#fzf#BLinesAll() abort
  call s:ensure_fzf()
  Lines
endfunction

function! spacevim#wrap#fzf#Files() abort
  call s:ensure_fzf()
  Files ~
endfunction

function! spacevim#wrap#fzf#Rtp() abort
  call spacevim#plug#fzf#Rtp()
endfunction
