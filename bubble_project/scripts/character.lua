local moveSpeed = 500.0
local shiftSpeed = 1000.0

function OnUpdate(entity, state)
    local controller = entity:get_character_controller()

    local moveForward = 0
    local moveRight   = 0
    local speed = is_key_pressed(KeyboardKey.left_shift) and shiftSpeed or moveSpeed
    -- speed = controller:is_on_ground() and speed or speed * 0.1

    if is_key_pressed(KeyboardKey.w) then moveForward =  1 end
    if is_key_pressed(KeyboardKey.s) then moveForward = -1 end
    if is_key_pressed(KeyboardKey.a) then moveRight   = -1 end
    if is_key_pressed(KeyboardKey.d) then moveRight   =  1 end

    local walkDirection = vec3(0, 0, 0)

    if moveForward ~= 0 or moveRight ~= 0 then
        local camera  = state.CameraEntity:get_camera_component()

        -- Flatten camera vectors onto XZ plane and renormalize
        local fwd = camera.forward
        local right = camera.right
        fwd   = normalize(vec3(fwd.x,   0, fwd.z))
        right = normalize(vec3(right.x, 0, right.z))

        local dir = normalize(fwd * moveForward + right * moveRight)

        walkDirection = dir * speed * dt
    end


    controller:set_walk_direction(walkDirection)

    if is_key_clicked(KeyboardKey.space) then
        controller:jump(vec3(0, 10, 0))
    end

    color = vec4(1, 1, 1, 1)
    if not controller:is_on_ground(vec3(0, 10, 0)) then
        color = vec4(1, 0, 0, 1)
    end
    uniforms = entity:get_shader_component().uniforms
    uniforms.uColor = color

end
