Notify = {}

Notify.Create = function(text, value)
    local msg   = text
    local value = tostring(value)

    if (msg == nil) then
        if (General.Debug) then
            print("Message not detected, reverting to empty string.")
        end

        msg = ""
    end

    if (value == nil) then
        if (General.Debug) then
            print("Empty value detected, reverting to empty string.")
        end

        value = ""
    end

    local formattedMessage = "" .. msg .. "" .. value


    -->> Add your notification export in here (Make sure to replace the description with formattedMessage)
end