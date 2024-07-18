-- Title: linux-style-plugin
-- Description: A plugin that help to maintain the linux kernel style
-- Notes: This pluging is an adaptation of the vim plugin vim-linux-coding-style to work with neovim. 
-- "OriginalPluginUrl: https://github.com/vivien/vim-linux-coding-style.git
-- "Author: <guzman.diego.at@gmail.com>
-- "Maintainer: <guzman.diego.at@gmail.com>
-- "License: GPL-3.0
-- "Version: 1.0.0



function run()
  print("Hello, world!")
end

local function setup(parameters)
end 


local function linuxFormatting() 
	local opt = vim.opt 
	opt.tabstop = 8
	opt.softtabstop = 8
	opt.shiftwidth = 8
	opt.textwidth = 80
	opt.expandtab = false
	opt.cindent = true
	opt.cinoptions:append("0,l1,t0,g0,(0")
end

local function LinuxKeywords()	
	-- Define highlight groups
	vim.api.nvim_set_hl(0, "cStatement", { link = "Statement" })
	vim.api.nvim_set_hl(0, "cOperator", { link = "Operator" })
	vim.api.nvim_set_hl(0, "cType", { link = "Type" })
	-- Define keywords
	local keywords = {
		cStatement = {
			"if", "else", "for", "while", "do", "switch", "case", "default",
			"goto", "continue", "break", "return", "fallthrough", "defer"
		},
		cOperator = { "likely", "unlikely", "sizeof", "typeof", "alignof", "offsetof" 
		},
		ctype = { "u8", "u16", "u32", "u64", "s8", "s16", "s32", "s64", 
		          "__u8","__u16", "__u32", "__u64", "__s8", "__s16", "__s32", "__s64" , "size_t", "ssize_t"}
	}
	local bufnr = vim.api.nvim_get_current_buf()
	
	-- Helper function to add highlights for keywords
	local function add_highlight(group, word)
    		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
			for line_number, line in ipairs(lines) do
				local start_col, end_col = line:find(word)
					if start_col then
		    				vim.api.nvim_buf_add_highlight(bufnr, -1, group, line_number - 1, start_col - 1, end_col)
					end
			end
    		--loop through the keywords and add highlights
		for group, words in pairs(keywords) do
			for _, word in ipairs(words) do
	 	  		add_highlight(group, word)
			end
		end
	end
end

local function LinuxHighlight()
  -- Define highlight groups
  vim.api.nvim_set_hl(0, "LinuxError", { link = "ErrorMsg", default = true })
  -- Define syntax matches 
  vim.api.nvim_exec([[
    syn match LinuxError /\ \+ze\t/ "spaces before tab
    syn match LinuxError /\%>80v[^()\{\}\[\]<>]\+/ "virtual colunm 81 and more
     " Highlight trailing whitespace, unless we're in insert mode and the
     " cursor's placed right after the whitespace. This prevents us from having
     " to put up with whitespace being highlighted in the middle of typing
     " something

    autocmd InsertEnter * match LinuxError  /\s\+\%#\@<!$/ "trailing whitespace
    autocmd InsertLeave * match LinuxError /\s\+$/ "trailing whitespace
	  ]], false)
end


local function LinuxCodingStyle()
	linuxFormatting()
	LinuxKeywords()
	LinuxHighlight()
end
		

local function check_and_apply_style()
	print("Checking and applying linux style")
	local apply_style = 0
	local path = vim.api.nvim_buf_get_name(0)
	-- local pattern_exists = vim.api.nvim_eval("g:linuxsty_patterns") 

	-- Check for global variable g:linuxsty_patterns
	if vim.g.linuxsty_patterns ~= nil then
		for _, pattern in ipairs(vim.api.nvim_get_globalvar("g:linuxsty_patterns")) do
			if string.match(path, pattern) then
				apply_style = 1
				break
			end
		end
	else
		apply_style = 1
	end

	-- Apply style if needed
	if apply_style == 1 then
		LinuxCodingStyle()
	end
end

return {
  run = run,
  linux_style_apply = check_and_apply_style
}

-- "LinuxConfigure configure linux style
-- vim.api.nvim_create_user_command("ApplyLinuxStyle", check_and_apply_style, {})
