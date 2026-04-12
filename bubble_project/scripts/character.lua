local moveSpeed = 20.0

function OnUpdate(entity, state)
    local controller = entity:GetCharacterControllerComponent()

    -- Calculate movement direction
    local moveX = 0
    local moveZ = 0

    if IsKeyPressed(KeyboardKey.W) then
        moveZ = -1
    end

    if IsKeyPressed(KeyboardKey.S) then
        moveZ = 1
    end

    if IsKeyPressed(KeyboardKey.A) then
        moveX = -1
    end

    if IsKeyPressed(KeyboardKey.D) then
        moveX = 1
    end

    -- Normalize diagonal movement
    local length = math.sqrt(moveX * moveX + moveZ * moveZ)
    if length > 0 then
        moveX = moveX / length
        moveZ = moveZ / length
    end

    -- Apply movement
    local walkDirection = vec3(moveX * moveSpeed * 0.016, 0, moveZ * moveSpeed * 0.016)
    controller:SetWalkDirection(walkDirection)

    -- Jump when on ground
    if IsKeyClicked(KeyboardKey.SPACE)  then
        controller:Jump(vec3(0,10,0))
    end
end