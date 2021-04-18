" Add words in highlight groups on the fly
" Maintainer:   Antoine Madec <http://github.com/antoinemadec/>

if v:version < 702 || exists('loaded_highlightmultiple') || &cp
  finish
endif
let loaded_highlightmultiple = 1

" Read csv file on first call and generate highlights.
" E.g.:
"   "5,white,blue,black,green" executes
"   highlight hl5 ctermfg=white ctermbg=blue guifg=black guibg=green
let s:csv_file = expand('<sfile>:p:r').'.csv'
let s:loaded_data = 0
function! s:loaded_data()
  if !s:loaded_data
    if filereadable(s:csv_file)
      let names = ['hl', 'ctermfg=', 'ctermbg=', 'guifg=', 'guibg=']
      for line in readfile(s:csv_file)
        let fields = split(line, ',', 1)
        if len(fields) == 5 && fields[0] =~ '^\d\+$'
          let cmd = range(5)
          call map(cmd, 'names[v:val].fields[v:val]')
          call filter(cmd, 'v:val!~''=$''')
          execute 'silent highlight ' . join(cmd)
        endif
      endfor
      let s:loaded_data = 1
    endif
    if !s:loaded_data
      echo 'Error: Could not read highlight data from '.s:csv_file
    endif
  endif
endfunction

function! s:add_word(gr, w)
  call s:loaded_data()
  let group_name = 'hl' . a:gr
  let cmd = printf("call MatchAdd('%s', '%s', '\\<%s\\>', 11)",
        \ group_name, group_name, expand("<cword>"))
  let cur_win = winnr()
  if a:w == 0
    execute cmd
  else
    windo execute cmd
  endif
  exe cur_win . "wincmd w"
endfunction

function! s:clear_group(gr, w)
  let group_name = 'hl' . a:gr
  let cmd = printf("call MatchDelete('%s')", group_name)
  let cur_win = winnr()
  if a:w == 0
    execute cmd
  else
    windo execute cmd
  endif
  exe cur_win . "wincmd w"
endfunction

"--------------------------------------------------------------------
" public API
"--------------------------------------------------------------------
command! -nargs=+ HighlightGroupsClearGroup call s:clear_group(<f-args>)
command! -nargs=+ HighlightGroupsAddWord call s:add_word(<f-args>)

function MatchDelete(group_name) abort
  for id in get(w:, "match_ids_" . a:group_name, [])
    silent! call matchdelete(id)
  endfor
endfunction

function MatchAdd(group_name, hl, pattern, priority) abort
  let id = matchadd(a:hl, a:pattern, a:priority)
  let varname = "w:match_ids_" . a:group_name
  exe printf("let %s %s= [%d]", varname, exists(varname) ? '+' : '', id)
endfunction
