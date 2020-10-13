set nocompatible
set number
set mouse=a
set tabstop=4
set softtabstop=4
set shiftwidth=4
set clipboard+=unnamed
set backspace=2
set scrolloff=3
syntax on
set guifont=Menlo\ Regular:h14

"默认打开文档树
"autocmd vimenter * NERDTre

"配色
colorscheme onedark

"打开文件类型检测
set completeopt=longest,menu

"ycm配置
"=======================
"python使用路径
let g:ycm_path_to_python_interpreter='/usr/local/Cellar/python@3.8/3.8.6/bin/python3' 
"自动开启语义补全
let g:ycm_seed_identifiers_with_syntax = 1
"在注释中也开启补全
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
"字符串中也开启补全
let g:ycm_complete_in_strings = 1
"let g:ycm_collect_identifiers_from_tags_files = 1
"自动补全优化
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }

"========================

"括号补全
"========================
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap < <><LEFT>

function! RemovePairs()
    let s:line = getline(".")
    let s:previous_char = s:line[col(".")-1]

    if index(["(","[","{"],s:previous_char) != -1
        let l:original_pos = getpos(".")
        execute "normal %"
        let l:new_pos = getpos(".")
        " only right (
        if l:original_pos == l:new_pos
            execute "normal! a\<BS>"
            return
        end

        let l:line2 = getline(".")
        if len(l:line2) == col(".")
            execute "normal! v%xa"
        else
            execute "normal! v%xi"
        end
    else
        execute "normal! a\<BS>"
    end
endfunction

function! RemoveNextDoubleChar(char)
    let l:line = getline(".")
    let l:next_char = l:line[col(".")]

    if a:char == l:next_char
        execute "normal! l"
    else
        execute "normal! i" . a:char . ""
    end
endfunction

inoremap <BS> <ESC>:call RemovePairs()<CR>a
inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a
inoremap > <ESC>:call RemoveNextDoubleChar('>')<CR>a
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




"vundle 配置
"====================================================
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
"vundle 插件列表必须位于vundle#begin()和vundle#end()之间
if has('python3')
endif
call vundle#begin()
"Plugins Start

"底部增强
Plugin 'vim-airline/vim-airline'

"文档树
Plugin 'preservim/nerdtree'

"括号配对
Plugin 'tpope/vim-surround'


"注释
Plugin 'tpope/vim-commentary'

"vundle依赖
Plugin 'VundleVim/Vundle.vim'

"括号、引号,等符号添加修改删除
Plugin 'tpope/vim-surround'

"YouCompleteMe 自动补全
Plugin 'Valloric/YouCompleteMe',{'do':'python3 install.py --clang-completer'} 


"Plugins End
call vundle#end()
filetype plugin indent on
"=========================================================

