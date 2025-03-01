return {
  "mfussenegger/nvim-jdtls",
  opts = {
    jdtls = {
      settings = {
        java = {
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
            },
          },
          format = {
            enabled = true,
            settings = {
              url = vim.fn.expand("~/eclipse-formatter.xml"),
              profile = "GoogleStyle",
            },
          },
        },
      },
    },
  },
}
