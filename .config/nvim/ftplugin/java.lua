local home = os.getenv('HOME')
local jdtls = require('jdtls')

-- File types that signify a Java project's root directory. This will be
-- used by eclipse to determine what constitutes a workspace
local root_markers = {'gradlew', 'mvnw', '.git'}
local root_dir = require('jdtls.setup').find_root(root_markers)

local jdk_17_path = '/usr/lib/jvm/java-17-openjdk'
local jdk_11_path = '/usr/lib/jvm/java-11-openjdk'
local jdk_8_path = '/usr/lib/jvm/java-8-openjdk'
local jdtls_home = '/usr/share/java/jdtls'
local jdtls_config = '/config_linux'
if vim.loop.os_uname().sysname == 'Darwin' then
  jdk_17_path = home .. '/.asdf/installs/java/corretto-17.0.8.7.1'
  jdk_11_path = home .. '/.asdf/installs/java/corretto-11.0.20.8.1'
  jdk_8_path = home .. '/.asdf/installs/java/corretto-8.352.08.1'
  jdtls_home = '/opt/homebrew/Cellar/jdtls/1.25.0/libexec'
  jdtls_config = '/config_mac'
end
if vim.loop.os_uname().sysname == 'Windows_NT' then
  jdk_17_path = 'C:\\java\\corretto\\jdk17.0.8_7'
  jdk_11_path = 'C:\\java\\corretto\\jdk11.0.20_9'
  jdk_8_path = 'C:\\Program Files\\Amazon Corretto\\jdk1.8.0_372'
  jdtls_home = 'C:\\tools\\jdtls'
  jdtls_config = '/config_win'
end

-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- The on_attach function is used to set key maps after the language server
-- attaches to the current buffer
local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
  -- Regular Neovim LSP client keymappings
  vim.keymap.set('v', "<leader>ca", "<ESC><CMD>lua vim.lsp.buf.code_action()<CR>",
    { noremap=true, silent=true, buffer=bufnr, desc = "Code actions" })

  -- Java extensions provided by jdtls
  nmap('<leader>o', jdtls.organize_imports, 'Organize imports')
  nmap('<leader>ev', jdtls.extract_variable, 'Extract variable')
  nmap('<leader>ec', jdtls.extract_constant, 'Extract constant')
  vim.keymap.set('v', '<leader>em', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
    { noremap=true, silent=true, buffer=bufnr, desc = 'Extract method' })
  nmap('<leader>gt', require('jdtls.tests').generate, 'Generate Tests')
  nmap('<leader>gs', require('jdtls.tests').goto_subjects, 'Go to test or subject')
  nmap('<leader>rc', require('jdtls').test_class, 'Run test class')
  nmap('<leader>rm', require('jdtls').test_nearest_method, 'Run test method')
  nmap('<leader>fm', require('jdtls.dap').setup_dap_main_class_configs, 'Fetch main configs')


  -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
  -- you make during a debug session immediately.
  -- Remove the option if you do not want that.
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end

local bundles = {
  vim.fn.glob(home .. '/.local/share/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/vscode-java-test/server/*.jar", 1), "\n"))

local config = {
  flags = {
    debounce_text_changes = 80,
  },
  on_attach = on_attach,  -- We pass our on_attach keybindings to the configuration map
  init_options = {
    bundles = bundles
  },
  root_dir = root_dir, -- Set the root directory to our found root_marker
  -- Here you can configure eclipse.jdt.ls specific settings
  -- These are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      format = {
        enabled = true,
        settings = {
          -- Use Google Java style guidelines for formatting
          -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
          -- and place it in the ~/.local/share/eclipse directory
          url = "/.local/share/eclipse/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },  -- Use fernflower to decompile library code
      -- Specify any completion options
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*", "sun.*",
        },
      },
      -- Specify any options for organizing imports
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        },
      },
      -- How code generation should act
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      -- If you are developing in projects with different Java versions, you need
      -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
      -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      -- And search for `interface RuntimeOption`
      -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = jdk_17_path,
          },
          {
            name = "JavaSE-11",
            path = jdk_11_path,
          },
          {
            name = "JavaSE-1.8",
            path = jdk_8_path
          },
        }
      }
    }
  },
  -- cmd is the command that starts the language server. Whatever is placed
  -- here is what is passed to the command line to execute jdtls.
  -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  -- for the full list of options
  cmd = {
    jdk_17_path .. '/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    -- If you use lombok, download the lombok jar and place it in ~/.local/share/eclipse
    '-javaagent:' .. home .. '/.local/share/eclipse/lombok.jar',

    -- The jar file is located where jdtls was installed. This will need to be updated
    -- to the location where you installed jdtls
    '-jar', vim.fn.glob(jdtls_home .. '/plugins/org.eclipse.equinox.launcher_*.jar'),

    -- The configuration for jdtls is also placed where jdtls was installed. This will
    -- need to be updated depending on your environment
    '-configuration', jdtls_home .. jdtls_config,

    -- Use the workspace_folder defined above to store data for this project
    '-data', workspace_folder,
  },
}

-- Finally, start jdtls. This will run the language server using the configuration we specified,
-- setup the keymappings, and attach the LSP client to the current buffer
jdtls.start_or_attach(config)
