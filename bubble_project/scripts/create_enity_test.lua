-- Spawns a batch of lit, physics-driven cubes on space.

local SPAWN_COUNT = 100
-- Numbers the cubes: cube_1, cube_2, ... Names differ from the start, so the
-- engine has no taken name to step past.
local spawned = 0

local function spawn_cube()
    spawned = spawned + 1
    -- Everything not given here has the obvious default: identity rotation,
    -- unit scale, and no shader means the engine's default one.
    local entity = spawn{
        tag        = string.format( "cube_%d", spawned ),
        pos        = vec3( math.random( 1, 10 ), 10, math.random( 1, 10 ) ),
        model      = "models/cube/cube.obj",
        shader     = "./resources/shaders/phong",
        state      = { health = 100 },
        -- light      = { point = true, distance = 5, brightness = 2.0, color = vec3( 1.0, 0.85, 0.6 ) },
        rigid_body = { shape = "box", half_extents = vec3( 0.5 ), mass = 1, friction = 2.0 },
    }
    -- print(entity)
end

function on_update( entity, state, dt )
    -- Spawning straight from on_update is supported. Engine::OnUpdate takes a
    -- snapshot of the scripted entities before it calls any of them and looks
    -- each one up again as it goes, so the pool reallocation these spawns cause
    -- cannot pull the ground out from under the iteration.
    --
    -- The new cubes are not in this frame's snapshot: they run on_start now and
    -- their first on_update next frame. Nothing here needs deferring.
    --
    -- The one place this does not hold is inside a for_each_entity callback,
    -- which still walks the pools live - queue there and apply after the loop.
    if is_key_clicked( keyboard_key.space ) and state.CreateCubes then
        for _ = 1, SPAWN_COUNT do
            spawn_cube()
        end
    end
end
