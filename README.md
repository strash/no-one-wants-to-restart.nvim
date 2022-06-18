# No one wants to restart neovim
Module reloading for plugin developers

## Features
- [x] Add module to the stack
- [x] Reload one module or all from the stack
- [ ] Remove module from the stack
- [ ] figure out sub modules
- [ ] Split `:ReloadModule` to `:ReloadModule` and `:ReloadModuleAll`

## Installation
### [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use "strash/no-one-wants-to-restart.nvim"
```
### [vim-plug](https://github.com/junegunn/vim-plug)
```lua
Plug "strash/no-one-wants-to-restart.nvim"
```

## Usage
1. Call `:ReloadModuleAdd module-name` or just `:ReloadModuleAdd` from module to add the module to the stack
2. See what module in the stack with `:ReloadModuleList`
3. Reload module when it's time with `:ReloadModule module-name` to reload this
   module or use `:ReloadModule` to reload all modules from the stack. Use `<TAB>`
   for completein

## Commands
| Command                         | Description |
| ------------------------------- | -----------
| `ReloadModuleAdd [module-name]` | Add module to the stack. Accepts one or no argument. If there is no argument passed then it will add current module (buffer name)       |
| `ReloadModuleList`              | See added modules                                                                                                                       |
| `ReloadModule [module-name]`    | Reload module from the stack. Accepts one or no argument. If there is no argument passed then it will reload all modules from the stack |

