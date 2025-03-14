


function OnUpdate()
    local view = bScene:GetRuntimeView({"TransformComponent"})
    for idx, entity in pairs(view) do
        if bIsKeyPressed(bKeyboard.W) then
            local transform = entity:GetTransformComponent()
            transform.Position.x = transform.Position.x + 0.1
        end

        if bIsKeyPressed(bKeyboard.S) then
            local transform = entity:GetTransformComponent()
            transform.Position.x = transform.Position.x - 0.1
        end

        if bIsKeyPressed(bKeyboard.A) then
            local transform = entity:GetTransformComponent()
            transform.Position.z = transform.Position.z - 0.1
        end

        if bIsKeyPressed(bKeyboard.D) then
            local transform = entity:GetTransformComponent()
            transform.Position.z = transform.Position.z + 0.1
        end

    end
end
