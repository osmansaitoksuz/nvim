-- Treesitter capture'larını klasik Vim gruplarına bağla
local M = {}

function M.apply()
	local map = {
		["@comment"] = "Comment",
		["@string"] = "String",
		["@character"] = "Character",
		["@number"] = "Number",
		["@boolean"] = "Boolean",
		["@constant"] = "Constant",
		["@constant.builtin"] = "Constant",
		["@keyword"] = "Statement",
		["@keyword.function"] = "Statement",
		["@function"] = "Function",
		["@function.builtin"] = "Function",
		["@type"] = "Type",
		["@type.builtin"] = "Type",
		["@variable"] = "Identifier",
		["@variable.builtin"] = "Identifier",
		["@field"] = "Identifier",
		["@property"] = "Identifier",
		["@operator"] = "Operator",
		["@punctuation"] = "Delimiter",
	}
	for k, v in pairs(map) do
		pcall(vim.api.nvim_set_hl, 0, k, { link = v })
	end
end

return M
