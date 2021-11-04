" Author: TeoDev1611
" Version: 0.1.0
" Mantainer: TeoDev1611

if !executable('python') 
   echoerr "Python is nesesarry for use this plugin"	
   finish
endif

" Utils
function! venom#utils#runshell(command)
   let command = join(map(split(a:command), 'expand(v:val)'))
   let winnr = bufwinnr('^' . command . '$')
   silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
   setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
   echo 'Execute ' . command . '...'
   silent! execute 'silent %!'. command
   silent! execute 'resize ' . line('$')
   silent! redraw
   silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
   silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>venom#utils#runshell(''' . command . ''')<CR>'
   echo 'Shell command ' . command . ' executed.'
endfunction

function! venom#utils#path#join(pathparts, ...) abort
  let sep
        \ = (a:0) == 0                       ? '/'
        \ : type(a:1)==type(0) && (a:1) == 0 ? '/'
        \ : (a:1) == 1                       ? '\'
        \ : (a:1) =~ 'shellslash\|ssl'       ? (&ssl ? '\' : '/')
        \ :                                    (a:1)
  return join(a:pathparts, sep)
endfunction

let g:venom#utils#plugindir = expand('<sfile>:p:h:h')
