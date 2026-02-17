let s:engine = get(g:, 'spacevim_lsp_engine', 'coc')

" Infer executable from the first line
function! spacevim#lang#util#InferExecutable() abort
  " #!/usr/bin/env python
  let l:exe = split(getline(1), ' ')[-1]
  if executable(l:exe)
    return l:exe
  endif
  " #!/bin/sh
  let l:exe = split(getline(1), '/')[-1]
  return executable(l:exe) ? l:exe : ''
endfunction

" coc or vim_lsp
function! s:dispatch(action, ...) abort
  if s:engine == 'coc'
    let cmd = printf('call CocAction("%s")', a:action)
    execute cmd
  endif
  " vim_lsp uses <plug> mappings, handled separately
endfunction

" ================================================
" LSP
" ================================================
function! spacevim#lang#util#FindReferences() abort
  if s:engine == 'coc'
    call CocAction('jumpReferences')
  endif
endfunction

function! spacevim#lang#util#Hover() abort
  if s:engine == 'coc'
    call CocAction('doHover')
  endif
endfunction

function! spacevim#lang#util#Rename() abort
  if s:engine == 'coc'
    call CocAction('rename')
  endif
endfunction

function! s:DocumentSymbolsCb(error, response) abort
  if getpos('.') != s:old_pos_on_request
    return
  endif
  if empty(a:error)
    if !a:response
      call spacevim#lang#lsp_ui#NotFound()
    endif
  else
    call spacevim#util#err('fail to get Document Symbols via coc')
  endif
endfunction

function! spacevim#lang#util#DocumentSymbol() abort
  if s:engine == 'coc'
    call CocActionAsync('documentSymbols', function('s:DocumentSymbolsCb'))
    let s:old_pos_on_request = getpos('.')
  endif
endfunction

function! spacevim#lang#util#WorkspaceSymbol() abort
  if s:engine == 'coc'
    call CocAction('workspaceSymbols')
  endif
endfunction

function! spacevim#lang#util#Format() abort
  if s:engine == 'coc'
    call CocActionAsync('format')
  elseif exists(':RustFmt')
    RustFmt
  elseif exists(':Autoformat')
    Autoformat
  elseif exists(':ALEFix')
    ALEFix
  endif
endfunction

function! spacevim#lang#util#CodeAction() abort
  if s:engine == 'coc'
    call CocAction('codeLensAction')
  endif
endfunction

function! spacevim#lang#util#DiagnosticPrevious(type) abort
  if s:engine == 'coc'
    call CocAction('diagnosticPrevious')
    return
  endif
  ALEPreviousWrap
endfunction

function! spacevim#lang#util#DiagnosticNext() abort
  if s:engine == 'coc'
    call CocAction('diagnosticNext')
  endif
  ALENextWrap
endfunction

function! s:DefinitionCb(error, response) abort
  if empty(a:error)
    if !a:response && getpos('.') == s:old_pos_on_request
      call spacevim#lang#lsp_ui#NotFound()
    endif
  else
    call spacevim#util#err('fail to go to definition via coc')
  endif
endfunction

" ---------------------------------------------
" goto
" ---------------------------------------------
function! spacevim#lang#util#Definition() abort
  if &filetype ==# 'vim'
    call spacevim#lang#vim#Goto()
    return
  endif

  if s:engine == 'coc'
    call CocActionAsync('jumpDefinition', function('s:DefinitionCb'))
    let s:old_pos_on_request = getpos('.')
  endif
endfunction

function! spacevim#lang#util#TypeDefinition() abort
  if s:engine == 'coc'
    call CocAction('jumpTypeDefinition')
  endif
endfunction

function! spacevim#lang#util#Implementation() abort
  if s:engine == 'coc'
    call CocAction('jumpImplementation')
  endif
endfunction
