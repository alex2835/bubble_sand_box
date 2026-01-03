

function create_entity_test()
    local entity = CreateEntity()
    -- print(entity)

    entity:AddTagComponent("created in script entity")
            
    local pos = vec3(math.random(1,10), 0, math.random(1,10))
    local rot = vec3(0)
    local scale = vec3(1)
    local trans = Transform(pos, rot, scale)
    entity:AddTransformComponent( trans)
    entity:AddModelComponent(LoadModel("models/cube/cube.obj"))
    entity:AddShaderComponent(LoadShader("shaders/phong/p1"))
    entity:AddStateComponent({health=100})
            
    local he = vec3(0.5)
    entity:AddPhysicsComponent(CreatePhysicsBox(trans, he))
    
    local mass = 5
    local physics = entity:GetPhysicsComponent()
    physics:SetMass(mass)
    physics:SetFriction(1.0)
end


function OnUpdate(entity, state)
    
    if IsKeyClicked(KeyboardKey.SPACE) then
        for i = 1,100 do
            create_entity_test()
        end

        ForEachEntity({Component.Tag, Component.State}, function(entity, components)
            -- print( string.format("Entity: %s", entity))
            -- print( string.format("Tag: %s", components[Component.Tag]) )

            local state = components[Component.State]
            local health = state["IntVal"]
            -- print( string.format("State health: %d", health) )
            -- print()
        end)
    end



    -- local view = bScene:GetRuntimeView({"TransformComponent"})
    -- for idx, entity in pairs(view) do
    --     local transform = entity:GetTransformComponent()
    --     print(entity:GetTagComponent().Name)
    --     transform.Position.x = transform.Position.x + 0.1
    -- end

    --transform = entity:GetTransformComponent()
    --transform.Position.x = 100
    --t = transform.x
    --t = 20
    --entity:AddTransformComponent(transform)

end
