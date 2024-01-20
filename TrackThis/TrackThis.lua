function ShowTrackThisDialog()
    -- Create a unique name for the dialog
    local dialogName = "TrackThisInputDialog"

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
                    ShowTrackThisDialog()
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

-- Slash command handler
SLASH_TRACK1 = "/track"
SlashCmdList["TRACK"] = function(msg)
    local inputNumber = tonumber(msg)
    
    if inputNumber then
        C_ContentTracking.StartTracking(2, inputNumber)
    else
        ShowTrackThisDialog()
    end
end