local lspconfig = require "lspconfig"
local jdtls = require "jdtls"
local M = {}

function M:setup()
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

  -- Base workspace directory
  local workspace_base = vim.fn.expand "~/.workspace-java/"
  if vim.loop.fs_stat(workspace_base) == nil then
    vim.loop.fs_mkdir(workspace_base, 448) -- 0o700
  end

  -- Workspace for this project/file
  local workspace_dir = workspace_base .. project_name
  if vim.loop.fs_stat(workspace_dir) == nil then
    vim.loop.fs_mkdir(workspace_dir, 448)
  end

  -- Mason installation path
  local mason_jdtls = vim.fn.stdpath "data" .. "/mason/packages/jdtls"

  -- Dynamic Equinox launcher jar
  local launcher_jar = vim.fn.glob(mason_jdtls .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  if launcher_jar == "" then
    error "Launcher jar not found in Mason! Install jdtls via Mason."
  end

  -- Java command from PATH
  local java_cmd = vim.fn.exepath "java"
  if java_cmd == "" then
    java_cmd = "/usr/bin/java" -- fallback
  end

  local config = {
    cmd = {
      java_cmd,
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      launcher_jar,
      "-configuration",
      mason_jdtls .. "/config_linux",
      "-data",
      workspace_dir,
    },

    -- Root directory: use project root if available, otherwise current folder
    root_dir = lspconfig.util.root_pattern(".git", "pom.xml", "build.gradle", "src")(vim.fn.getcwd())
      or vim.fn.getcwd(),

    -- Compiler-style diagnostics and settings
    settings = {
      java = {
        errors = {
          incompleteClasspath = "error", -- missing classes
          forbiddenReference = "error", -- forbidden API usage
          nullAnalysis = "warning", -- possible null pointer issues
          syntax = "error", -- syntax errors
          typeInference = "warning", -- raw types like ArrayList without <>
          potentialProblem = "warning", -- uninitialized variables, undeclared variable usage
        },
        completion = {
          importOrder = { "java", "javax", "org", "com" },
        },
        format = { enabled = true },
      },
    },

    init_options = {
      bundles = {},
    },

    on_attach = function(_, _)
      vim.diagnostic.config {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
      }
    end,
  }

  jdtls.start_or_attach(config)
end

return M
