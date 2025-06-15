


function OnUpdate(entity, state)
    if IsKeyClicked(KeyboardKey.SPACE) then
        print(entity:GetTagComponent().Name)
        print(state)
    end
end
