return {
    'linrongbin16/lsp-progress.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lsp-progress').setup {
            spinner = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
            series_format = function(title, message, percentage)
                local builder = {}
                local has_title = false
                local has_message = false
                if title and title ~= '' then
                    table.insert(builder, title)
                    has_title = true
                end
                if message and message ~= '' then
                    table.insert(builder, message)
                    has_message = true
                end
                if percentage and (has_title or has_message) then
                    table.insert(builder, string.format('(%.0f%%%%)', percentage))
                end
                return table.concat(builder, ' ')
            end,
            client_format = function(_, spinner, series_messages)
                return #series_messages > 0 and (spinner .. ' ' .. table.concat(series_messages, ', ')) or nil
            end,
            format = function(client_messages)
                return #client_messages > 0 and (table.concat(client_messages, ' ')) or nil
            end,
        }
    end,
}
