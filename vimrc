" vi 호환성 버리기
set nocompatible

" pathogen 을 이용해 다른 플러그인들을 로드한다
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" 탭 세팅
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" 검색 설정
set ignorecase " 대소문자 무시하지만..
set smartcase " 검색어에 대소문자 섞여 있는 경우엔 존중해드림
set gdefault " 기본으로 한 줄에서 여러개도 replace
set incsearch
set showmatch
set hlsearch " 검색 결과를 하이라이트한다.
nmap <silent> <leader><space> :nohlsearch<cr>
" 탭으로 matching brackets 사이를 오가기
nnoremap <tab> %
vnoremap <tab> %
" 라인 랩 관련 설정
set wrap
set textwidth=0 " 니맘대로 줄바꿈하지마 ㄱㅅㄲ야
nnoremap j gj
nnoremap k gk
" : 대신 ; 를 치자
nnoremap ; :
" 인덴트. ai 만 우선 켠다.
set autoindent
" 포커스를 잃으면 자동 세이브
au FocusLost * :wa
" 파일 인코딩은 언제나 utf-8. 안되면 cp949 시도
set encoding=utf8
set fileencodings=utf8,cp949
syntax on " 구문강조
set laststatus=2 " 상태라인 항상 보여주세요
set number " 줄번호 보여 주세여!
"set relativenumber " 절대 줄번호는 중요하지 않아요
set scrolljump=1 " 스크롤은 1줄씩만
set scrolloff=3 " 3줄 남기고 스크롤 설정
set visualbell " 비주얼 벨 써야지여
set cursorline " 커서 위치 보여주세요
set ttyfast " 느리지 않아요 로컬이에요
set ruler " 커서 위치 보여주세요
set backspace=indent,eol,start " 백스페이스 설정
set mouse=a " 마우스 지원
set autochdir " 파일 열면 해당 디렉토리로 chdir
set showmode " 현재 상태 (insert/visualize) 표시.. 이거 디폴트로 안켜있나?
set showcmd " 현재 명령어 (ex 모드) 표시
set hidden " 버퍼가 안보이게 되면 변경 내용 버리기.
set wildmenu " 자동완성시 리스트를 보여준다
set wildmode=list:longest,full
set whichwrap=b,s,h,l,<,>,[,] " 줄 끝에서 다음 줄로 넘어가기 위해 사용할 수 있는 키들

" 난 , 리더키로 쓰는거 정말 싫음. 나만 그런가. -_-;
let mapleader = "\\"

" 리더 커맨드들

" trailing space 전부 없애기: leaderW
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" 이 파일 설정하는거 돕기 ㅋ
nnoremap <leader>sv :so $MYVIMRC<CR>
" 마지막에 붙여넣은 부분 선택하기
nnoremap <leader>v V`]
" 세로 스플릿하고 그리로 가기
nnoremap <leader>w <C-w>v<C-w>l
" 스플릿 사이 옮겨다니기
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 기타 리매핑들
inoremap jj <ESC>
