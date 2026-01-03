

function OnUpdate(entity, state)
    local physics = entity:GetPhysicsComponent()

    if IsKeyPressed(KeyboardKey.W) then
        physics:ApplyTorqueImpulse(vec3(0.01, 0, 0))
    end

    if IsKeyPressed(KeyboardKey.S) then
        physics:ApplyTorqueImpulse(vec3(-0.01, 0, 0))
    end

    if IsKeyPressed(KeyboardKey.D) then
        physics:ApplyTorqueImpulse(vec3(0, 0, 0.01))
    end

    if IsKeyPressed(KeyboardKey.A) then
        physics:ApplyTorqueImpulse(vec3(0, 0, -0.01))
    end


    -- if IsKeyClicked(KeyboardKey.SPACE) then
    --     physics:ApplyCentralImpulse(vec3(0, 10, 0))
    -- end

end