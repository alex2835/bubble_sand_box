-- Spawns a batch of lit, physics-driven cubes on space.

local SPAWN_COUNT = 100

local function spawn_cube()
    -- Everything not given here has the obvious default: identity rotation,
    -- unit scale, and no shader means the engine's default one.
    spawn{
        tag        = "created in script entity",
        pos        = vec3( math.random( 1, 10 ), 10, math.random( 1, 10 ) ),
        model      = "models/cube/cube.obj",
        shader     = "./resources/shaders/phong",
        state      = { health = 100 },
        -- A light table instead of building a Light and mutating it. distance
        -- is the radius at which the light fades to about 1% of full
        -- brightness, in world units. Small values are honoured now - the old
        -- lookup table clamped anything under 7 up to 7 without saying so.
        light      = { point = true, distance = 3, brightness = 2.0, color = vec3( 1.0, 0.85, 0.6 ) },
        rigid_body = { box = vec3( 0.5 ), mass = 1, friction = 2.0 },
    }
end

function on_update( entity, state, dt )
    -- WARNING: spawning from on_update is not safe in the engine as it stands.
    --
    -- Engine::OnUpdate calls scripts from inside ForEach<StateComponent,
    -- ScriptComponent>, and recs' ForEachTuple caches raw Pool pointers and
    -- walks live std::vector indices. Adding an entity here pushes into the
    -- very StateComponent pool being iterated, reallocating it underneath that
    -- walk. It happens to survive often enough to look fine.
    --
    -- Deferring the spawn by a frame does NOT help - the next frame's spawn is
    -- inside the next frame's iteration. The fix belongs in the engine: run
    -- scripts over a snapshot, or queue mutations and flush them at a frame
    -- boundary.
    if is_key_clicked( KeyboardKey.space ) and state.CreateCubes then
        for _ = 1, SPAWN_COUNT do
            spawn_cube()
        end
    end
end
