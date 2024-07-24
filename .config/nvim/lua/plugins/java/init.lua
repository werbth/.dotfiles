return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          jdtls = {
            settings = {
              java = {
                configuration = {
                  runtimes = {
                    {
                      name = "JavaSE-21",
                      path = "/Users/werbth/.asdf/installs/java/corretto-21.0.2.13.1",
                      default = true,
                    },
                  },
                },
              },
            },
          },
        },
        setup = {
          jdtls = function()
            require("java").setup({
              -- your nvim-java configuration goes here
            })
          end,
        },
      },
    },
  },
}
