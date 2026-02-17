# space-vim (Streamlined)

一个精简、高效的 [space-vim](https://github.com/liuchengxu/space-vim) 分支，专注于 **Vim 8+** 和 **macOS/Linux** 平台。

## 与原版的区别

| 特性 | 原版 space-vim | 本分支 |
|------|---------------|--------|
| Vim 版本 | Vim 7.4+ / NeoVim | **仅 Vim 8+** |
| 平台 | Windows/macOS/Linux | **仅 macOS/Linux** |
| Layer 数量 | 47+ 个 | **~20 个核心 Layer** |
| LSP 支持 | 多种后端 | **统一使用 coc.nvim** |
| 配置文件 | `.spacevim` | **`.vimrc.bundle`** |
| 插件数量 | 较多 | **精简优化** |

## 系统要求

- **Vim 8.0+** with `+job` support (`exists('*job_start')`)
- **macOS** 或 **Linux** (Ubuntu/Debian 等)
- **Git**, **curl**
- **Universal Ctags** (必需，不是 BSD ctags 或 Exuberant Ctags)

## 快速安装

```bash
# 克隆仓库
git clone https://github.com/andyt9527/space-vim.git ~/.vim
cd ~/.vim

# 安装 vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 创建配置文件链接
ln -sf ~/.vim/init.vim ~/.vimrc
ln -sf ~/.vim/init.spacevim ~/.vimrc.bundle

# 安装插件
vim +PlugInstall +qall
```

## 默认启用的 Layer

编辑 `~/.vimrc.bundle` 来自定义启用的 layer：

```vim
let g:spacevim_layers = [
    \ 'fzf',           " Fuzzy finder
    \ 'better-defaults', " Enhanced defaults
    \ 'which-key',     " Key binding popup
    \ 'c-c++',         " C/C++ support
    \ 'python',        " Python support
    \ 'markdown',      " Markdown support
    \ 'lsp',           " LSP via coc.nvim
    \ 'syntax-checking', " ALE linting
    \ 'programming',   " Programming tools
    \ 'editing',       " Editing enhancements
    \ 'git',           " Git integration
    \ 'file-manager',  " File manager
    \ ]
```

### 可用 Layer 列表

```
+distributions/
  better-defaults    - 增强的 Vim 默认配置
  
+lang/
  c-c++              - C/C++ 开发支持
  python             - Python 开发支持
  markdown           - Markdown 编辑与预览

+tools/
  fzf                - Fuzzy finder 集成
  ctags              - Tag 导航 (gutentags + tagbar)
  lsp                - LSP 支持 (coc.nvim)
  tmux               - Tmux 集成

+checkers/
  syntax-checking    - 语法检查 (ALE)

+programming/
  programming        - 通用编程工具
  editing            - 编辑增强

+version-control/
  git                - Git 集成 (fugitive, gitsigns)

+themes/
  airline            - 状态栏美化
  colors             - 配色方案

+completion/
  coc                - 自动补全 (作为 LSP 引擎)

+vim/
  better-motion      - 移动增强
  text-objects       - 文本对象

+misc/
  chinese            - 中文支持 (GUI 字体)
```

## 关键依赖

### Universal Ctags (必需)

space-vim 的 Tagbar 和 Gutentags 需要 **Universal Ctags**，系统自带的 BSD ctags (macOS) 或 exuberant-ctags 不兼容。

**macOS:**
```bash
brew install universal-ctags
```

**Ubuntu/Debian:**
```bash
# 从源码安装
git clone https://github.com/universal-ctags/ctags.git /tmp/ctags
cd /tmp/ctags
./autogen.sh && ./configure && make && sudo make install
```

### fzf

macOS 和 Linux 都会自动安装。

### Node.js (用于 coc.nvim)

coc.nvim 需要 Node.js 环境：

```bash
# macOS
brew install node

# Ubuntu/Debian
sudo apt-get install nodejs npm
```

## 核心快捷键

**Leader 键:** `Space`

| 快捷键 | 功能 |
|--------|------|
| `SPC ?` | 显示所有快捷键 |
| `SPC f f` | 查找文件 (fzf) |
| `SPC b b` | 缓冲区列表 |
| `SPC p s` | 项目中搜索 (ripgrep) |
| `SPC g s` | Git 状态 |
| `SPC t t` | 切换 Tagbar |
| `SPC l a` | LSP Code Action |
| `SPC l d` | LSP 跳转到定义 |
| `SPC l r` | LSP 重命名 |
| `, c p` | Markdown 预览 |
| `Ctrl+h/j/k/l` | 窗口/Tmux 导航 |

## 自定义配置

编辑 `~/.vimrc.bundle`：

```vim
" 添加自定义 layer
let g:spacevim_layers = [
    \ 'fzf', 'better-defaults', 'which-key',
    \ 'c-c++', 'python', 'markdown',
    \ 'lsp', 'syntax-checking',
    \ ]

" 启用真彩色 (需要终端支持)
let g:spacevim_enable_true_color = 1

" 启用 Nerd Font (如果有安装)
let g:spacevim_nerd_fonts = 1

" 添加自定义插件
function! UserInit()
    Plug 'tpope/vim-surround'
endfunction

" 覆盖默认设置
function! UserConfig()
    set norelativenumber
    let g:airline_powerline_fonts = 1
endfunction
```

## LSP 配置

space-vim 使用 **coc.nvim** 作为 LSP 引擎。安装语言服务器：

```vim
:CocInstall coc-clangd      " C/C++
:CocInstall coc-pyright     " Python
:CocInstall coc-json        " JSON
:CocInstall coc-yaml        " YAML
```

或使用 `:CocConfig` 配置 `coc-settings.json`：

```json
{
  "clangd.path": "/usr/bin/clangd",
  "python.analysis.typeCheckingMode": "basic"
}
```

## 故障排除

### Tagbar 显示空白

确保安装了 Universal Ctags：
```bash
ctags --version  # 应显示 "Universal Ctags"
```

### 鼠标滚动问题

如果鼠标点击后光标卡在屏幕中央，检查：
```vim
:set scrolloff?  " 应为 3 (不是 999)
```

### 插件安装失败

```bash
# 手动重新安装
vim +PlugInstall +qall

# 或更新插件
vim +PlugUpdate +qall
```

### coc.nvim 无法启动

检查 Node.js 版本（需要 14.14+）：
```bash
node --version
```

## 更新

```bash
cd ~/.vim
git pull
vim +PlugUpdate +qall
```

## 致谢

- 基于 [space-vim](https://github.com/liuchengxu/space-vim) by Liu-Cheng Xu
- 受 [spacemacs](https://github.com/syl20bnr/spacemacs) 启发
- 使用 [vim-plug](https://github.com/junegunn/vim-plug) 管理插件

## License

MIT License
