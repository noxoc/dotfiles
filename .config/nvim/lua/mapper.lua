-- mapper
-- -----------
-- just a small helper to define keybinds with simple function calls or a table
-- if you've got a bunch of bindings with similar options.

--		noremap = require('mapper').noremap
--
--		require('mapper').noremap.n({
--			['<space>b'] = ':Buffers<CR>'
--			['<space>f'] = ':Telescope()<CR>'
--		}, { silent = true })

local function maptable(mode, opts, keys)
	for map, command in pairs(keys) do
		vim.api.nvim_set_keymap(mode, map, command, opts)
	end
end

local function mapper(mode, opts)
	return function(key, cmd, injected_options)
		opts = vim.tbl_extend('force', opts or {}, injected_options or {})
		if injected_options ~= nil then
			for k, v in pairs(injected_options) do
				opts[k] = v
			end
		end

		if type(key) == 'table' then
			maptable(mode, opts, key)
			return
		end

		if type(key) == 'string' then
			vim.api.nvim_set_keymap(mode, key, cmd, opts)
			return
		end

		error('mapper received neither string nor table as key. received: ' .. type(key))
	end
end

return {
	mapper = mapper,
	map = {
		n = mapper('n'),
		i = mapper('i'),
		v = mapper('v'),
		t = mapper('t'),
		x = mapper('x'),
		o = mapper('o'),
		c = mapper('c'),
	},

	noremap = {
		n = mapper('n', { noremap = true }),
		i = mapper('i', { noremap = true }),
		v = mapper('v', { noremap = true }),
		t = mapper('t', { noremap = true }),
		x = mapper('x', { noremap = true }),
		o = mapper('o', { noremap = true }),
		c = mapper('c', { noremap = true }),
	},
}
