if v:version < 702 || exists('loaded_highlightmultiple') || &cp
  finish
endif
let loaded_highlightmultiple = 1

" On first call, read file highlights.csv in same directory as script.
" For example, line "5,white,blue,black,green" executes:
" highlight hl5 ctermfg=white ctermbg=blue guifg=black guibg=green
let s:data_file = expand('<sfile>:p:r').'.csv'
let s:loaded_data = 0
function! LoadHighlights()
  if !s:loaded_data
    if filereadable(s:data_file)
      let names = ['hl', 'ctermfg=', 'ctermbg=', 'guifg=', 'guibg=']
      for line in readfile(s:data_file)
        let fields = split(line, ',', 1)
        if len(fields) == 5 && fields[0] =~ '^\d\+$'
          let cmd = range(5)
          call map(cmd, 'names[v:val].fields[v:val]')
          call filter(cmd, 'v:val!~''=$''')
          execute 'silent highlight '.join(cmd)
        endif
      endfor
      let s:loaded_data = 1
    endif
    if !s:loaded_data
      echo 'Error: Could not read highlight data from '.s:data_file
    endif
  endif
endfunction

function! s:HighlightGroupsAddWord(gr, w)
  call LoadHighlights()
  let group_name = 'hl' . a:gr
  let cmd = "syntax match " . group_name . " '\\\<" . expand ("<cword>") . "\\\>' containedin=ALL"
  let cur_win = winnr()
  if a:w == 0
    execute cmd
  else
    windo execute cmd
  endif
  exe cur_win . "wincmd w"
endfunction
command! -nargs=+ HighlightGroupsAddWord call s:HighlightGroupsAddWord(<f-args>)

function! s:HighlightGroupsClearGroup(gr, w)
  call LoadHighlights()
  let group_name = 'hl' . a:gr
  let cmd = "syntax clear " . group_name
  let cur_win = winnr()
  if a:w == 0
    execute cmd
  else
    windo execute cmd
  endif
  exe cur_win . "wincmd w"
endfunction
command! -nargs=+ HighlightGroupsClearGroup call s:HighlightGroupsClearGroup(<f-args>)
