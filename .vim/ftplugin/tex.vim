function! LatexCompile()
    let l:match = matchlist(getline(1), '%\s*!TeX\s\+root=\(.\+\)')
    if len(l:match) > 0
        execute "!pdflatex " . l:match[1]
    else
        execute "!pdflatex " . 
    endif
endfunction

nnoremap <buffer> <F5> :call LatexCompile()<cr>

function LatexFoldLevel(lnum)
    if match(getline(a:lnum), '\\chapter') >= 0
        return ">1"
    if match(getline(a:lnum), '\\section') >= 0
        return ">2"
    elseif match(getline(a:lnum), '\\subsection') >= 0
        return ">3"
    elseif match(getline(a:lnum), '\\subsubsection') >= 0
        return ">4"
    elseif match(getline(a:lnum), '\\paragraph') >= 0
        return ">5"
    elseif match(getline(a:lnum), '\\begin') >= 0
        return "a1"
    elseif match(getline(a:lnum), '\\end') >= 0
        return "s1"
    else
        return "="
endfunction

setlocal foldmethod=expr
setlocal foldexpr=LatexFoldLevel(v:lnum)
