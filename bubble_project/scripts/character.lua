-- Arcade character movement.
-- Horizontal velocity is owned here and kept in `state`, because the controller's
-- get_linear_velocity() only echoes back what was last set. Bullet owns vertical.

-- Speeds in units/second
local WALK_SPEED   = 40.0
local SPRINT_SPEED = 50.0
local JUMP_SPEED   = 10.0

-- Sharpness, in seconds to reach the target. This is how response is actually
-- felt, and it keeps sprinting as snappy as walking instead of taking longer to
-- cover the larger speed gap. Lower is sharper.
local TIME_TO_SPEED     = 0.06   -- ground: stopped -> top speed
local TIME_TO_STOP      = 0.05   -- ground: top speed -> stopped
local TIME_TO_TURN      = 0.03   -- ground: shed sideways speed when redirecting
local AIR_TIME_TO_SPEED = 0.25   -- air steering, deliberately duller than ground
local AIR_TIME_TO_TURN  = 0.20
-- There is no air braking term: with no input in the air, momentum is kept.

-- Grace windows, in seconds
local COYOTE_TIME = 0.12   -- still jumpable just after walking off an edge
local JUMP_BUFFER = 0.12   -- a jump pressed just before landing still counts

-- Moves `current` toward `target` by at most rate*dt, without overshooting.
local function approach( current, target, rate, dt )
    local delta = target - current
    local maxStep = rate * dt
    -- normalize() is NaN on a zero vector, and NaN*0 stays NaN, so the zero case
    -- has to be taken before the step and not after it.
    if is_nearly_zero( delta ) or length( delta ) <= maxStep then
        return target
    end
    return current + normalize( delta ) * maxStep
end

function on_update( entity, state, dt )
    local controller = entity:get_character_controller()
    local grounded   = controller:is_on_ground()

    -- Input to a wish direction on the XZ plane, relative to the camera
    local moveForward, moveRight = 0, 0
    if is_key_pressed( KeyboardKey.w ) then moveForward =  1 end
    if is_key_pressed( KeyboardKey.s ) then moveForward = -1 end
    if is_key_pressed( KeyboardKey.a ) then moveRight   = -1 end
    if is_key_pressed( KeyboardKey.d ) then moveRight   =  1 end

    local wishDir = vec3( 0, 0, 0 )
    if moveForward ~= 0 or moveRight ~= 0 then
        local camera = state.CameraEntity:get_camera()
        local fwd    = normalize( vec3( camera.forward.x, 0, camera.forward.z ) )
        local right  = normalize( vec3( camera.right.x,   0, camera.right.z ) )
        wishDir = normalize( fwd * moveForward + right * moveRight )
    end

    local speed    = is_key_pressed( KeyboardKey.left_shift ) and SPRINT_SPEED or WALK_SPEED
    local velocity = state.velocity or vec3( 0, 0, 0 )

    if is_nearly_zero( wishDir ) then
        -- No input: brake hard on the ground, coast in the air.
        if grounded then
            velocity = approach( velocity, vec3( 0, 0, 0 ), speed / TIME_TO_STOP, dt )
        end
    else
        local timeToSpeed = grounded and TIME_TO_SPEED or AIR_TIME_TO_SPEED
        local timeToTurn  = grounded and TIME_TO_TURN  or AIR_TIME_TO_TURN

        -- Split the velocity into the part along the wish direction and the part
        -- across it, and give each its own rate. Shedding the sideways part on a
        -- faster clock is what makes redirecting feel sharp: forward speed is
        -- kept rather than spent bleeding off the old heading.
        local along  = project( velocity, wishDir )
        local across = velocity - along

        along  = approach( along,  wishDir * speed,   speed / timeToSpeed, dt )
        across = approach( across, vec3( 0, 0, 0 ),   speed / timeToTurn,  dt )
        velocity = along + across
    end

    state.velocity = velocity
    controller:set_walk_velocity( velocity )

    -- Jump timers. is_on_ground() is an exact-zero test that flickers on steps
    -- and slopes, so neither the ground state nor the keypress is trusted on the
    -- single frame it happens.
    local coyote = grounded and COYOTE_TIME or math.max( 0, ( state.coyote or 0 ) - dt )
    local buffer
    if is_key_clicked( KeyboardKey.space ) then
        buffer = JUMP_BUFFER
    else
        buffer = math.max( 0, ( state.jumpBuffer or 0 ) - dt )
    end

    if buffer > 0 and coyote > 0 then
        controller:jump( vec3( 0, JUMP_SPEED, 0 ) )
        -- Consume both, so one press cannot produce two jumps
        coyote = 0
        buffer = 0
    end

    state.coyote = coyote
    state.jumpBuffer = buffer

    -- Red while airborne
    local uniforms = entity:get_shader().uniforms
    uniforms.uColor = grounded and vec4( 1, 1, 1, 1 ) or vec4( 1, 0, 0, 1 )
end
