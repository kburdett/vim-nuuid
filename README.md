nuuid.vim
====

A simple Vim plugin for generating and inserting [UUIDs](http://en.wikipedia.org/wiki/Uuid) in Vim. The inspiration for this plugin is the "nguid" snippet expansion in JetBrains ReSharper plugin for Visual Studio. The intent is to make working with UUIDs easy in Vim. The plugin uses python to generate version 4 UUIDs and lets you use them in the current buffer. The UUIDs are inserted as a string of hexadecimal digits in the format "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx".


Usage
----

Use the `<Plug>Nuuid` mapping to insert a new UUID at your current cursor location. This mapping is provided in insert, normal, and visual modes. By default, this will be mapped to `<Leader>u` in normal and visual modes.

Use `:NuuidAll` to replace all occurrences of "nuuid" and "nguid". This command accepts a range and works in normal and visual (line-wise) modes. Useful for batch generating UUIDs. An `:NguidAll` alias is provided for our Microsoft friends.

Use `:NuuidReplaceAll` to replace all all UUIDs, as well as all occurrences of "nuuid" and "nguid". This command accepts a range and works in normal and visual (line-wise) modes. Useful for regenerating UUIDs after copying and pasting a block of them. An `:NguidReplaceAll` alias is provided for our Microsoft friends.

Use the insert mode abbreviations "nuuid" and "nguid" to quickly insert a new UUID into your file. Simply type the abbreviation followed by a non-word character (or `<Esc>`) and Vim will replace the text with a new UUID for you.

Use `:NuuidToggleAbbrev` to toggle the insert mode abbreviations. Useful if your current text frequently contains "nuuid" or "nguid" (like this document, for instance...). 


Installation
----

If you don't have a preferred plugin manager, I recommend using Tim Pope's [pathogen.vim](https://github.com/tpope/vim-pathogen). Then you can install like so.
```sh
cd ~/.vim/bundle
git clone https://github.com/kburdett/vim-nuuid.git
```
However, you can always download this repository as a ZIP file and extract it to your `.vim` or `vimfiles` (Windows) directory.

Configuration
----

Setting the variable `g:nuuid_no_mappings` in your `.vimrc` will turn off the default mappings, allowing you to map `<Plug>Nuuid` to whatever keys you like.
```vim
let g:nuuid_no_mappings = 1
nnoremap <Leader>u <Plug>Nuuid
```

Setting the variable `g:nuuid_iabbrev` in your `.vimrc` will change the default state of the insert abbreviations. Use `1` to create the abbreviations (default), `0` to ignore them. You can still use `:NuuidToggleAbbrev` to toggle the abbreviations on or off.
```vim
let g:nuuid_iabbrev = 1
```

License
----
MIT

It's free! Just don't be a jerk...
