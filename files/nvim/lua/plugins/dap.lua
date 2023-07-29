return {
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
        keys = {
            { '<leader>db', '<cmd> DapToggleBreakpoint<CR>' },
        },
        config = function()
            local dap = require 'dap'
            local dapui = require 'dapui'

            dapui.setup()
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end

            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end

            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end
        end,
    },
    {
        'mfussenegger/nvim-dap',
    },
    {
        'mfussenegger/nvim-dap-python',
        ft = 'python',
        dependencies = {
            'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui',
        },
        keys = {
            {
                '<leader>dpr',
                function()
                    require('dap-python').test_method()
                end,
            },
        },
        config = function()
            local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'

            require('dap-python').setup(path)
        end,
    },
}
