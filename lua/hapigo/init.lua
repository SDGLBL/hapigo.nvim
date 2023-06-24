local M = {}

M.setup = function(params)
	M.config = require("hapigo.config").init(params)

	vim.api.nvim_create_user_command("HapigoAPPSerchWord", function()
		M.app("n")
	end, {})
	vim.api.nvim_create_user_command("HapigoAPPSerch", function()
		M.app("v")
	end, { range = true })

	vim.api.nvim_create_user_command("HapigoFileSerchWord", function()
		M.file("n")
	end, {})
	vim.api.nvim_create_user_command("HapigoFileSerch", function()
		M.file("v")
	end, { range = true })

	vim.api.nvim_create_user_command("HapigoClipboardSerchWord", function()
		M.clipboard("n")
	end, {})
	vim.api.nvim_create_user_command("HapigoClipboardSerch", function()
		M.clipboard("v")
	end, { range = true })

	vim.api.nvim_create_user_command("HapigoTranslateWord", function()
		M.translate("n")
	end, {})
	vim.api.nvim_create_user_command("HapigoTranslate", function()
		M.translate("v")
	end, { range = true })
end

M.config = {}

local generate_url = function(mode, extension_id)
	local url_schema = M.config.url_schema
	local query = ""

	if mode == "n" then
		query = M.config.nomal_text()
	elseif mode == "v" then
		query = M.config.visual_text()
	end

	if query == "" then
		return ""
	end

	url_schema = string.format(url_schema, extension_id, query)

	if M.config.copy_to_clipboard then
		vim.fn.setreg("+", url_schema)
	end

	return url_schema
end

M.app = function(mode)
	mode = mode or "n"
	local url = generate_url(mode, M.config.extension_ids.app)
	if url == "" then
		return
	end

	vim.system({
		"open",
		url,
	})
end

M.file = function(mode)
	local url = generate_url(mode or "n", M.config.extension_ids.file)
	if url == "" then
		return
	end

	vim.system({
		"open",
		url,
	})
end

M.clipboard = function(mode)
	local url = generate_url(mode or "n", M.config.extension_ids.clipboard)
	if url == "" then
		return
	end

	vim.system({
		"open",
		url,
	})
end

M.translate = function(mode)
	local url = generate_url(mode or "n", M.config.extension_ids.translate)
	if url == "" then
		return
	end

	vim.system({
		"open",
		url,
	})
end

return M
