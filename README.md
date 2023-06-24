# Haigo.nvim

A neovim plugin to interact with haipigo

## Install

Lazy

```lua
{
    "SDGLBL/hapigo.nvim",
    cmd = {
      "HapigoAPPSerchWord", -- search app by word under cursor
      "HapigoAPPSerch", -- search app by text that selected in visual mode
      "HapigoFileSerchWord", -- search file by word under cursor
      "HapigoFileSerch", -- search file by text that selected in visual mode
      "HapigoClipboardSerchWord", -- search clipboard by word under cursor
      "HapigoClipboardSerch", -- search clipboard by text that selected in visual mode
      "HapigoTranslateWord", -- translate word under cursor
      "HapigoTranslate", -- translate text that selected in visual mode
    },
    config = true,
}
```

## Configuration

```lua
---@class Haigo.Config
M.config = {
	-- url_schema = "hapigo://open?extensionID=%s&query=%s",
	url_schema = "hapigo://open?extensionID=%s&query=%s",
	-- copy_to_clipboard Whether to copy the generated link to the system clipboard?
	copy_to_clipboard = false,
	-- extension_ids hai go extension id
	-- As far as know, there are only 4 types of extension id Haigo supports
	-- If you want to use other extension id, please refer to the official document of Haigo
	extension_ids = {
		app = "APP",
		file = "FILE",
		clipboard = "CLIPBOARD",
		translate = "TRANSLATE",
	},
	-- normal_text function to get the word under the cursor in normal mode
	nomal_text = function()
		return vim.fn.expand("<cword>")
	end,
	-- visual_text function to get the selected text in visual mode
	visual_text = function()
		local _, start_row, start_col, _ = unpack(vim.fn.getpos("'<"))
		local _, end_row, end_col, _ = unpack(vim.fn.getpos("'>"))
		local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)

		for i = 1, #lines do
			if i == #lines then
				lines[i] = string.sub(lines[i], start_col, end_col - 1)
			else
				lines[i] = string.sub(lines[i], start_col)
			end
		end

		return table.concat(lines, " ")
	end,
}
```
