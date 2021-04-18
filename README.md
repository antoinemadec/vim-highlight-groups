highlight-groups.vim
====================

Add the word under the cursor in different highlight groups.

Each group has a different color.

![](https://raw.githubusercontent.com/antoinemadec/gif/master/highlightgroups.gif)

Installation
------------

Use your favorite plugin manager.

Using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'antoinemadec/vim-highlight-groups'
```

Quick start guide
-----------------

Add this in your `.vimrc`:
```vim
nnoremap <silent> <F5>     :HighlightGroupsAddWord    13 1<CR>
nnoremap <silent> \<F5>    :HighlightGroupsClearGroup 13 1<CR>
nnoremap <silent> <F6>     :HighlightGroupsAddWord    17 1<CR>
nnoremap <silent> \<F6>    :HighlightGroupsClearGroup 17 1<CR>
```

Complete API
------------

To highlight the word under the cursor:
```vim
:HighlightGroupsClearGroup <group_nb> <all_window>
:HighlightGroupsAddWord    <group_nb> <all_window>
```

Core functions:
```vim
" function MatchAdd(group_name, hl, pattern, priority)
" function MatchDelete(group_name)
call MatchAdd('my_own_group', 'IncSearch', '\s\+$', 11)
call MatchAdd('my_own_group', 'Error', 'compilation failed', 11)
call MatchDelete('my_own_group')
```

License
------

Copyright (c) Antoine Madec. Distributed under the same terms as Vim itself. See :help license.
