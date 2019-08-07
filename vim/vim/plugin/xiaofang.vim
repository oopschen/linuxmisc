" Xiao Fang is a smart edit assistant girl with beauty and wise
" feature list:
"
"
" Author: Chen Lei linxray@gmail.com
" Last Change: 2019.04.10
"

if exists("xiaofang")
    finish
endif

" map begin

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

" pandoc html
nmap pah :call FnPandocHtml5Command(1, 0)<CR>

function! FnPandocHtml5Command(isOpen, noCompileIfMissing)
  let filePrefix = 'autogen-pandoc-'
  if exists("*strftime")
    let filePrefix = filePrefix . strftime('%Y-%m-%d-')
  endif

  let outputFilePath = '/tmp/' . filePrefix . fnamemodify(expand('%'), ':t:r') . '.html'
  let pandocCmd = 'Pandoc'

  if a:isOpen
    let pandocCmd = pandocCmd . '!'
  endif

  if a:noCompileIfMissing && !filereadable(outputFilePath)
    return
  endif

  exec pandocCmd . ' html5 ' . '--toc --wrap=preserve -c ~/.pandoc/css/github.css' . ' -o ' . outputFilePath
endfunction


function! FnPandocOpen(file)
   let file = shellescape(fnamemodify(a:file, ':p'))
   let file_extension = fnamemodify(a:file, ':e')

   if file_extension is? 'pdf'
     if !empty($PDFVIEWER)
       return expand('$PDFVIEWER') . ' ' . file
     elseif executable('zathura')
       return 'zathura ' . file
     elseif executable('mupdf')
       return 'mupdf ' . file
     endif
   elseif file_extension is? 'html'
     if !empty($BROWSER)
       return expand('$BROWSER') . ' ' . file
     elseif executable('firefox')
       return 'firefox ' . file
     elseif executable('chromium')
       return 'chromium ' . file
     elseif executable('google-chrome-stable')
       return 'google-chrome-stable ' . file
     endif
   elseif file_extension is? 'odt' && executable('okular')
     return 'okular ' . file
   elseif file_extension is? 'epub' && executable('okular')
     return 'okular ' . file
   else
     return 'xdg-open ' . file
   endif
endfunction

let g:pandoc#command#custom_open = "FnPandocOpen"

" coc.vim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
