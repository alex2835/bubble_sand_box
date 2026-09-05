

function create_entity_test()
    -- Everything not given here has the obvious default: identity rotation,
    -- unit scale, and no shader means the engine's default one.
    spawn{
        tag        = "created in script entity",
        pos        = vec3( math.random( 1, 10 ), 10, math.random( 1, 10 ) ),
        model      = "models/cube/cube.obj",
        shader     = "shaders/phong/p1",
        state      = { health = 100 },
        rigid_body = { box = vec3( 0.5 ), mass = 1, friction = 2.0 },
    }

end

function on_update(entity, state, dt)

    if is_key_clicked(KeyboardKey.space) and state.CreateCubes then
        for i = 1,100 do
            create_entity_test()
        end
    end

    -- for_each_entity({Component.transform}, function(entity, components)
    --     local transform = components.transform
    --     transform.position.x = transform.position.x + 0.3 * dt
    -- end)

end
