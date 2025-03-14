

--transform = entity:GetTransformComponent()
--transform.Position.x = 100
--t = transform.x
--t = 20
--entity:AddTransformComponent(transform)

function OnUpdate()
    if bIsKeyPressed(bKeyboard.SPACE) then
        local entity = bScene:CreateEntity()
        print(entity)
        entity:AddTagComponent("created in script entity")
        local pos = vec3(math.random(1,200), 0, math.random(1,200))
        entity:AddTransformComponent(Transform(pos, vec3(), vec3(1.0)))
        entity:AddModelComponent(bLoader:LoadModel("models/gribok/gribok.obj"))
        entity:AddShaderComponent(bLoader:LoadShader("./resources/shaders/only_diffuse"))

        -- local view = bScene:GetRuntimeView({"TransformComponent"})
        -- for idx, entity in pairs(view) do
            -- local transform = entity:GetTransformComponent()
            -- print(entity:GetTagComponent().Name)
            -- transform.Position.x = transform.Position.x + 0.1
        -- end
    end
end


