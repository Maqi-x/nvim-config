if exists("b:current_syn")
  finish
endif

"""""""""""""""""""" Keywords
syn keyword elashKeyword extern static inline goto case const wonly volatile as global internal
syn keyword elashTypedefKeyword enum union struct typedef alias
syn keyword elashControlFlowKw switch if else while do for break continue return
syn keyword elashBoolean true false
syn keyword elashNull null

"""""""""""""""""""" Preprocessor
syn region  elashPPRegion start=/#/ end=/[\n;]/ keepend contains=elashPPKeyword,elashString,elashChar,elashNumber,elashComment
syn keyword elashPPKeyword include embed pragma annote error warning note emit
syn keyword elashPPKeyword define enddef undef assign deassign inc dec
syn keyword elashPPKeyword if elif else endif while endwhile for foreach endfor contained


"""""""""""""""""""" Literals
syn match  elashEscape /\\./ contained
syn region elashString start=/"/ skip=/\\"/ end=/"/ contains=elashEscape
syn region elashChar start=/'/ skip=/\\'/ end=/'/ contains=elashEscape
syn match  elashNumber /\v<\d+(\.\d+)?>/

"""""""""""""""""""" Comments
syn match  elashComment /\/\/.*/
syn region elashComment start=/\/\*/ end=/\*\//

"""""""""""""""""""" Types
syn keyword elashType int int8 int16 int32 int64 int128
syn keyword elashType uint uint8 uint16 uint32 uint64 uint128
syn keyword elashType float float16 float32 float64 float128
syn keyword elashType void bool char rune usize isize

" very primitive but works
syn match elashCustomType /\v<[A-Z][A-Za-z0-9_]*>/ contains=NONE

"""""""""""""""""""" Operators
syn match elashOperator /[-+*\/%=!<>|&^~]+/
syn match elashDelimiter /[()\[\]{},.;]/
syn match elashFunctionCall /\v<[a-zA-Z_]\w*\ze\s*\(/

"""""""""""""""""""" Highlight links
hi def link elashKeyword Keyword
hi def link elashTypedefKeyword Keyword
hi def link elashControlFlowKw Conditional

hi def link elashType Type
hi def link elashCustomType Structure

hi def link elashBoolean Boolean
hi def link elashNull Constant

hi def link elashString String
hi def link elashChar Character
hi def link elashEscape SpecialChar

hi def link elashNumber Number

hi def link elashComment Comment

hi def link elashFunctionCall Function

hi def link elashOperator Operator
hi def link elashDelimiter Delimiter

" PP
hi def link elashPPRegion PreProc
hi def link elashPPKeyword Keyword

let b:current_syn = "elash"
