set nocompatible
set number
set mouse=a
set tabstop=4
set softtabstop=4
set shiftwidth=4
set clipboard+=unnamed
set backspace=2
set scrolloff=3
set guifont=Menlo\ Regular:h16
set smartindent

"nerdtree配置
"==============================
map <F2> :NERDTreeMirror<CR>
map <F2> :NERDTreeToggle<CR>
"==============================



"彩色括号配置
"======================================
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesLoadRound
au VimEnter * RainbowParenthesesLoadSquare
au VimEnter * RainbowParenthesesLoadBraces
au VimEnter * RainbowParenthesesToggle
"=======================================


"配色
"--------------------------
"底部任务栏
let g:onedark_termcolors=256
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
syntax on
colorscheme onedark
"--------------------------

"打开文件类型检测
set completeopt=longest,menu

"ycm配置
"=======================
"python使用路径
let g:ycm_path_to_python_interpreter='/usr/local/Cellar/python@3.8/3.8.6/bin/python3' 
let g:ycm_add_preview_to_completeopt = 0
"自动开启语义补全
"let g:ycm_seed_identifiers_with_syntax = 1
"在注释中也开启补全
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
"关闭语法检查
let g:ycm_show_diagnostics_ui = 0
"Ctrl+z补全
let g:ycm_key_invoke_completion = '<c-z>'
"字符串中也开启补全
let g:ycm_complete_in_strings = 1
"let g:ycm_collect_identifiers_from_tags_files = 1
"自动补全优化
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }

"白名单
let g:ycm_filetype_whitelist = { 
			\ "c":1,
			\ "cpp":1, 
			\ "objc":1,
			\ "sh":1,
			\ "zsh":1,
			\ "zimbu":1,
			\ }
"========================

"括号补全
"========================
"自动配对符号
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"'}

"回车缩进并自动换行，默认1
let g:AutoPairsMapCR = 1
"两端添加括号
let g:AutoPairsMapSpace = 1


"
"========================




"C,C++按F5编译运行
"========================
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -std=c++11 -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
"        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
	endif
endfunc

"========================


"模板、头文件补全
"新建.cpp 自动插入头文件
"===============================
autocmd BufNewFile *.cpp exec ":call Setcpp()" 
func Setcpp()
	call setline(1, "/*************************************************************************") 
	call append(line("."), "	> File Name: ".expand("%")) 
	call append(line(".")+1, "	> Author: Tisen") 
	call append(line(".")+2, "	> Mail: 1600037849@qq.com") 
	call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
	call append(line(".")+4, " ************************************************************************/") 
	call append(line(".")+5, "")
	call append(line(".")+6, "#include<bits/stdc++.h>")
	call append(line(".")+7, "using namespace std;")
	call append(line(".")+8, "#define ll long long")
	call append(line(".")+9, "#define rep(i,n) for(int i = 0; i < int(n); i++)")
	call append(line(".")+10, "#define rep2(i,st,ed) for(int i = int(st); i <= int(ed); i++)")
	call append(line(".")+11, "const ll N = 2e5 + 200;")
	call append(line(".")+12, "const ll INF = 0x3f3f3f3f;")
	call append(line(".")+13, "const ll mod = 1e9 + 7;")
	call append(line(".")+14, "")
	call append(line(".")+15, "")
	call append(line(".")+16, "int main()")
	call append(line(".")+17, "{")
	call append(line(".")+18, '	/*freopen("in.txt","r",stdin);*/')
	call append(line(".")+19, '	/*freopen("out.txt","w",stdout);*/')
	call append(line(".")+20, "")
	call append(line(".")+21, "")
	call append(line(".")+22, "	return 0;")
	call append(line(".")+23, "}")
endfunc
"================================



"vundle 配置
"====================================================
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
"vundle 插件列表必须位于vundle#begin()和vundle#end()之间
if has('python3')
endif
call vundle#begin()
"Plugins Start

"多色括号
Plugin 'kien/rainbow_parentheses.vim'

"底部增强
Plugin 'vim-airline/vim-airline'

"文档树
Plugin 'preservim/nerdtree'

"括号配对
Plugin 'tpope/vim-surround'

"括号补全
Plugin 'jiangmiao/auto-pairs'

"扩展语言包
Plugin 'sheerun/vim-polyglot'


"注释
Plugin 'tpope/vim-commentary'

"vundle依赖
Plugin 'VundleVim/Vundle.vim'

"括号、引号,等符号添加修改删除
""Plugin 'tpope/vim-surround'

"YouCompleteMe 自动补全
Plugin 'Valloric/YouCompleteMe',{'do':'python3 install.py --clang-completer'} 


"Plugins End
call vundle#end()
filetype plugin indent on
"=========================================================

