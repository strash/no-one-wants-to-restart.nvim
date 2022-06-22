local reload_module = require("no-one-wants-to-restart")

local function set_commands()
	vim.api.nvim_create_user_command("ReloadModuleAdd",
		function(opts)
			if #opts.args == 0 then
				reload_module.add_module(nil)
			else
				reload_module.add_module(opts.args)
			end
		end,
		{ nargs = "?" }
	)

	vim.api.nvim_create_user_command("ReloadModule",
		function()
			reload_module.reload()
		end,
		{
			nargs = "?",
			complete = function(_, _, _)
				return reload_module.modules
			end,
		}
	)

	vim.api.nvim_create_user_command("ReloadModuleAll",
		function(opts)
			if #opts.args == 0 then
				reload_module:reload_one(opts)
			end
		end,
		{
			nargs = 0,
		}
	)

	vim.api.nvim_create_user_command("ReloadModuleList",
		function(_)
			reload_module.list()
		end,
		{ nargs = 0 }
	)
end

local reload_module_groug = vim.api.nvim_create_augroup("NoOneWantsToRestartNvim", {
	clear = true,
})

vim.api.nvim_create_autocmd({
	"VimEnter",
}, {
	pattern = "*",
	callback = set_commands,
	group = reload_module_groug
})
