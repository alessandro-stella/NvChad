local lspconfig = require "lspconfig"

lspconfig.jdtls.setup {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-jar",
    "/home/alessandro/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar",
    "-configuration",
    "/home/alessandro/.local/share/nvim/mason/packages/jdtls/config_linux",
    "-data",
    "/home/alessandro/.workspace-java",
  },
  root_dir = lspconfig.util.root_pattern(".git", "pom.xml", "build.gradle", "src"),
  settings = {
    java = {
      errors = { incompleteClasspath = "warning" },
    },
  },
  on_attach = function(client, bufnr)
    vim.diagnostic.config {
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = true,
    }
  end,
}
