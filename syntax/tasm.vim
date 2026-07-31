if exists("b:current_syntax")
  finish
endif


" --- Keywords & Opcodes ---
syn case ignore
syn keyword tasmKeyword     if
syn keyword tasmRegister    raz rcf rip rsp
syn keyword tasmOpcodeNoOp  nop halt
syn keyword tasmOpcodeMove  in out load store din iout dload istore push pop set
syn keyword tasmOpcodeArith min max rot shl shr not neg add sub umul udiv smul sdiv inc dec cmp
syn keyword tasmOpcodeJump  jmp
syn case match

"""""""""""""""""""" Registers
syn case ignore
syn match tasmRegister      "\<r\(3[0-1]\|[1-2]\d\|\d\)\>"
syn match tasmWidth         "\.\d\+" contained containedin=tasmOpcodeMove,tasmOpcodeArith,tasmOpcodeJump,tasmOpcodeNoOp
syn case match

"""""""""""""""""""" Directives
syn match tasmDirective     "%\a\+"

"""""""""""""""""""" Literals
syn match tasmDecNumber     "\<\d\+\>"
syn match tasmTernNumber    "\<0t[0-9a-fA-F]\+\>"
syn match tasmNonNumber     "\<0n[0-9a-fA-F]\+\>"
syn match tasmSeptNumber    "\<0s[0-9a-fA-F]\+\>"

syn match tasmLabel         "^[a-zA-Z_][a-zA-Z0-9_-]*:"
syn match tasmLocalLabel    "^\.[a-zA-Z0-9_-]\+:"

syn match tasmPredicate     "\<if\s*([^)]*)" contains=tasmKeyword

syn match tasmComment       "//.*$"

"""""""""""""""""""" Highlight links
hi def link tasmKeyword     Conditional
hi def link tasmPredicate   PreProc
hi def link tasmDirective   PreProc
hi def link tasmRegister    Identifier
hi def link tasmOpcodeNoOp  Keyword
hi def link tasmOpcodeMove  Keyword
hi def link tasmOpcodeArith Keyword
hi def link tasmOpcodeJump  Statement
hi def link tasmWidth       Special
hi def link tasmDecNumber   Number
hi def link tasmTernNumber  Number
hi def link tasmNonNumber   Number
hi def link tasmSeptNumber  Number
hi def link tasmLabel       Function
hi def link tasmLocalLabel  Function
hi def link tasmComment     Comment

let b:current_syntax = "tasm"
