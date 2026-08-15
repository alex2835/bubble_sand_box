
local MIN_RADIUS  = 5.0
local MAX_RADIUS  = 80.0
local ZOOM_SPEED  = 15.0
local SENSITIVITY = 0.004   -- radians per pixel
local PI          = math.pi
local initialized = false

function OnUpdate(entity, state)
    if not initialized then
        SetActiveCamera(entity)
        initialized = true
    end

    local camera = entity:GetCameraComponent()
    local player  = state.CharacterEntity

    -- Keep orbit center locked to the player
    camera.Center = player:GetTransformComponent().Position

    -- Orbit rotation: hold right mouse button + drag mouse
    -- if IsKeyPressed(MouseKey.RIGHT) then
        camera.Yaw   = camera.Yaw - MouseOffsetX() * SENSITIVITY
        -- Negate Y: window Y is flipped (positive = up), so mouse-up → camera up → look down
        camera.Pitch = camera.Pitch + MouseOffsetY() * SENSITIVITY
        camera.Pitch = math.max( -PI / 2 + 0.05, math.min( PI / 2 - 0.05, camera.Pitch ) )
    -- end

    -- Zoom: Q zooms in, E zooms out
    if IsKeyPressed(KeyboardKey.Q) then
        camera.Radius = math.max( MIN_RADIUS, camera.Radius - ZOOM_SPEED * dt )
    end
    if IsKeyPressed(KeyboardKey.E) then
        camera.Radius = math.min( MAX_RADIUS, camera.Radius + ZOOM_SPEED * dt )
    end

    camera:UpdateOrbit()
end
