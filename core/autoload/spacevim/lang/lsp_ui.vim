if !hlexists('DefinitionNotFound')
  hi DefinitionNotFound ctermbg=196 guibg=#af3f53 ctermfg=249 guifg=#b2b2b2 cterm=bold gui=bold
endif

if !hlexists('NotFoundIcon')
  hi NotFoundIcon ctermfg=196 ctermbg=235 guifg=#292b2e guifg=#f2241f
endif

function! s:say_not_found() abort
  let msg = 'ﯦ  Cannot find declaration to go to'
  let winid = popup_atcursor(msg, {'padding': [0, 1, 0, 1]})
  call setwinvar(winid, '&wincolor', 'DefinitionNotFound')
endfunction

function! spacevim#lang#lsp_ui#NotFound() abort
  call s:say_not_found()
endfunction
