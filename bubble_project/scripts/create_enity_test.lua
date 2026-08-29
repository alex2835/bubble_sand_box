

function create_entity_test()
    local entity = create_entity()
    -- print(entity)

    entity:add_tag_component("created in script entity")

    local pos = vec3(math.random(1,10), 0, math.random(1,10))
    local rot = vec3(0)
    local scale = vec3(1)
    local trans = Transform(pos, rot, scale)
    entity:add_transform_component(trans)
    entity:add_model_component(load_model("models/cube/cube.obj"))
    entity:add_shader_component(load_shader("shaders/phong/p1"))
    entity:add_state_component({health=100})

    -- light
    -- light = Light:create_point_light()
    -- light.distance = 20
    -- light.brightness = 1
    -- entity:add_light_component(light)

    -- physics
    local mass = 1
    local halpExtend = vec3(0.5)
    physicsObject = create_rigid_body_box(trans, mass, halpExtend)
    physicsObject:set_friction(1.0)
    entity:add_rigid_body_component(physicsObject)
end


function OnUpdate(entity, state)

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
