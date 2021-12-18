" Author: TeoDev1611
" Version: 0.1.0
" Mantainer: TeoDev1611

if exists('g:loaded_venom') | finish | endif

" Setup and check the executables
lua require 'venom'.setup()

" Define the variables base
let g:venom#script = luaeval('require "venom".python')	
let g:venom#path = luaeval('require"venom".path')
let s:command_base = 'python ' .. g:venom#script


" The buffer out function
function! venom#runshell(command)
   let command = join(map(split(a:command), 'expand(v:val)'))
   let winnr = bufwinnr('^' . command . '$')
   silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
   setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
   echo 'Execute ' . command . '...'
   silent! execute 'silent %!'. command
   silent! execute 'resize ' . line('$')
   silent! redraw
   silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
   silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>venom#runshell(''' . command . ''')<CR>'
   echo 'Shell command ' . command . ' executed.'
endfunction


" The call functions for the commands
function! venom#run() abort
	call venom#runshell(s:command)
endfunction

function venom#log() abort
	lua require 'venom'.log_path()
endfunction

" Define the commands
command! VenomPath echomsg(g:venom#path)
command! VenomLog call venom#log()
command! -nargs=1 VenomCheck :lua require 'venom'.checker(<f-args>)

let g:loaded_venom = 1
