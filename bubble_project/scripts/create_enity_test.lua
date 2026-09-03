

function create_entity_test()
    -- Everything not given here has the obvious default: identity rotation,
    -- unit scale, and no shader means the engine's default one.
    spawn{
        tag        = "created in script entity",
        pos        = vec3( math.random( 1, 10 ), 0, math.random( 1, 10 ) ),
        model      = "models/cube/cube.obj",
        shader     = "shaders/phong/p1",
        state      = { health = 100 },
        rigid_body = { box = vec3( 0.5 ), mass = 1, friction = 1.0 },
    }
end


function on_update(entity, state, dt)

    if is_key_clicked(KeyboardKey.space) and state.CreateCubes then
        for i = 1,100 do
            create_entity_test()
        end

        -- error("error")

        -- for_each_entity({Component.tag, Component.state}, function(entity, components)
        --     -- print( string.format("Entity: %s", entity))
        --     -- print( string.format("Tag: %s", components[Component.tag]) )
        --     -- local state = components[Component.state]
        --     -- local health = state["IntVal"]
        --     -- print( string.format("State health: %d", health) )
        --     -- print()
        -- end)
    end



    -- local view = bScene:GetRuntimeView({"TransformComponent"})
    -- for idx, entity in pairs(view) do
    --     local transform = entity:get_transform_component()
    --     print(entity:get_tag_component().name)
    --     transform.position.x = transform.position.x + 0.1
    -- end

    --transform = entity:get_transform_component()
    --transform.position.x = 100
    --t = transform.x
    --t = 20
    --entity:add_transform_component(transform)

end
