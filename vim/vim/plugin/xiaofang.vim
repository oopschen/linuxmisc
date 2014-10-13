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

" map tab key
set tabpagemax=7
:nnoremap t1 1gt
:nnoremap t2 2gt
:nnoremap t3 3gt
:nnoremap t4 4gt
:nnoremap t5 5gt
:nnoremap t6 6gt
:nnoremap t7 7gt
:nnoremap tn :tabnext<CR>
:nnoremap tp :tabprevious<CR>
:nnoremap tm :tabmove<CR>

" map search selected text
:vnoremap ss y:let @/=@*<CR>

" search and replace
:vnoremap sr y:%s/<C-R>"//g<LEFT><LEFT> 

" normal mode paste from clipboard
:nmap cp "+p

" visual mode copy to clipboard
:vmap cc "+y

" map end

" status line
set statusline=%-(%l/%L%)\ %-y%-m\ %-F\ %-R

" search in a range
function g:SSR(start, end, pattern)
  let @/ = "\\%>" . a:start . "l\\%<" . a:end . "l" . a:pattern
  normal! n
endf

:nnoremap ssr :call g:SSR(,, "")<LEFT><LEFT>
