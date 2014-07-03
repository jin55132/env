set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"My Preferences

colorscheme darkblue
set textwidth=160
set shiftwidth=4 "들여쓰기 간격
set tabstop=4 "탭 간격
"set expandtab "탭을 스페이스로 바꾸어줌
filetype on  " 파일의 종류를 자동으로 인식
set nobackup "백업 파일 생성하지 않음
set sc
set showcmd "현재명령 보이기, r등의 명령 사용시
set ruler "커서가 위치한 열과 행을 표시
set showmode "삽입모드, 명령모드, 블럭모드등의 현재 모드 표시
set ignorecase "검색시 대소문자 구별 하지 않음
syntax on "문법 색상 강조
set hlsearch "검색어 색상 강조
set autoindent "자동 들여쓰기 설정
" set lines=48 columns=90 
set title "제목표시줄에 파일명 표시
set cmdheight=2 "command line의 줄수를 지정한다.
set cindent 
set showmatch "괄호 닫기 할 때 열었던 괄호와 매칭 확인
"set number
set smartindent
set ls=2
set fencs=utf-8,euc-kr,cp949,cp932,euc-jp,shift-jis,big5,latin1,ucs-2le
set nobackup
set noswapfile

if has("gui_running")
	set guifont=Bitstream_Vera_Sans_Mono:h11 "폰트 설정
endif

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
" vim-scripts repos
Bundle 'Command-T'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'perl-support.vim'
Bundle 'OmniCppComplete'
Bundle 'AutoComplPop'
Bundle 'The-NERD-tree'
Bundle 'FindInNERDTree'
Bundle 'fugitive.vim'

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

set autochdir
let NERDTreeChDirMode=2
nnoremap <leader>n :NERDTree .<CR>

nnoremap <F5> :w<CR>:so % <CR>
nnoremap <F3> :set syntax=perl <CR>
nnoremap <F12> :e $MYVIMRC <CR>

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  tab new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction

