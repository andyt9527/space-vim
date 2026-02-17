"                                           _
"       ___ _ __   __ _  ___ ___     __   _(_)_ __ ___
"      / __| -_ \ / _- |/ __/ _ \____\ \ / / | -_ - _ \
"      \__ \ |_) | (_| | (_|  __/_____\ V /| | | | | | |
"      |___/ .__/ \__._|\___\___|      \_/ |_|_| |_| |_|
"          |_|
"
"   Copyright (c) 2017 Liu-Cheng Xu & Contributors
"
"   You can customize space-vim with .vimrc.bundle
"   and don't have to take care of this file.
"
"   Author: Liu-Cheng Xu <xuliuchengxlc@gmail.com>
"   URL: https://github.com/liuchengxu/space-vim
"   License: MIT

scriptencoding utf-8

let g:spacevim = get(g:, 'spacevim', {})
let g:spacevim.base = fnamemodify(resolve(expand('<sfile>:p')),':h')
let g:spacevim.version = '0.9.0'

" Identify platform
let g:spacevim.os = {}
let g:spacevim.os.mac = has('macunix')
let g:spacevim.os.linux = has('unix') && !has('macunix')

let &runtimepath = &runtimepath . ',' . g:spacevim.base . '/core'

call spacevim#bootstrap()
