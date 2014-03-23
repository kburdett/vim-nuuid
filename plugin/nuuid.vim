if exists('g:nuuid_loaded') && g:nuuid_loaded
	finish
endif
let g:nuuid_loaded = 1

" Make sure we have python
if !has('python')
    echom "Error: nuuid requires Python support! Vim must be compiled with +python."
    finish
endif

" Use python to generate a new UUID
function! NuuidNewUuid()
python << endpy
import vim
from uuid import uuid4
vim.command("let l:new_uuid = '%s'"% str(uuid4()))
endpy
	return l:new_uuid
endfunction

function! s:NuuidInsertAbbrev()
	inoreabbrev <expr> nuuid NuuidNewUuid() 
	inoreabbrev <expr> nguid NuuidNewUuid() 
	let g:nuuid_iabbrev = 1
endfunction

function! s:NuuidInsertUnabbrev()
	iunabbrev nuuid
	iunabbrev nguid
	let g:nuuid_iabbrev = 0
endfunction

function! NuuidToggleInsertAbbrev()
	if exists('g:nuuid_iabbrev') && g:nuuid_iabbrev
		call s:NuuidInsertUnabbrev()
	else
		call s:NuuidInsertAbbrev()
	endif
endfunction

" initialize insert abbreviations
if !exists('g:nuuid_iabbrev') || g:nuuid_iabbrev
	call s:NuuidInsertAbbrev()
endif

" commands
command! -nargs=0 NuuidToggleIAbbrev call NuuidToggleInsertAbbrev()
command! -range -nargs=0 NuuidAll <line1>,<line2>substitute/\v<n[ug]uid>/\=NuuidNewUuid()/geI
command! -range -nargs=0 NguidAll <line1>,<line2>NuuidAll
command! -range -nargs=0 NuuidReplaceAll <line1>,<line2>substitute/\v(<[0-9a-f]{8}\-?([0-9a-f]{4}\-?){3}[0-9a-f]{12}|n[gu]uid)>/\=NuuidNewUuid()/geI
command! -range -nargs=0 NguidReplaceAll <line1>,<line2>NuuidReplaceAll

" Mappings
nnoremap <Plug>Nuuid i<C-R>=NuuidNewUuid()<CR><Esc>
inoremap <Plug>Nuuid <C-R>=NuuidNewUuid()<CR>
vnoremap <Plug>Nuuid c<C-R>=NuuidNewUuid()<CR><Esc>

if !exists("g:nuuid_no_mappings") || !g:nuuid_no_mappings
	nmap <Leader>u <Plug>Nuuid
	vmap <Leader>u <Plug>Nuuid
endif
