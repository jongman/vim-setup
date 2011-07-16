" vi 호환성 버리기 
set nocompatible 

" pathogen 을 이용해 다른 플러그인들을 로드한다
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on
