# lvim
my lunarvim setting

## Structure
- lvim/
    + A directory including user-defined config. files for lunarvim
- lvim.sh
    + A script for building/install nvim/lvim and setting configs 
        + lvim.sh build
        + lvim.sh config

## Usage
1. install neovim & lunarvim
    + <b>`lvim.sh build`</b> for <b>ubuntu</b>
2. configure lvim
    + <b>`lvim.sh config`</b> for <b>ubuntu</b> 
3. open lunarvim
    + <b>`lvim [file]`</b> 
4. key bindings
    + check with lvim/lua/settings/which_key.lua
    + In lvim, press a key.  
      If it is registered, 
      then you'll be able to see the list of shortcut keys that start with it.

## Error
- If icons are broken, then install nerd-font and change terminal font into it.

# vim

Neovim has lots of plugins and is slower than vim. When you open large files  
whose size is thousands MB, it may open slowly. So in that case, use vim.

1. <b>`./vim.sh build`</b> for plug.vim
2. <b>`./vim.sh config`</b>
