scriptencoding utf-8

if g:spacevim.gui

  " 解决菜单栏乱码
  let $LANG = 'zh_CN.UTF-8'
  set langmenu=zh_CN
  source $VIMRUNTIME/delmenu.vim
  source $VIMRUNTIME/menu.vim

  if g:spacevim.os.mac
      set guifont=Source\ Code\ Pro\ for\ Powerline:h12
  endif

endif
