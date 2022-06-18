local M = {}

-- TODO: remove module
-- TODO: figure out sub modules
-- TODO: ReloadModuleAll and ReloadModule
-- TODO: in plugin/init.lua check if autogroup is not exist then add from some
-- events

M.modules = {}

--- add module
M.add_module = function(args)
	local current_module_name = args
	local is_module_exist = false
	if current_module_name == nil then
		current_module_name = vim.api.nvim_buf_get_name(0):match("[%w%s-_.]+$"):match("[%w%s-_]+")
	end
	-- check if module exist
	for _, v in ipairs(M.modules) do
		if v == current_module_name then
			is_module_exist = true
			break
		end
	end
	if not is_module_exist then
		table.insert(M.modules, current_module_name)
		print("Module '" .. current_module_name .. "' added.")
	else
		print("Module '" .. current_module_name .. "' already exist.")
	end
end

local function _reload(value)
	if package.loaded[value] ~= nil then
		package.loaded[value] = nil
		require(value)
		print("Module '" .. value .. "' reloaded")
	end
end

--- reload modules
M.reload = function(args)
	local current_module_name = args
	if current_module_name ~= nil then
		_reload(current_module_name)
	else
		for _, v in ipairs(M.modules) do
			_reload(v)
		end
	end
	if #M.modules == 0 then
		print("There is no modules to reload. Add module with ':ReloadModuleAdd <args>?'")
	end
end

--- list of modules
M.list = function()
	for _, v in ipairs(M.modules) do
		print(v)
	end
	if #M.modules == 0 then
		print("There is no modules. Add module with ':ReloadModuleAdd <args>?'")
	end
end

return M
