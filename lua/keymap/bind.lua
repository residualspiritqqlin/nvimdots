local rhs_options = {}

function rhs_options:new()
	local instance = {
		cmd = "",
		options = {
			noremap = false,
			silent = false,
			expr = false,
			nowait = false,
			callback = nil,
			desc = "",
		},
		buffer = false,
	}
	setmetatable(instance, self)
	self.__index = self
	return instance
end

function rhs_options:map_cmd(cmd_string)
	self.cmd = cmd_string
	return self
end

function rhs_options:map_cr(cmd_string)
	self.cmd = (":%s<CR>"):format(cmd_string)
	return self
end

function rhs_options:map_args(cmd_string)
	self.cmd = (":%s<Space>"):format(cmd_string)
	return self
end

function rhs_options:map_cu(cmd_string)
	-- <C-u> to eliminate the automatically inserted range in visual mode
	self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
	return self
end

function rhs_options:map_callback(callback)
	self.cmd = ""
	self.options.callback = callback
	return self
end

function rhs_options:with_silent()
	self.options.silent = true
	return self
end

function rhs_options:with_desc(description_string)
	self.options.desc = description_string
	return self
end

function rhs_options:with_noremap()
	self.options.noremap = true
	return self
end

function rhs_options:with_expr()
	self.options.expr = true
	return self
end

function rhs_options:with_nowait()
	self.options.nowait = true
	return self
end

function rhs_options:with_buffer(num)
	self.buffer = num
	return self
end

local pbind = {}

function pbind.map_cr(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cr(cmd_string)
end

function pbind.map_cmd(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cmd(cmd_string)
end

function pbind.map_cu(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cu(cmd_string)
end

function pbind.map_args(cmd_string)
	local ro = rhs_options:new()
	return ro:map_args(cmd_string)
end

function pbind.map_callback(callback)
	local ro = rhs_options:new()
	return ro:map_callback(callback)
end

function pbind.split(str, sep)
	if sep == nil then
		sep = ","
	end
	local t = {}
	for w in string.gmatch(str, "([^" .. sep .. "]+)") do
		table.insert(t, w)
	end
	return t
end

function pbind.nvim_load_mapping(mapping)
	for key, value in pairs(mapping) do
		local mode_str, keymap = key:match("([^|]*)|?(.*)")
		local mode_list = pbind.split(mode_str, ",")
		for _, mode in pairs(mode_list) do
			if type(value) == "table" then
				local rhs = value.cmd
				local options = value.options
				vim.api.nvim_set_keymap(mode, keymap, rhs, options)
			end
		end
	end
end

return pbind
