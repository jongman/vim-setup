" [F5] Make, [F4] Next Error [Shift+F4] Previous Error
map <F5> <ESC>:w<CR>:make!<CR>
if !filereadable("Makefile") && !filereadable("makefile")
	set makeprg=echo\ 'g++\ -g\ %';g++\ -g\ %
endif
