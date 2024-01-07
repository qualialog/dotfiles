return {
    {
        'mfussenegger/nvim-dap',
        keys = {
            { '<leader>dt', ':DapToggleBreakpoint<cr>', { silent = true } },
            { '<leader>do', ':DapStepOver<cr>', desc = 'Step Over' },
            { '<leader>dO', ':DapStepOut<cr>', desc = 'Step Out' },
            { '<leader>dc', ':DapContinue<cr>', { silent = true } },
            { '<leader>dx', ':DapTerminate<cr>', { silent = true } },
        },
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        opts = {},
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
        keys = {
            { '<leader>dut', ':lua require"dapui".toggle()<cr>', { silent = true } },
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

            require 'utils.dap-hl'()
        end,
    },
}
