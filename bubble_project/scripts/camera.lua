
local MIN_RADIUS  = 5.0
local MAX_RADIUS  = 80.0
local ZOOM_SPEED  = 15.0
local SENSITIVITY = 0.004   -- radians per pixel
local PI          = math.pi
local initialized = false

function OnUpdate(entity, state)
    if not initialized then
        set_active_camera(entity)
        initialized = true
    end

    local camera = entity:get_camera_component()
    local player  = state.CharacterEntity

    -- Keep orbit center locked to the player
    camera.center = player:get_transform_component().position

    -- Orbit rotation: hold right mouse button + drag mouse
    -- if is_key_pressed(MouseKey.RIGHT) then
        camera.yaw   = camera.yaw - mouse_offset_x() * SENSITIVITY
        -- Negate Y: window Y is flipped (positive = up), so mouse-up → camera up → look down
        camera.pitch = camera.pitch + mouse_offset_y() * SENSITIVITY
        camera.pitch = math.max( -PI / 2 + 0.05, math.min( PI / 2 - 0.05, camera.pitch ) )
    -- end

    -- Zoom: Q zooms in, E zooms out
    if is_key_pressed(KeyboardKey.q) then
        camera.radius = math.max( MIN_RADIUS, camera.radius - ZOOM_SPEED * dt )
    end
    if is_key_pressed(KeyboardKey.e) then
        camera.radius = math.min( MAX_RADIUS, camera.radius + ZOOM_SPEED * dt )
    end

    camera:update_orbit()
end
