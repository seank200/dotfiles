-- Get colors from active colorscheme

local colors = {
	black = 0,
	red = 1,
	green = 2,
	yellow = 3,
	blue = 4,
	magenta = 5,
	cyan = 6,
	white = 7,
}

---@param text string
---@param query string
local function starts_with(text, query)
	return query == string.sub(text, 1, string.len(query))
end

local current_scheme = vim.g.colors_name or ""

if starts_with(current_scheme, "catppuccin") then
	local ctp_ok, ctp = pcall(require, "catppuccin.palettes")
	if ctp_ok then
		local palette = ctp.get_palette()
		colors.colorscheme = "catppuccin"
		colors.black = palette.text
		colors.red = palette.red
		colors.green = palette.green
		colors.yellow = palette.yellow
		colors.blue = palette.blue
		colors.magenta = palette.mauve
		colors.cyan = palette.sky
		colors.white = palette.base
	end
end

return colors
