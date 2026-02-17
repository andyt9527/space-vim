function! spacevim#cache#init() abort
  let l:topic_base = g:spacevim.base."/layers"
  let l:topics_dir = split(globpath(l:topic_base, '*'), '\n')
  let l:topics_path = filter(l:topics_dir, 'isdirectory(v:val)')

  let l:topic2layers = {}
  let g:spacevim.manifest = {}
  for l:topic in l:topics_path
    let l:t_k = fnamemodify(l:topic, ":t")
    let l:layers = split(globpath(l:topic, '*'), '\n')
    let l:lys = deepcopy(l:layers)
    let l:layer_name = map(l:lys, 'fnamemodify(v:val, ":t")')
    let l:topic2layers[l:t_k] = l:layer_name

    for l:layer in l:layers
      let l:l_k = fnamemodify(l:layer, ":t")
      let g:spacevim.manifest[l:l_k] = {'dir': l:layer}
    endfor
  endfor

  let g:spacevim.topics = l:topic2layers

  let l:private_base = g:spacevim.base."/private"
  let l:private_dir = split(globpath(l:private_base, '*'), '\n')
  let l:private_path = filter(l:private_dir, 'isdirectory(v:val)')

  let s:cache = g:spacevim.info
  call writefile([printf("let g:spacevim.topics = %s", g:spacevim.topics)], s:cache)
  call writefile([printf("let g:spacevim.manifest = %s", g:spacevim.manifest)], s:cache, "a")
  if len(l:private_path)
    let g:spacevim.private = map(l:private_path, 'fnamemodify(v:val, ":t")')
    call writefile([printf("let g:spacevim.private = %s", g:spacevim.private)], s:cache, "a")
  endif
endfunction
