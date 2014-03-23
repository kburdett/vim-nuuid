if exists('g:nuuid_loaded') && g:nuuid_loaded
	finish
endif
let g:nuuid_loaded = 1

" Make sure we have python
if !has('python')
    echom "Error: nuuid requires Python support! Vim must be compiled with +python."
    finish
endif

" Initialize some defaults
if !exists('g:nuuid_abbrev')
	let g:nuuid_abbrev = 1
endif


" Use python to generate a new UUID
function! s:NewUuid()
python << endpy
import vim
from uuid import uuid4
vim.command("let l:new_uuid = '%s'"% str(uuid4()))
endpy
	return l:new_uuid
endfunction

" Replace all 'nuuid' and 'nguid' strings in the specified range
function! s:ReplaceAllUuids() range
	for i in range(a:firstline, a:lastline)
		let line = getline(i)
		let output = substitute(line, '\<n[gu]uid\>', s:NewUuid(), 'egI')
		call setline(i, output)
	endfor
endfunction

" Write a new UUID to the buffer
function! s:InsertUuid()
	let uuid = s:NewUuid()
	exe "normal! i" . uuid
endfunction


" Export the user facing things
if exists('g:nuuid_abbrev') && g:nuuid_abbrev
	inoreabbrev <expr> nuuid <SID>NewUuid() 
	inoreabbrev <expr> nguid <SID>NewUuid() 
endif

command! -nargs=0 Nuuid call <SID>InsertUuid()
command! -nargs=0 Nguid call <SID>InsertUuid()
command! -range -nargs=0 NuuidAll <line1>,<line2>call <SID>ReplaceAllUuids()
command! -range -nargs=0 NguidAll <line1>,<line2>call <SID>ReplaceAllUuids()
