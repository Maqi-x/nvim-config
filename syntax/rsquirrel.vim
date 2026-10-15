if exists("b:current_syntax")
  finish
endif

syn case match

"""""""""""""""""""" Comments
syn region squirrelComment start="/\*" end="\*/" contains=squirrelTodo,@Spell
syn match  squirrelComment "//.*$"

syn keyword squirrelTodo TODO FIXME XXX contained

"""""""""""""""""""" Strings
syn region squirrelString start=+"+ skip=+\\."+ end=+"+
syn region squirrelString start=+'+ skip=+\\.'+ end=+'+

"""""""""""""""""""" Keywords
syn keyword squirrelKeyword
    \ break case catch class clone continue const default delete
    \ else enum extends do for foreach function if in null return
    \ switch this throw try typeof while yield resume wait base
    \ global struct enum thread expect

syn keyword squirrelDirective
    \ globalize_all_functions
    \ untyped

syn keyword squirrelLocal
    \ local

"""""""""""""""""""" Preprocessor
syn keyword squirrelClient contained CLIENT
syn keyword squirrelServer contained SERVER
syn keyword squirrelUI     contained UI

syn region squirrelPreCond matchgroup=PreProc start="^\s*#\s*if\>" end="$" keepend contains=squirrelClient,squirrelServer,squirrelUI,squirrelOperator
syn match  squirrelPreCond "^\s*#\s*endif\>"

"""""""""""""""""""" Types
syn keyword squirrelType
    \ entity vector int float string bool
    \ array table void var asset ornull

"""""""""""""""""""" Literals
syn keyword squirrelBoolean true false
syn keyword squirrelNull null

"""""""""""""""""""" Constants
syn match squirrelConstant "\<[A-Z_][A-Z0-9_]*\>"

"""""""""""""""""""" Numbers
syn match squirrelHex   "\<0x[0-9A-Fa-f]\+\>"
syn match squirrelFloat "\<\d\+\.\d\+\([eE][+-]\?\d\+\)\?\>"
syn match squirrelNumber "\<\d\+\>"

"""""""""""""""""""" Operators
syn match squirrelOperator "[+\-*%=&|!<>]=\?"
syn match squirrelOperator "||\|&&"

"""""""""""""""""""" Member access
syn match squirrelDot "\."

"""""""""""""""""""" Function calls
syn match squirrelFunction "\v<[A-Za-z_][A-Za-z0-9_]*\ze\s*\("

"""""""""""""""""""" Method calls
syn match squirrelMethod "\v\.\zs[A-Za-z_][A-Za-z0-9_]*\ze\s*\("

"""""""""""""""""""" Property access
syn match squirrelProperty "\v\.\zs[A-Za-z_][A-Za-z0-9_]*"

"""""""""""""""""""" Highlight links
hi def link squirrelComment   Comment
hi def link squirrelTodo      Todo

hi def link squirrelString    String

hi def link squirrelKeyword   Keyword
hi def link squirrelDirective PreProc
hi def link squirrelLocal     Error

hi def link squirrelType      Type
hi def link squirrelBoolean   Boolean
hi def link squirrelNull      Constant

hi def link squirrelConstant  Macro

hi def link squirrelNumber    Number
hi def link squirrelFloat     Float
hi def link squirrelHex       Number

hi def link squirrelOperator  Operator
hi def link squirrelDot       Delimiter

hi def link squirrelFunction  Function
hi def link squirrelMethod    Function
hi def link squirrelProperty  Identifier

hi def link squirrelPreCond   PreProc

hi squirrelClient gui=bold guifg=#98be65 cterm=bold ctermfg=10
hi squirrelServer gui=bold guifg=#c678dd cterm=bold ctermfg=13
hi squirrelUI     gui=bold guifg=#61afef cterm=bold ctermfg=14

let b:current_syntax = "rsquirrel"
