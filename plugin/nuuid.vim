if exists('g:nuuid_loaded') && g:nuuid_loaded
	finish
endif
let g:nuuid_loaded = 1

" Make sure we have python
if !has('python')
	echo "Error: nuuid requires Python support! Vim must be compiled with +python."
	finish
endif

function! s:NuuidInsertAbbrev()
	inoreabbrev <expr> nuuid nuuid#NuuidNewUuid() 
	inoreabbrev <expr> nguid nuuid#NuuidNewUuid() 
	let g:nuuid_iabbrev = 1
endfunction

function! s:NuuidInsertUnabbrev()
	silent iunabbrev nuuid
	silent iunabbrev nguid
	let g:nuuid_iabbrev = 0
endfunction

function! s:NuuidToggleInsertAbbrev()
	if exists('g:nuuid_iabbrev') && g:nuuid_iabbrev
		call s:NuuidInsertUnabbrev()
	else
		call s:NuuidInsertAbbrev()
	endif
endfunction

" set the initial abbreviation state
if !exists('g:nuuid_iabbrev') || g:nuuid_iabbrev
	call s:NuuidInsertAbbrev()
else
	call s:NuuidInsertUnabbrev()
endif

" commands
command! -nargs=0 NuuidToggleAbbrev call s:NuuidToggleInsertAbbrev()
command! -range -nargs=0 NuuidAll <line1>,<line2>substitute/\v<n[ug]uid>/\=nuuid#NuuidNewUuid()/geI
command! -range -nargs=0 NuuidReplaceAll <line1>,<line2>substitute/\v(<[0-9a-f]{8}\-?([0-9a-f]{4}\-?){3}[0-9a-f]{12}|n[gu]uid)>/\=nuuid#NuuidNewUuid()/geI

" Mappings
nnoremap <Plug>Nuuid i<C-R>=nuuid#NuuidNewUuid()<CR><Esc>
inoremap <Plug>Nuuid <C-R>=nuuid#NuuidNewUuid()<CR>
vnoremap <Plug>Nuuid c<C-R>=nuuid#NuuidNewUuid()<CR><Esc>

if !exists("g:nuuid_no_mappings") || !g:nuuid_no_mappings
	nmap <Leader>u <Plug>Nuuid
	vmap <Leader>u <Plug>Nuuid
endif
