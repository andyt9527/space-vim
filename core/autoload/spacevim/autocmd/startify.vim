scriptencoding utf-8

let s:version = 'vim '.v:version
let s:custom_header = [
            \'                                             _',
            \'         ___ _ __   __ _  ___ ___     __   _(_)_ __ ___',
            \'        / __| -_ \ / _- |/ __/ _ \____\ \ / / | -_ - _ \',
            \'        \__ \ |_) | (_| | (_|  __/_____\ V /| | | | | | |',
            \'        |___/ .__/ \__._|\___\___|      \_/ |_|_| |_| |_|',
            \'            |_|',
            \'                  [ space-vim ' . g:spacevim.version . ' ＠' . s:version . ' ]',
            \]

let s:list_order = [
            \ ['   Recent Files:'],
            \ 'files',
            \ ['   Project:'],
            \ 'dir',
            \ ['   Sessions:'],
            \ 'sessions',
            \ ['   Bookmarks:'],
            \ 'bookmarks',
            \ ['   Commands:'],
            \ 'commands',
            \ ]
function! spacevim#autocmd#startify#Init()
  let g:startify_list_order = get(g:, 'startify_list_order', s:list_order)
  let g:startify_custom_header = get(g:, 'startify_custom_header', s:custom_header)
  let g:startify_change_to_vcs_root = get(g:, 'startify_change_to_vcs_root', 1)
endfunction
