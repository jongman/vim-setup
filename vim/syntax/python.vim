" enforce python PEP 0008
let python_slow_sync = 1

if exists("b:current_syntax")
  finish
endif

if !exists("python_highlight_builtins")
    let python_highlight_builtins = 1
endif
if !exists("python_highlight_string_formatting")
    let python_highlight_string_formatting = 1
endif
if !exists("python_highlight_doctests")
    let python_highlight_doctests = 1
endif
if !exists("python_79_char_line_limit")
    let python_79_char_line_limit = 0
endif
if !exists("python_highlight_whitespace")
    let python_highlight_whitespace = 1
endif

" Keywords
syn keyword pythonStatement	break continue del exec return pass
syn keyword pythonStatement	print raise global assert yield
syn keyword pythonStatement	def nextgroup=pythonFunction skipwhite
syn keyword pythonStatement	class nextgroup=pythonClass skipwhite
syn match   pythonFunction	"\h\w*" display contained nextgroup=pythonFuncDecl skipwhite
syn match   pythonClass         "\h\w*" display contained nextgroup=pythonFuncDecl skipwhite
syn keyword pythonRepeat	for while
syn keyword pythonConditional	if elif else
syn keyword pythonImport	import from as
syn keyword pythonException	try except finally
syn keyword pythonOperator	and in is not or lambda for

" Comments
syn match   pythonComment	"#.*$" display contains=pythonTodo
syn match   pythonRun		"\%^#!.*$"
syn match   pythonCoding	"\%^.*\(\n.*\)\?#.*coding[:=]\s*[0-9A-Za-z-_.]\+.*$"
syn keyword pythonTodo		TODO FIXME XXX RFC contained

" when outside of parenthesis, = must have space on either side
syn match pythonUncontainedError "\>=" display
syn match pythonUncontainedError "=[^ =$\\]"me=e-1 display

" erroneous whitespace
if exists("python_highlight_whitespace") && python_highlight_whitespace != 0
  syn match pythonWhiteSpaceError " $" display
  syn match pythonWhiteSpaceError "[^ \t]  \+[^ #]"ms=s+2,me=e-1 display
endif

" illegal characters
syn match pythonError "[@$?\t]" display
syn match pythonError ";\ze *$" display

" erroneous whitespace around operators
syn match pythonError "\.\zs " display
syn match pythonError " [:,]\@=" display

" missing whitespace after operator
syn match pythonError "[<>%]\ze[^ =$\\]" display
syn match pythonError "[<>!+*/%\-]=\ze[^ $\\]" display
"syn match pythonUncontainedError "[*]\ze[^ =$\\]e" display
" comma must be followed by a space
syn match pythonError ",\ze[^ )=$\\]" display

" missing whitespace before operator
syn match pythonError " \@<![<>%]" display
syn match pythonError " \@<![+\-*/=<>!]=" display
"syn match pythonUncontainedError " \@<![*]" display

" deprecated or invalid constructions
syn match pythonError "\<string\.\(join\|split\)" display
"
syn match pythonError "[!=]= \?\(None\|True\|False\|type\>\|dict\>\|list\>\|tuple\>\|str\>\|unicode\>\)" display
syn keyword pythonError throw catch l O I <> elsif

"--contained in parenthesis-- 
" TODO these two need to leave out the actual '='
syn match pythonError " \ze=[^=]" contained containedin=@pythonContainers,pythonFuncDecl
syn match pythonError "=\zs " contained containedin=@pythonContainers,pythonFuncDecl
syn match ok " [!=+/\-*<>]= " contained containedin=@pythonContainers
syn match pythonError "\\" contained containedin=@pythonContainers,pythonFuncDecl


" Strings
syn region pythonString		start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonEscape,pythonEscapeError
syn region pythonString		start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonEscape,pythonEscapeError
syn region pythonString		start=+"""+ end=+"""+ keepend contains=pythonEscape,pythonEscapeError,pythonDocTest2
syn region pythonString		matchgroup=pythonError start=+'''+ end=+'''+ keepend contains=pythonEscape,pythonEscapeError,pythonDocTest


