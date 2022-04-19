if exists('g:loaded_generify_autoload')
  finish
endif
let g:loaded_generify_autoload = 1

let s:rootNERDTreePath = resolve(expand('<sfile>:p:h:h'))

"FUNCTION: generify#version(...) {{{1
"  If any value is given as an argument, the entire line of text from the
"  change log is shown for the current version; otherwise, only the version
"  number is shown.
function! generify#version(...) abort
  let l:text = 'Unknown'
  try
    let l:changelog = readfile(join([s:rootNERDTreePath, 'CHANGELOG.md'], generify#slash()))
    let l:line = 0
    while l:line <= len(l:changelog)
      if l:changelog[l:line] =~# '\d\+\.\d\+'
        let l:text = substitute(l:changelog[l:line], '.*\(\d\+.\d\+\).*', '\1', '')
        let l:text .= substitute(l:changelog[l:line+1], '^.\{-}\(\.\d\+\).\{-}:\(.*\)', a:0>0 ? '\1:\2' : '\1', '')
        break
      endif
      let l:line += 1
    endwhile
  catch
  endtry
  return l:text
endfunction
