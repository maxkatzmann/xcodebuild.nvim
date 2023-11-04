local M = {}

function M.get_buffers(opts)
	local result = {}
	local optsUnwrapped = opts or {}

	for i, buf in ipairs(vim.api.nvim_list_bufs()) do
		if
			optsUnwrapped.returnNotLoaded == true and vim.api.nvim_buf_is_valid(buf) or vim.api.nvim_buf_is_loaded(buf)
		then
			result[i] = buf
		end
	end

	return result
end

function M.get_buf_by_name(name, opts)
	local allBuffers = M.get_buffers(opts)

	for _, buf in pairs(allBuffers) do
		if string.match(vim.api.nvim_buf_get_name(buf), ".*/(.*)") == name then
			return buf
		end
	end

	return nil
end

function M.get_bufs_by_name_matching(pattern)
	local allBuffers = M.get_buffers()
	local result = {}

	for _, buf in pairs(allBuffers) do
		local bufName = vim.api.nvim_buf_get_name(buf)
		if string.find(bufName, pattern) then
			table.insert(result, { bufnr = buf, file = bufName })
		end
	end

	return result
end

function M.focus_buffer(bufNr)
	local _, window = next(vim.fn.win_findbuf(bufNr))
	if window then
		vim.api.nvim_set_current_win(window)
	end
end

function M.get_filename(filepath)
	return string.match(filepath, ".*%/([^/]*)%.swift")
end

function M.find_all_swift_files()
	local pwd = vim.api.nvim_exec2("pwd", { output = true })["output"]
	local allFiles = vim.fn.system({ "find", pwd, "-iname", "*.swift" })

	local map = {}

	for _, filepath in ipairs(vim.split(allFiles, "\n", { plain = true })) do
		local filename = M.get_filename(filepath)
		if filename then
			map[filename] = filepath
		end
	end

	return map
end

function M.find_all_swift_files2()
	local pwd = vim.api.nvim_exec2("pwd", { output = true })["output"]
	local allFiles = vim.fn.system({ "find", pwd, "-iname", "*.swift" })

	local map = {}

	for _, filepath in ipairs(vim.split(allFiles, "\n", { plain = true })) do
		table.insert(map, filepath)
	end

	return map
end

function M.shell(cmd)
	local handle = io.popen(cmd)

	if handle ~= nil then
		local result = handle:read("*a")
		handle:close()
		return vim.split(result, "\n", { plain = true })
	end

	return {}
end

function M.merge_array(lhs, rhs)
	local result = lhs
	for _, val in ipairs(rhs) do
		table.insert(result, val)
	end

	return result
end

function M.trim(str)
	return string.match(str, "^%s*(.-)%s*$")
end

function M.select(tab, selector)
	local result = {}
	for _, value in ipairs(tab) do
		table.insert(result, selector(value))
	end

	return result
end

function M.filter(tab, predicate)
	local result = {}
	for _, value in ipairs(tab) do
		if predicate(value) then
			table.insert(result, value)
		end
	end

	return result
end

function M.hasSuffix(text, suffix)
	return string.sub(text, -#suffix) == suffix
end

function M.hasPrefix(text, prefix)
	return string.sub(text, 1, #prefix) == prefix
end

return M