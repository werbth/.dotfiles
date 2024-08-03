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
                      path = os.getenv("HOME") .. "/.asdf/installs/java/corretto-21.0.3.9.1",
                      default = true,
                    },
                    {
                      name = "JavaSE-17",
                      path = os.getenv("HOME") .. "/.asdf/installs/java/corretto-17.0.10.7.1",
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
              jdk = {
                -- disable installing jdk
                auto_install = false,
              },
            })
          end,
        },
      },
    },
  },
}
