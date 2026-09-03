local MIN_RADIUS  = 25.0
local MAX_RADIUS  = 80.0
local ZOOM_SPEED  = 15.0
local SENSITIVITY = 0.004   -- radians per pixel
local PI          = math.pi

function on_start(entity, state)
    set_active_camera(entity)

    -- Capture the mouse for orbiting. Centered first, otherwise the first frame
    -- reports the jump from wherever the pointer was sitting as camera movement
    -- and the view snaps on start.
    center_cursor()
    lock_cursor( true )
end

function on_update(entity, state, dt)
    -- Escape toggles the capture, so the editor stays clickable while the game
    -- is running. The engine releases the cursor on stop either way.
    if is_key_clicked(KeyboardKey.escape) then
        if get_cursor_mode() == CursorMode.locked then
            lock_cursor( false )
        else
            center_cursor()
            lock_cursor( true )
        end
    end

    local camera = entity:get_camera()
    local player  = state.CharacterEntity
    
    -- Keep orbit center locked to the player
    camera.center = player.position

    -- Orbit rotation follows the mouse, but only while it is captured. Released,
    -- the pointer is being used on the editor and its movement is not camera
    -- input.
    if get_cursor_mode() == CursorMode.locked then
        camera.yaw   = camera.yaw - mouse_offset_x() * SENSITIVITY
        -- Negate Y: window Y is flipped (positive = up), so mouse-up → camera up → look down
        camera.pitch = camera.pitch + mouse_offset_y() * SENSITIVITY
        camera.pitch = math.max( -PI / 2 + 0.05, math.min( PI / 2 - 0.05, camera.pitch ) )
    end

    -- Zoom: Q zooms in, E zooms out
    if is_key_pressed(KeyboardKey.q) then
        camera.radius = math.max( MIN_RADIUS, camera.radius - ZOOM_SPEED * dt )
    end
    if is_key_pressed(KeyboardKey.e) then
        camera.radius = math.min( MAX_RADIUS, camera.radius + ZOOM_SPEED * dt )
    end

    camera:update_orbit()
end
