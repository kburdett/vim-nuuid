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
function! NewUuid()
python << endpy
import vim
from uuid import uuid4
vim.command("let l:new_uuid = '%s'"% str(uuid4()))
endpy
	return l:new_uuid
endfunction

" Abbreviations
if !exists('g:nuuid_no_iabbrev') || !g:nuuid_no_iabbrev
	inoreabbrev <expr> nuuid NewUuid() 
	inoreabbrev <expr> nguid NewUuid() 
endif

" commands
command! -range -nargs=0 NuuidAll <line1>,<line2>substitute/\v<n[ug]uid>/\=NewUuid()/geI
command! -range -nargs=0 NguidAll <line1>,<line2>NuuidAll
command! -range -nargs=0 NuuidReplaceAll <line1>,<line2>substitute/\v(<[0-9a-f]{8}\-?([0-9a-f]{4}\-?){3}[0-9a-f]{12}|n[gu]uid)>/\=NewUuid()/geI
command! -range -nargs=0 NguidReplaceAll <line1>,<line2>NuuidReplaceAll

" Mappings
nnoremap <Plug>Nuuid i<C-R>=NewUuid()<CR><Esc>
inoremap <Plug>Nuuid <C-R>=NewUuid()<CR>
vnoremap <Plug>Nuuid c<C-R>=NewUuid()<CR><Esc>

if !exists("g:nuuid_no_mappings") || !g:nuuid_no_mappings
	nmap <Leader>u <Plug>Nuuid
	vmap <Leader>u <Plug>Nuuid
endif
