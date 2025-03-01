return {
  "mfussenegger/nvim-jdtls",
  opts = {
    jdtls = function(opts)
      local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
      local jvmArg = "-javaagent:" .. install_path .. "/lombok.jar"
      table.insert(opts.cmd, "--jvm-arg=" .. jvmArg)

      opts.settings = {
        java = {
          eclipse = {
            downloadSources = true,
          },
          configuration = {
            runtimes = {
              {
                name = "JavaSE-21",
                path = vim.fn.expand("~/.asdf/installs/java/corretto-21.0.3.9.1"),
                default = true,
              },
              {
                name = "JavaSE-17",
                path = vim.fn.expand("~/.asdf/installs/java/corretto-17.0.10.7.1"),
                default = false,
              },
              {
                name = "JavaSE-11",
                path = vim.fn.expand("~/.asdf/installs/java/corretto-11.0.25.9.1"),
              },
              {
                name = "JavaSE-1.8",
                path = vim.fn.expand("~/.asdf/installs/java/corretto-8.432.06.1"),
              },
            },
          },
          format = {
            enabled = true,
            settings = {
              profile = "GoogleStyle",
              url = vim.fn.expand("~/eclipse-formatter.xml"),
            },
          },
          inlayHints = {
            parameterNames = {
              enabled = "all",
            },
          },
          maven = {
            downloadSources = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
        },
      }

      return opts
    end,
  },
}
