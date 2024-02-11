function ShowFastTrackDialog()
    -- Create a unique name for the dialog
    local dialogName = "FastTrackInputDialog"

    -- Check if the dialog already exists
    if not StaticPopupDialogs[dialogName] then
        -- Define the dialog
        StaticPopupDialogs[dialogName] = {
            text = "Enter an achievement id",
            button1 = "Track",
            button2 = "Cancel",
            OnAccept = function(self)
                local inputText = self.editBox:GetText()
                local inputNumber = tonumber(inputText)

                if inputNumber then
                    C_ContentTracking.StartTracking(2, inputNumber)
                else
                    -- Display an error message
                    print("Invalid input. Please enter a valid integer")
                    ShowFastTrackDialog()
                end
            end,
            hasEditBox = true,
            maxLetters = 20,
            editBoxWidth = 100,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3
        }
    end

    -- Show the dialog
    StaticPopup_Show(dialogName)
end

local function Handle_SlashCmd(msg)
    local inputNumber = tonumber(msg)
    
    if inputNumber then
        C_ContentTracking.StartTracking(2, inputNumber)
    else
        ShowFastTrackDialog()
    end
end

-- Slash command handlers
SLASH_TRACK1 = "/track"
SlashCmdList["TRACK"] = function(msg)
    Handle_SlashCmd(msg)
end

SLASH_FT1 = "/ft"
SlashCmdList["FT"] = function(msg)
    Handle_SlashCmd(msg)
end