local moveSpeed = 500.0
local shiftSpeed = 1000.0

function OnUpdate(entity, state)
    local controller = entity:GetCharacterController()

    local moveForward = 0
    local moveRight   = 0
    local speed = IsKeyPressed(KeyboardKey.LEFT_SHIFT) and shiftSpeed or moveSpeed
    -- speed = controller:IsOnGround() and speed or speed * 0.1

    if IsKeyPressed(KeyboardKey.W) then moveForward =  1 end
    if IsKeyPressed(KeyboardKey.S) then moveForward = -1 end
    if IsKeyPressed(KeyboardKey.A) then moveRight   = -1 end
    if IsKeyPressed(KeyboardKey.D) then moveRight   =  1 end

    local walkDirection = vec3(0, 0, 0)

    if moveForward ~= 0 or moveRight ~= 0 then
        local camera  = state.CameraEntity:GetCameraComponent()

        -- Flatten camera vectors onto XZ plane and renormalize
        local fwd = camera.Forward
        local right = camera.Right
        fwd   = normalize(vec3(fwd.x,   0, fwd.z))
        right = normalize(vec3(right.x, 0, right.z))

        local dir = normalize(fwd * moveForward + right * moveRight)

        walkDirection = dir * speed * dt
    end

    
    controller:SetWalkDirection(walkDirection)

    if IsKeyClicked(KeyboardKey.SPACE) then
        controller:Jump(vec3(0, 10, 0))
    end

    color = vec4(1, 1, 1, 1)
    if not controller:IsOnGround(vec3(0, 10, 0)) then
        color = vec4(1, 0, 0, 1)
    end
    uniforms = entity:GetShaderComponent().Uniforms
    uniforms.uColor = color

end
