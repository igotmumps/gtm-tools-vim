" Original Author: Michael Zacharias

" License: AGPL
" Date: 2014 June 5

" === Global Utilities ===
"
" Dump a global to the screen
function! GDump(gbl)
	let l:gbl=a:gbl
	let $gtmroutines=$HOME . "/gtm/o(" . $HOME . "/gtm/r) " . $gtmroutines
	let l:cmd="mumps -r GDUMP^ZMTOOLS '" . l:gbl . "'"
	botright new
        setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
        execute '$read !'. cmd
endfunction

command! -nargs=1 GDump call GDump(<q-args>) 

function! ZTarget(env)
	let l:env=a:env
	let l:rv = system("env")
	let l:rv = system(".gtmenv")
endfunction

" Comment wrap
let g:commet_char = ';'
function! Comment() range
    let lines = getline(a:firstline,a:lastline)
    for i in range(len(lines))
	let ll = len(lines[i])
	let lines[i] = "\t" . g:commet_char . ' ' . split(lines[i],"\t")[0] 
    endfor  
    let result = []
    call extend(result, lines)
    execute a:firstline.','.a:lastline . ' d'
    let s = a:firstline-1<0?0:a:firstline-1
    call append(s, result)
endfunction


