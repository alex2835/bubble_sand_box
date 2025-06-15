

function OnUpdate(entity, state)
    local physics = entity:GetPhysicsComponent()

    if IsKeyClicked(KeyboardKey.SPACE) then
        physics:ApplyCentralImpulse(vec3(0, 1, -10))
    end
end