let s:termbufs = get(s:, 'termbufs', [])

" terminal buffer is async inherently.
" opts: dict, {'cmd':, 'cwd':}
function! spacevim#vim#term#Open(opts) abort

  " close terminal buffer whose job has finished
  let winrestcmd = winrestcmd()

  for termbuf in s:termbufs
    if index(term_list(), termbuf) isnot# -1
          \ && bufloaded(termbuf)
          \ && job_status(term_getjob(termbuf)) ==# 'dead'
      silent execute termbuf . 'bwipeout!'
    endif
  endfor

  execute winrestcmd

  execute 'vertical belowright new'
  setlocal
    \ nonumber
    \ norelativenumber
    \ nolist
    \ nowrap
    \ nopaste
    \ nomodeline
    \ noswapfile
    \ nocursorline
    \ nocursorcolumn
    \ winfixwidth
    \ winfixheight
    \ colorcolumn=
    \ nobuflisted
    \ buftype=nofile
    \ bufhidden=unload
  setlocal listchars+=trail:\ 

  let cmd = get(a:opts, 'cmd', '')
  if empty(cmd)
    return
  endif

  let cwd = get(a:opts, 'cwd', getcwd())

  execute 'lcd' cwd
  let bufnr = term_start(cmd, {
        \ 'curwin': 1,
        \})
  call add(s:termbufs, bufnr)

  nnoremap <silent> q :q<CR>

  wincmd p
  redraw!
endfunction

" Run cmd in terminal buffer
" e.g., call spacevim#vim#term#Run('git', 'status')
function! spacevim#vim#term#Run(...) abort
  " a:000 ['git', 'status']
  call spacevim#vim#term#Open({'cmd': a:000})
endfunction

" http://vim.wikia.com/wiki/List_loaded_scripts
" https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
function! spacevim#vim#term#System(cmd)
  for win in range(1, winnr('$'))
    if getwinvar(win, 'scratch')
      execute win . 'windo close'
    endif
  endfor
  if a:cmd =~# '^!'
    execute "let output = system('" . substitute(a:cmd, '^!', '', '') . "')"
  else
    redir => output
    execute a:cmd
    redir END
  endif
  vnew
  let w:scratch = 1
  setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
  call setline(1, split(output, "\n"))
endfunction
