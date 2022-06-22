local M = {}

-- TODO: ReloadModuleRemove module
-- TODO: figure out sub modules
-- TODO: in plugin/init.lua check if autogroup is not exist then add from some
-- DONE: ReloadModuleAll and ReloadModule
-- DONE: print if module not found when reloading events

M.modules = {}

--- add module
function M.add_module(args)
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

-- helper
local function _reload(value)
	if package.loaded[value] ~= nil then
		package.loaded[value] = nil
		package.loaded[value] = require(value)
		print("Module '" .. value .. "' reloaded")
	else
		print("Module '" .. value .. "' not found")
	end
end

-- reload one module
function M:reload_one(args)
	if args ~= nil then
		_reload(args)
	end
end

--- reload modules
function M.reload()
	for _, v in ipairs(M.modules) do
		_reload(v)
	end
	if #M.modules == 0 then
		print("There is no modules to reload. Add module with ':ReloadModuleAdd [module-name]'")
	end
end

--- list of modules
function M.list()
	print("Modules:")
	for i, v in ipairs(M.modules) do
		if i < #M.modules then
			print(v .. ",")
		else
			print(v)
		end
	end
	if #M.modules == 0 then
		print("There is no modules. Add module with ':ReloadModuleAdd [module-name]'")
	end
end

--local lua_dirs = vim.api.nvim_get_runtime_file("lua/", true)
--local plugin_dirs = vim.api.nvim_get_runtime_file("plugin/", true)
--vim.pretty_print(plugin_dirs)
--local paths = vim.api.nvim_list_runtime_paths()
--for _, m in ipairs(M.modules) do
--	for _, v in ipairs(paths) do
--		if v:find(m) then
--			print(v)
--		end
--	end
--end

return M
