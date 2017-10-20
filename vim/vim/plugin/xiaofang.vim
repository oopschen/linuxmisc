" Xiao Fang is a smart edit assistant girl with beauty and wise
" feature list:
"       1. auto complete [, ", ', \", \', (, <, {, </
"       2. auto delete above symbole when pairs with or without body inside
"
"
" Author: Chen Lei linxray@gmail.com
" Last Change: 2013.04.27
"

if exists("xiaofang")
    finish
endif

" map begin

:inoremap { {}<Left>
:inoremap [ []<Left>
:inoremap ( ()<Left>
:inoremap " ""<Left>
:inoremap ' ''<Left>
:inoremap ` ``<Left>

:inoremap {<ENTER> {<CR>}<UP><ESC>o
:inoremap [<ENTER> [<CR>]<UP><ESC>o
:inoremap (<ENTER> (<CR>)<UP><ESC>o

:inoremap {{ {
:inoremap [[ [
:inoremap (( (
:inoremap "" "
:inoremap '' '
:inoremap `` `
" end

" map search selected text
:vnoremap ss y:let @/=@*<CR>

" search and replace
:vnoremap sr y:%s/<C-R>"//g<LEFT><LEFT> 

" map end

" search in a range
function g:SSR(start, end, pattern)
  let @/ = "\\%>" . a:start . "l\\%<" . a:end . "l" . a:pattern
  normal! n
endf

:nnoremap ssr :call g:SSR(,, "")<LEFT><LEFT>

" fzf 
:map <c-s-o> :Files<CR>
:map <c-s-n> :Ag<CR>
:map <c-s-b> :Buffers<CR>
