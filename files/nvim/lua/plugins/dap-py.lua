return {
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
            local mason_registry = require 'mason-registry'
            mason_registry.refresh()
            local codelldb = mason_registry.get_package 'debugpy'
            local extension_path = codelldb:get_install_path()
            local path = extension_path .. 'debugpy/venv/bin/python'

            require('dap-python').setup(path)
        end,
    },
}
