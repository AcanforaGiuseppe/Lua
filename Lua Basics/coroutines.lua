print("ciao")

function tick()
    if button_pressed == "fwd" then
        -- wait 0.1
        if button_pressed == "down" then
            -- wait 0.2
            if button_pressed == "fwd" then
                -- wait 0.3
                if button_pressed == "punch" then
                    fatality()
                end
            end
        end
    end
end

coroutine_tick = coroutine.create(function()
    if button_pressed == "fwd" then
        -- wait 0.1
        coroutine.yield()
        if button_pressed == "down" then
        -- wait 0.2
        coroutine.yield()
            if button_pressed == "fwd" then
                -- wait 0.3
                coroutine.yield()
                if button_pressed == "punch" then
                    fatality()
                end
            end
        end
    end
end)