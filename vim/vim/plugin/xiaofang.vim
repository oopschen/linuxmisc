" Xiao Fang is a smart edit assistant girl with beauty and wise
" feature list:
"
"
" Author: Chen Lei linxray@gmail.com
" Last Change: 2018.01.23
"

if exists("xiaofang")
    finish
endif

" map begin

:inoremap kk <ESC>
:inoremap sss <ESC>:w<ENTER>
:nnoremap qqqq :q!<ENTER>
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
let g:rg_command = '
  \ rg --column --no-heading -i -L --color "always" '

command! -bang -nargs=* Rg call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

:nmap <C-o> :Files<CR>
:nmap <C-n> :Rg<CR>
:nmap <C-b> :Buffers<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" livedown
nmap pm :LivedownToggle<CR>
