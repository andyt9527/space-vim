let g:spacevim#map#manager#quick_open = [
        \ '~/.vimrc.bundle',
        \ g:spacevim.base.'/init.vim',
        \ '~/.bashrc',
        \ '~/.zshrc',
        \ '~/.tmux.conf',
        \ ]

function! spacevim#map#manager#Buffers() abort
  call spacevim#wrap#fzf#Buffers()
endfunction

function! spacevim#map#manager#Files() abort
  call spacevim#wrap#fzf#Files()
endfunction

function! spacevim#map#manager#BufTags() abort
  if exists(':BTags')
    if !exists('g:loaded_fzf')
      call plug#load('fzf', 'fzf.vim')
    endif
    BTags
  else
    call spacevim#util#err('No avaliable tool for opening buffer tags')
  endif
endfunction

function! spacevim#map#manager#BLines() abort
  call spacevim#wrap#fzf#BLines()
endfunction

function! spacevim#map#manager#BLinesAll() abort
  call spacevim#wrap#fzf#BLinesAll()
endfunction

function! spacevim#map#manager#BufCword() abort
  call spacevim#plug#fzf#SearchBcword()
endfunction

function! spacevim#map#manager#RgCword() abort
  call spacevim#plug#fzf#RgCursorWord()
endfunction

function! spacevim#map#manager#Rg() abort
  Rg
endfunction

function! spacevim#map#manager#CommandHistory() abort
  History:
endfunction

function! spacevim#map#manager#SearchRecently() abort
  History
endfunction

function! s:TryAddFile(base, items) abort
  let base = a:base
  let items = type(a:items) == v:t_list ? a:items : [a:items]
  for item in items
    if filereadable(expand(item))
      return add(base, item)
    endif
  endfor
  return base
endfunction

function! s:QuickOpenSource() abort
  let quick_open = copy(g:spacevim#map#manager#quick_open)
  if g:spacevim.os.linux
    let quick_open = s:TryAddFile(quick_open, ['~/.alacritty.yml', '~/.config/alacritty/alacritty.yml'])
    let quick_open = s:TryAddFile(quick_open, '~/.config/kitty/kitty.conf')
  endif
  return quick_open
endfunction

function! spacevim#map#manager#QuickOpen() abort
  if exists(':FZF')
    call spacevim#plug#fzf#Open()
  else
    call spacevim#util#err('No avaliable tool for quick open')
  endif
endfunction

function! spacevim#map#manager#FindFiles() abort
  call spacevim#plug#fzf#FindFileInProject()
endfunction
