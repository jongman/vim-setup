autocmd BufWritePost,FileWritePost *.coffee :silent !coffee -c <afile>
set autoread " js 파일 자동으로 리로드
