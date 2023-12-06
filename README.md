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

# tmux
## Commands
- `sudo apt install tmux`
- `cp tmux.conf ~/.config/.tmux.conf`
- `tmux source-file ~/.tmux.conf` (Apply config now)

## Key Bindings
```markdown
M-key == <ALT-key>
S-key == <SHIFT-key>
PREFIX == <CTRL-B> (disabled by .tmux.conf)
PREFIX == M-b or M-a
PREFIX + key

# 1. TMUX

## Execute Tmux
tmux

## Quit Tmux
PREFIX + d (after Detach)
tmux kill-session -t 0

# 2. PANE

## Pane Vertical Split
PREFIX + %
PREFIX + v (.tmux.conf)
PREFIX + | (.tmux.conf)

## Pane Horizontal Split
PREFIX + "
PREFIX + s (.tmux.conf)
PREFIX + _ (.tmux.conf)

## Select a Pane
PREFIX + (Left|Down|Up|Right)
M-h|j|k|l (.tmux.conf)
M-H|J|K|L (.tmux.conf)
M-Left|Down|Up|Right (.tmux.conf)

## Kill Pane
PREIFX + x
M-x (.tmux.conf)

## Resize & Rerrange Panes
### Vertically
select-layout even-vertical
PREFIX + M-2
### Horizontally
select-layout even-horizontal
PREFIX + M-1
### Automatically
PREFIX + <Space>
### Only Resize
PREFIX + H|J|K|L (.tmux.conf)
C-S-Left|Down|Up|Down (.tmux.conf)

## Change Positions of Panes
### Rotate
PREFIX + C-o (시계 반대 - anticlockwise)
PREFIX + M-o (시계 방향 - clockwise)
### Swap
PREFIX + }(S-]) (with right pane)
PREFIX + {(S-[) (with left pane)

# 3. WINDOW

## Create a Window
PREFIX + c
M-c (.tmux.conf)

## Select a Window
PREFIX + Number
PREFIX + n|p
S-Left|Right (.tmux.conf)
M-n|p

## Kill Window
PREFIX + &
M-& (.tmux.conf)

## Rename Window Title
PREFIX + ,
M-, (.tmux.conf)

# 4. SESSION

## Detach Session
PREFIX + d

## Session List
tmux ls

## Attach Session
tmux attach

## Assign Name to Session
tmux new-session -s SESSION_NAME
tmux list-sessions: 현재 열려있는 세션 목록을 보여준다.
tmux has-session -t TARGET_SESSION: TARGET_SESSION이라는 이름의 세션이 열려있는지 확인해본다.
tmux attach-session -t TARGET_SESSION: TARGET_SESSION이라는 이름의 세션으로 들어간다.

# 5. ETC

## Show Clock (Time)
PREFIX + t

## Mode
### Copy Mode
PREFIX + [
### View Mode
PREFIX + ?
### Choose Mode
PREFIX + w
### Out of Mode
q

## Reload tmux config
PREFIX + r (.tmux.conf)
```
