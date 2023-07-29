function ToSnakeCase(value)
    local result = string.lower(vim.fn.substitute(value, [[\l\zs\u]], [[_\L\0]], 'g'))
    return result
end
