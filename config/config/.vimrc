"定义$VIMFILES变量
if has('unix')
    let $VIMFILES = $HOME.'/.vim'
else
    let $VIMFILES = $VIM.'/vimfiles'
endif

"使用pathogen管理插件
"call pathogen#infect()

" 基础选项"{{{
" ---------------------------------------------------------------------

"设置mapleader键
let mapleader = ","
let g:mapleader = ","

"解决gb编码文件乱码
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

"set clipboard+=unnamed
"set directory=~/tmp,/tmp

"安装了vimcdoc-1.8.0后可以启用中文帮助
set helplang=cn		"设置中文帮助
set encoding=utf-8	"打开uft-8文件不乱码

set history=500		"保留历史记录
set number			"显示行号
set scrolloff=6		"上下可视行数
set magic			"用于正则表达式
set dy=lastline		"尽可能显示更多的行，取代@@显示
set backspace=indent,eol,start	"设置退格删除
set nobackup		"无备份
set showmatch		"显示配对括号
set linespace=2		"行间距
"set mouse=a			"设定在任何模式下鼠标都可用
set nocompatible	"不兼容vi模式
set linebreak		"整词换行
"set textwidth=80	"设置每行80个字符自动换行，加上换行符
"set wrap			"设置自动折行
set whichwrap=b,s,<,>,[,]	"左右光标移动到头时可以自动下移
set autochdir		"自动切换当前目录为当前文件所在的目录

"关闭遇到错误时的声音提示
set noerrorbells
set novisualbell
set vb t_vb=

"代码折叠
":set fdm=marker		"对文中的标志折叠

"记录文件状态
autocmd BufWinLeave * if expand('%') != '' && &buftype == '' | mkview | endif
autocmd BufRead     * if expand('%') != '' && &buftype == '' | silent loadview | endif
"回到上次退出时的行号
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" 搜索时忽略大小写，但在有一个或以上大写字母时仍大小写敏感
set ignorecase
set smartcase

"set incsearch		" 实时搜索
set hlsearch		" 搜索时高亮显示被找到的文本

syntax enable
syntax on					"语法高亮
filetype plugin indent on	"打开文件类型检测

set showtabline=2	"显示标签
set cursorline		"高亮光标所在的行
set background=dark

" 状态栏
set showcmd			"状态栏显示目前所执行的指令
set laststatus=2	"总是显示状态栏status line
set ruler			"在编辑过程中，右下角显示光表位置的状态行
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]	"右下角状态栏信息
set wildmenu		"命令行tab信息列表

set ambiwidth=single
syntax enable

"}}}

" 按键绑定{{{

" 插入模式输入中文完毕回到普通模式时禁用输入法
se imd
au InsertEnter * se noimd
au InsertLeave * se imd
au FocusGained * se imd

"标签
nmap <C-t>   :tabnew<cr>
nmap <C-p>   :tabprevious<cr>
nmap <C-n>   :tabnext<cr>
nmap <C-k>   :tabclose<cr>
nmap <C-Tab> :tabnext<cr> 

noremap <D-M-Left> :tabprevious<cr>
noremap <D-M-Right> :tabnext<cr>

map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

" }}}

" 格式"{{{
" ---------------------------------------------------------------------
set autoindent		"自动缩进
set smartindent		"在一个新的语句块之后的行自动缩进到下一个级别

" 指定文件类型高亮
au BufNewFile,BufRead *.shtml setf html
au BufNewFile,BufRead *.less setf css

" 关于高亮
:let hs_highlight_delimiters=1            " 高亮定界符
:let hs_highlight_boolean=1               " 把True和False识别为关键字
:let hs_highlight_types=1                 " 把基本类型的名字识别为关键字
:let hs_highlight_more_types=1            " 把更多常用类型识别为关键字
:let hs_highlight_debug=1                 " 高亮调试函数的名字
:let hs_allow_hash_operator=1             " 阻止把#高亮为错误

"在切换到 normal,insert,search 模式时使用英文输入法
set noimdisable
set iminsert=0
set imsearch=0

"缩进相关的设置
set ts=4			"tabstop    制表符显示的位宽
set sw=4			"shift/dependencywidth 自动缩进时，缩进尺寸为4个空格
set et				"编辑时将所有tab替换为空格
set smarttab		"删除空格时，不用按4次
set softtabstop=4	" 设置按BackSpace的时候可以一次删除掉4个空格

"用空格表示缩进，而不是制表符
set expandtab

"显示隐藏字符
"set list
"set listchars=tab:"▸-\ 
"set listchars=tab:\|\ ,nbsp:%,trail:
"set listchars=tab:\▸\ ,trail:.,extends:>,precedes:<

"匹配括号的规则，增加针对html的<>
set matchpairs=(:),{:},[:],<:>

" 去除结尾空格
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" 去掉结尾^M
nnoremap <leader>E :%s/

" ---
" 快捷键
" ---
"使用tab/shift+tab键控制缩进
nmap <tab> v>
nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

"}}}

" 语法"{{{
" ---------------------------------------------------------------------

" 打开javascript折叠
let b:javascript_fold=1
" 打开javascript对dom、html和css的支持
let javascript_enable_domhtmlcss=1

"自动补全CSS
":imap <tab> <c-x><c-o> 
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS 

"自动补全括号
":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {}<ESC>i
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap < <><ESC>i
":inoremap > <c-r>=ClosePair('>')<CR>

function ClosePair(char)
if getline('.')[col('.') - 1] == a:char
	return "\<Right>"
	else
		return a:char
	endif
endf
"}}}
