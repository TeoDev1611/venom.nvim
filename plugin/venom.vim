" Author: TeoDev1611
" Version: 0.1.0
" Mantainer: TeoDev1611

if exists('g:loaded_venom') | finish | endif

" Setup and check the executables
lua require 'venom'.setup()

" Define the variables base
let g:venom#script = luaeval('require "venom".python')	
let g:venom#path = luaeval('require"venom".path')
let s:ask_param = 'What manager you want use? 
\ (1) Pipenv
\ ----
\ If you want other make a issue or a pr
\ ----  
\ '
let s:command_base = 'python ' .. g:venom#script 
let s:command_help = 'python ' .. g:venom#script .. '-h'

" The buffer out function
function! venom#runshell(command)
   let command = join(map(split(a:command), 'expand(v:val)'))
   let winnr = bufwinnr('^' . command . '$')
   silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
   setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
   silent! execute 'silent %!'. command
   silent! execute 'resize ' . line('$')
   silent! redraw
   silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
   silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>venom#runshell(''' . command . ''')<CR>'
endfunction


function venom#shell(command) abort
  execute '!' .. a:command 
endfunction
" The call functions for the commands
function! venom#run() abort
	call venom#runshell(s:command_help)
endfunction

function venom#log() abort
	lua require 'venom'.log_path()
endfunction

function venom#param() abort
  let input_data = input(s:ask_param)
  if input_data == '1' 
    return luaeval("require'venom'.run('pipenv')")
  endif
endfunction

function venom#now() abort
  let param = venom#param()
  call venom#runshell(s:command_base .. param)
endfunction

" Define the commands
command! VenomPath echomsg(g:venom#path)
command! VenomLog call venom#log()
command! VenomHelp call venom#run()
command! VenomNow call venom#now()
command! -nargs=1 VenomCheck :lua require 'venom'.checker(<f-args>)

let g:loaded_venom = 1
