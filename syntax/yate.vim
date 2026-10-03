if exists("b:current_syntax_yate")
  finish
endif
let b:current_syntax_yate = 1

let s:host_syntax = get(b:, 'current_syntax', '')

" Temporarily clear b:current_syntax so syntax/c.vim executes
unlet! b:current_syntax

" Include standard C syntax
syntax include @cCode syntax/c.vim

" Restore composite filetype name
if !empty(s:host_syntax)
  let b:current_syntax = s:host_syntax . '.yate'
else
  let b:current_syntax = 'yate'
endif

" 1. Define custom matchers to force "decent" highlighting for missing C elements
" These are contained so they only trigger inside your Yate blocks
syntax match yateCFunction "\w\+\s*\ze(" contained
syntax match yateCOperator "[-=+%^&|*!.~?:]\|<=\|>=\|==\|!=" contained
syntax match yateCIdentifier "\w\+" contained

" 2. Define the regions
" We include @cCode PLUS our custom decent highlighting matches.
" ALLBUT is required so Vim doesn't recursively crash the syntax engine.
syntax region yateInline matchgroup=yateDelimiter start="\${" end="}\$" keepend contains=@cCode,yateCFunction,yateCOperator,yateCIdentifier containedin=ALLBUT,yateInline,yateLineDirective
syntax region yateLineDirective matchgroup=yateLineMarker start="^\s*\$\({\)\@!" end="$" keepend contains=@cCode,yateCFunction,yateCOperator,yateCIdentifier containedin=ALLBUT,yateInline,yateLineDirective

" 3. Link everything to standard color groups
highlight default link yateDelimiter PreProc
highlight default link yateLineMarker PreProc
highlight default link yateCFunction Function
highlight default link yateCOperator Operator
" Link general identifiers to a basic variable color (like Normal or Identifier)
highlight default link yateCIdentifier Identifier
