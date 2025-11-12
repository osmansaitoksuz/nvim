local lint = require("lint")

local function command_available(cmd)
	if not cmd then
		return false
	end
	if type(cmd) == "string" then
		return vim.fn.executable(cmd) == 1
	end
	if type(cmd) == "table" and cmd[1] then
		return vim.fn.executable(cmd[1]) == 1
	end
	-- Fonksiyon dönen komutlar proje içinden çözüleceği için mevcut varsay.
	return type(cmd) == "function"
end

local function linter_available(name)
	local linter = lint.linters[name]
	if not linter then
		return false
	end
	return command_available(linter.cmd)
end

local function prefer_linters(ft, preferred)
	if lint.linters_by_ft[ft] and #lint.linters_by_ft[ft] > 0 then
		return
	end
	for _, name in ipairs(preferred) do
		if linter_available(name) then
			lint.linters_by_ft[ft] = { name }
			return
		end
	end
end

lint.linters_by_ft = lint.linters_by_ft or {}
lint.linters_by_ft.html = lint.linters_by_ft.html or { "htmlhint" }

local eslint_pref = { "eslint_d", "eslint" }
prefer_linters("javascript", eslint_pref)
prefer_linters("javascriptreact", eslint_pref)
prefer_linters("typescript", eslint_pref)
prefer_linters("typescriptreact", eslint_pref)

local function try_lint()
	lint.try_lint()
end

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	group = vim.api.nvim_create_augroup("custom_nvim_lint", { clear = true }),
	callback = try_lint,
})
