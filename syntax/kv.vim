if exists("b:current_syntax")
  finish
endif

"""""""""""""""""""" Comments
syn match kvComment "//.*$" contains=@Spell

"""""""""""""""""""" Delimiters
syn match kvBrace "[{}]"
syn match kvSemicolon ";"

"""""""""""""""""""" Literals
syn region kvString start=+"+ skip=+\\"+ end=+"+ oneline contains=kvStringNumber
syn match kvStringNumber '"\zs-\?\d\+\(\.\d\+\)\?\ze"' contained
syn match kvNumber '-\?\d\+\(\.\d\+\)\?'

"""""""""""""""""""" Identifiers
syn match kvIdentifier '\<[A-Za-z_][A-Za-z0-9_]*\>'
syn match kvBlockName '\<[A-Za-z_][A-Za-z0-9_]*\>\ze\s*{' containedin=ALLBUT,kvString,kvComment

"""""""""""""""""""" Highlight links
hi def link kvComment      Comment
hi def link kvBrace        Delimiter
hi def link kvSemicolon    Delimiter
hi def link kvString       String
hi def link kvStringNumber Number
hi def link kvNumber       Number
hi def link kvIdentifier   Identifier
hi def link kvBlockName    Type

let b:current_syntax = "kv"
