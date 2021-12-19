# venom.nvim :spider:

The more easy way to generate a `.pyrightconfig.json` file for the python development

## :eyes: Why this plugin? 

Well native lsp is amazing but the pyright language server not detect the packages from a virtual enviroment created by **Pipenv** or any other tool and this is soo tedious to configure and I created this for help you to create this with only one command :sunglasses:

## :tada: Installation

### Requirements

For use this you need:

- Python
- Neovim 0.5
- Pipenv ( For manage the enviroments )

### Plugin installation

For the lua users:
```lua
--- packer.nvim
use 'TeoDev1611/venom.nvim'

--- paq.nvim
require 'paq'{
  'TeoDev1611/venom.nvim'
}

--- vim-packager
packager.add('TeoDev1611/venom.nvim')
```
For the vim users:
```vim
"vim-plug
Plug 'TeoDev1611/venom.nvim'

"dein.vim
call dein#add('TeoDev1611/venom.nvim')

```

## :thinking: How use this ?

Well i improved many commands for make your development more easy

### Commands

- `VenomHelp` prints the help for the plugin and the option for use as a python script
- `VenomLog` prints the dir of the file of logs
- `VenomPath` prints the plugin path
- `VenomCheck` prints the checker for the executables *like checkhealth* **Args:** you need pass `msg` for show in only a message the params or `table` for print a table of information.
- `VenomNow` execute the script and you need choose a option for use pipenv or other options soon avaliable


## TODO :white_check_mark:

- [ ] Add neovim configuration
- [ ] Add a ui for the checker 
- [ ] Support other enviroment manager

---
<div align="center">

![Made for Neovim](https://img.shields.io/badge/Made%20for%20Neovim-by%20Teo-blue?style=for-the-badge&logo=neovim)

Made with :heart: in Ecuador

</div>
