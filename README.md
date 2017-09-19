highlight-groups.vim
====================

Allow the user to add words in highlight groups on the fly.
Each group has a different color.
The highlight mechanism used by this plugin is :syn-match, meaning
that it cannot search for words featured in a group.

The goal of this plugin is to allow the user to mark words and increase
readabilty of certain lines of code.
It is especially useful to visualy compare 2 function signatures, or any kind
of other interfaces.

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

Here is an example of mapping in your `.vimrc`:
```vim
nnoremap <silent> <F5> :HighlightGroupsAddWord 4 0<CR>
nnoremap <silent> <F6> :HighlightGroupsAddWord 6 0<CR>
nnoremap <silent> <S-F5> :HighlightGroupsClearGroup 4 0<CR>
nnoremap <silent> <S-F6> :HighlightGroupsClearGroup 6 0<CR>
nnoremap <silent> <C-F5> :HighlightGroupsAddWord 4 1<CR>
nnoremap <silent> <C-F6> :HighlightGroupsAddWord 6 1<CR>
nnoremap <silent> <C-S-F5> :HighlightGroupsClearGroup 4 1<CR>
nnoremap <silent> <C-S-F6> :HighlightGroupsClearGroup 6 1<CR>
```

Author
------

Inspired by Mario Trentini's highlights.vim

[Antoine Madec](https://github.com/antoinemadec)

License
------

Copyright (c) Antoine Madec. Distributed under the same terms as Vim itself. See :help license.
