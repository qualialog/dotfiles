local langs = {
    'typescript',
    'javascript',
    'typescriptreact',
    'javascriptreact',
    'vue',
}

return {
    {
        'microsoft/vscode-js-debug',
        build = 'npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out',
        version = '1.*',
    },
    {
        'mxsdev/nvim-dap-vscode-js',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
        keys = {
            {
                '<leader>da',
                function()
                    if vim.fn.filereadable '.vscode/launch.json' then
                        local dap_vscode = require 'dap.ext.vscode'
                        dap_vscode.load_launchjs(nil, {
                            ['pwa-node'] = langs,
                            ['chrome'] = langs,
                            ['pwa-chrome'] = langs,
                            ['node-terminal'] = langs,
                        })
                    end
                    require('dap').continue()
                end,
                desc = 'Run with Args',
            },
        },
        config = function()
            print 'HERE'
            local dap = require 'dap'

            local debugger_path = vim.fn.resolve(vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug')
            print(debugger_path)

            require('dap-vscode-js').setup {

                log_file_path = '(stdpath cache)/dap_vscode_js.log',
                log_file_level = false,
                log_console_level = vim.log.levels.ERROR,
                debugger_path = vim.fn.resolve(vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug'),
                adapters = {
                    'chrome',
                    'pwa-node',
                    'pwa-chrome',
                    'pwa-msedge',
                    'pwa-extensionHost',
                    'node-terminal',
                },
            }

            for _, language in ipairs(langs) do
                dap.configurations[language] = {
                    {
                        type = 'pwa-node',
                        request = 'launch',
                        name = 'Launch file',
                        program = '${file}',
                        cwd = vim.fn.getcwd(),
                        sourceMaps = true,
                    },
                    {
                        type = 'pwa-node',
                        request = 'attach',
                        name = 'Attach',
                        processId = require('dap.utils').pick_process,
                        cwd = vim.fn.getcwd(),
                        sourceMaps = true,
                    },
                    {
                        type = 'pwa-chrome',
                        request = 'launch',
                        name = 'Launch & Debug Chrome',
                        url = function()
                            local co = coroutine.running()
                            return coroutine.create(function()
                                vim.ui.input({
                                    prompt = 'Enter URL: ',
                                    default = 'http://localhost:3000',
                                }, function(url)
                                    if url == nil or url == '' then
                                        return
                                    else
                                        coroutine.resume(co, url)
                                    end
                                end)
                            end)
                        end,
                        webRoot = vim.fn.getcwd(),
                        protocol = 'inspector',
                        sourceMaps = true,
                        userDataDir = false,
                    },
                    {
                        name = 'nextjs',
                        type = 'node-terminal',
                        request = 'launch',
                        command = "NODE_OPTIONS='--inspect' npm run dev",
                        serverReadyAction = {
                            pattern = '- Local:.+(https?://.+)',
                            uriFormat = '%s',
                            action = 'debugWithChrome',
                        },
                    },
                    {
                        name = '----- ↓ launch.json configs ↓ -----',
                        type = '',
                        request = 'launch',
                    },
                }
            end
        end,
    },
    {
        'Joakker/lua-json5',
        build = './install.sh',
    },
}
