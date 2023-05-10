Notify = {}

Notify.Create = function(text, value)
    local msg   = text
    local value = value
    local message = "" .. msg .. "" .. value
    -->> Add your notification export in here
    print(message)
end