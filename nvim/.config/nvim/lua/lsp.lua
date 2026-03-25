local ok_mason, mason = pcall(require, "mason")
local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
if not (ok_mason and ok_mason_lsp) then
	return
end

local capabilities = nil
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink and blink.get_lsp_capabilities then
	capabilities = blink.get_lsp_capabilities()
end

local function java_root_dir(fname)
	if type(fname) == "number" then
		fname = vim.api.nvim_buf_get_name(fname)
	end
	if type(fname) ~= "string" or fname == "" then
		return vim.uv.cwd()
	end

	local root_markers = { "gradlew", "mvnw", "pom.xml", "build.gradle", "settings.gradle", ".git" }
	local root = vim.fs.root(fname, root_markers)
	if root then
		return root
	end
	return vim.fs.dirname(fname)
end

mason.setup({})

mason_lspconfig.setup({
	ensure_installed = { "pyright", "jdtls" },
})

-- Neovim 0.11+ LSP API
if vim.lsp and vim.lsp.config and vim.lsp.enable then
	vim.lsp.config("pyright", {
		capabilities = capabilities,
	})

	vim.lsp.config("jdtls", {
		capabilities = capabilities,
		single_file_support = true,
		root_markers = { "gradlew", "mvnw", "pom.xml", "build.gradle", "settings.gradle", ".git" },
		settings = {
			java = {
				completion = {
					favoriteStaticMembers = {
						"org.junit.Assert.*",
						"org.junit.jupiter.api.Assertions.*",
						"java.util.Objects.requireNonNull",
						"java.util.Objects.requireNonNullElse",
						"java.util.Collections.*",
						"java.util.stream.Collectors.*",
					},
					filteredTypes = {
						"com.sun.*",
						"io.micrometer.shaded.*",
						"java.awt.*",
						"jdk.*",
						"sun.*",
					},
				},
			},
		},
	})

	vim.lsp.enable({ "pyright", "jdtls" })
	return
end

-- Backward-compatible fallback for older Neovim versions.
local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
if not ok_lspconfig then
	return
end

lspconfig.pyright.setup({
	capabilities = capabilities,
})

lspconfig.jdtls.setup({
	capabilities = capabilities,
	single_file_support = true,
	root_dir = java_root_dir,
	settings = {
		java = {
			completion = {
				favoriteStaticMembers = {
					"org.junit.Assert.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"java.util.Collections.*",
					"java.util.stream.Collectors.*",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
			},
		},
	},
})
