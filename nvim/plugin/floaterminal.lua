vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local function create_floating_window(opts)
	-- Get the current screen dimensions (height and width)
	local screen_width = vim.o.columns
	local screen_height = vim.o.lines

	-- Set default options if not provided
	opts = opts or {}
	opts.width = opts.width or math.floor(screen_width * 0.8) -- Default to 80% width
	opts.height = opts.height or math.floor(screen_height * 0.8) -- Default to 80% height

	-- Calculate the position to center the window
	local row = math.floor((screen_height - opts.height) / 2)
	local col = math.floor((screen_width - opts.width) / 2)

	-- Set up window configuration
	local win_config = {
		relative = "editor", -- Relative to the editor (screen)
		width = opts.width,
		height = opts.height,
		row = row,
		col = col,
		style = "minimal", -- Minimal style to avoid decorations
		border = "rounded", -- Optional: single border, can be 'none', 'double', 'single', etc.
	}

	-- Create the floating window
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- Create an empty buffer
	end

	local win = vim.api.nvim_open_win(buf, true, win_config) -- Open floating window

	return { win = win, buf = buf }
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.term()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<A-t>", toggle_terminal)