syn match  pythonEscape		+\\[abfnrtv'"\\]+ display contained
syn match  pythonEscapeError	+\\[^abfnrtv'"\\]+ display contained
syn match  pythonEscape		"\\\o\o\=\o\=" display contained
syn match  pythonEscapeError	"\\\o\{,2}[89]" display contained
syn match  pythonEscape		"\\x\x\{2}" display contained
syn match  pythonEscapeError	"\\x\x\=\X" display contained
syn match  pythonEscape		"\\$"

" Unicode strings
syn region pythonUniString	start=+[uU]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError
syn region pythonUniString	start=+[uU]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError
syn region pythonUniString	start=+[uU]"""+ end=+"""+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,pythonDocTest2
syn region pythonUniString	start=+[uU]'''+ end=+'''+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,pythonDocTest

syn match  pythonUniEscape	"\\u\x\{4}" display contained
syn match  pythonUniEscapeError	"\\u\x\{,3}\X" display contained
syn match  pythonUniEscape	"\\U\x\{8}" display contained
syn match  pythonUniEscapeError	"\\U\x\{,7}\X" display contained
syn match  pythonUniEscape	"\\N{[A-Z ]\+}" display contained
syn match  pythonUniEscapeError	"\\N{[^A-Z ]\+}" display contained

" Raw strings
syn region pythonRawString	start=+[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape
syn region pythonRawString	start=+[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape
syn region pythonRawString	start=+[rR]"""+ end=+"""+ keepend contains=pythonDocTest2
syn region pythonRawString	start=+[rR]'''+ end=+'''+ keepend contains=pythonDocTest

syn match pythonRawEscape	+\\['"]+ display transparent contained

" Unicode raw strings
syn region pythonUniRawString	start=+[uU][rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,pythonUniRawEscape,pythonUniRawEscapeError
syn region pythonUniRawString	start=+[uU][rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,pythonUniRawEscape,pythonUniRawEscapeError
syn region pythonUniRawString	start=+[uU][rR]"""+ end=+"""+ keepend contains=pythonUniRawEscape,pythonUniRawEscapeError,pythonDocTest2
syn region pythonUniRawString	start=+[uU][rR]'''+ end=+'''+ keepend contains=pythonUniRawEscape,pythonUniRawEscapeError,pythonDocTest

syn match  pythonUniRawEscape		"\([^\\]\(\\\\\)*\)\@<=\\u\x\{4}" display contained
syn match  pythonUniRawEscapeError	"\([^\\]\(\\\\\)*\)\@<=\\u\x\{,3}\X" display contained

if exists("python_highlight_string_formatting") && python_highlight_string_formatting != 0
  " String formatting
  syn match pythonStrFormat	"%\(([^)]\+)\)\=[-#0 +]*\d*\(\.\d\+\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonUniString,pythonRawString
  syn match pythonStrFormat	"%[-#0 +]*\(\*\|\d\+\)\=\(\.\(\*\|\d\+\)\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonUniString,pythonRawString
endif

if exists("python_highlight_doctests") && python_highlight_doctests != 0
  " DocTests
  syn region pythonDocTest	start="^\s*>>>" end=+'''+he=s-1 end="^\s*$" contained
  syn region pythonDocTest2	start="^\s*>>>" end=+"""+he=s-1 end="^\s*$" contained
endif

" Numbers (ints, longs, floats, complex)
syn match   pythonNumber	"\<0[xX]\x\+[lL]\=\>" display
syn match   pythonNumber	"\<\d\+[lLjJ]\=\>" display
syn match   pythonFloat		"\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>" display
syn match   pythonFloat		"\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
syn match   pythonFloat		"\<\d\+\.\d*\([eE][+-]\=\d\+\)\=[jJ]\=" display
syn match   pythonOctalError	"\<0\o*[89]\d*[lLjJ]\=\>" display


syn keyword pythonBuiltinObj	True False Ellipsis None NotImplemented

if exists("python_highlight_builtins") && python_highlight_builtins != 0
  " Builtin functions, types and objects, not really part of the syntax
  syn keyword pythonBuiltinFunc	__import__ abs all any apply
  syn keyword pythonBuiltinFunc	basestring bool buffer callable
  syn keyword pythonBuiltinFunc	chr classmethod cmp coerce compile complex
  syn keyword pythonBuiltinFunc	delattr dict dir divmod enumerate eval
  syn keyword pythonBuiltinFunc	execfile file filter float frozenset getattr
  syn keyword pythonBuiltinfunc globals hasattr hash help hex id 
  syn keyword pythonBuiltinFunc	input int intern isinstance
  syn keyword pythonBuiltinFunc	issubclass iter len list locals long map max
  syn keyword pythonBuiltinFunc	min object oct open ord pow property range
  syn keyword pythonBuiltinFunc	raw_input reduce reload repr
  syn keyword pythonBuiltinFunc reversed round set setattr
  syn keyword pythonBuiltinFunc	slice sorted staticmethod str sum super tuple
  syn keyword pythonBuiltinFunc	type unichr unicode vars xrange zip
endif

" don't match builtins if they are methods
syn match ok "\.\h\w*"

" container regions
syn region pythonFuncDecl       matchgroup=pythonFuncDeclParens start="(" end=")" contained contains=@pythonExpression,pythonFuncDeclError,@pythonContainers
syn region Parenthesis		matchgroup=pythonParens start="(" end=")" matchgroup=pythonError end="[}\]]" contains=@pythonExpression,@pythonContainers
syn region BlockParens		start="\[" end="\]" matchgroup=pythonError end="[)}]" contains=@pythonExpression,@pythonContainers
syn region CurlyParens		start="{" end="}" matchgroup=pythonError end="[\])]" contains=@pythonExpression,@pythonContainers
syn cluster pythonContainers    contains=Parenthesis,BlockParens,CurlyParens
syn cluster pythonExpression    contains=pythonOperator,pythonString,pythonUniString,pythonRawString,pythonUniRawString,pythonNumber,pythonFloat,pythonOctalError,pythonBuiltinObj,pythonBuiltinFunc,pythonError,pythonComment,pythonWhiteSpaceError
syn match pythonFuncDeclError "{}" contained containedin=pythonFuncDecl display
syn match pythonFuncDeclError "\[]" contained containedin=pythonFuncDecl display
syn match pythonUncontainedError "[\]})]"

syn match pythonError "\[\@<= "
syn match pythonError "(\@<= "
syn match pythonError "{\@<= "
"syn match pythonError " \ze[)\]}]"

"syn region pythonIndent matchgroup=pythonConditional start="[ ^]if " end="\ze: *[#$]" matchgroup=pythonError end=".$" contains=@pythonExpression

if exists("python_slow_sync") && python_slow_sync != 0
  syn sync minlines=2000
else
  " This is fast but code inside triple quoted strings screws it up. It
  " is impossible to fix because the only way to know if you are inside a
  " triple quoted string is to start from the beginning of the file.
  syn sync match pythonSync grouphere NONE "):$"
  syn sync maxlines=200
endif

if exists("python_79_char_line_limit") && python_79_char_line_limit != 0
  "syn region LineTooLong start="\%80c" end="$" excludenl containedin=ALL
  " THIS IS TOO SLOW!
  syn match LineTooLong -\%>79c[^{([\])}'"]\+- containedin=ALL display
endif

if version >= 508 || !exists("did_python_syn_inits")
  if version <= 508
    let did_python_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink pythonStatement	Statement
  HiLink pythonImport		Include
  HiLink pythonFunction		Function
  HiLink pythonClass		Function
  HiLink pythonConditional	Conditional
  HiLink pythonRepeat		Repeat
  HiLink pythonException	Exception
  HiLink pythonOperator		Operator

  HiLink pythonComment		Comment
  HiLink pythonCoding		Special
  HiLink pythonRun		Special
  HiLink pythonTodo		Todo
  
  HiLink pythonUncontainedError Error
  HiLink pythonError		Error

  HiLink pythonString		String
  HiLink pythonUniString	String
  HiLink pythonRawString	String
  HiLink pythonUniRawString	String

  HiLink pythonEscape			Special
  HiLink pythonEscapeError		Error
  HiLink pythonUniEscape		Special
  HiLink pythonUniEscapeError		Error
  HiLink pythonUniRawEscape		Special
  HiLink pythonUniRawEscapeError	Error

  HiLink LineTooLong            Error
  if exists("python_highlight_whitespace") && python_highlight_whitespace != 0
    HiLink pythonWhiteSpaceError  Error
  endif
  HiLink pythonFuncDeclError    Error
  HiLink pythonFuncDeclParens   Special
  HiLink pythonParens           Special

  if exists("python_highlight_string_formatting") && python_highlight_string_formatting != 0
    HiLink pythonStrFormat	Special
  endif

  if exists("python_highlight_doctests") && python_highlight_doctests != 0
    HiLink pythonDocTest	Special
    HiLink pythonDocTest2	Special
  endif

  HiLink pythonNumber		Number
  HiLink pythonFloat		Float
  HiLink pythonOctalError	Error

  if exists("python_highlight_builtins") && python_highlight_builtins != 0
    HiLink pythonBuiltinObj	Structure
    HiLink pythonBuiltinFunc	Function
  endif

  delcommand HiLink
endif

let b:current_syntax = "python"
