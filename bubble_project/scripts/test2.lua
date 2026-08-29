

function OnUpdate(entity, state)
    if is_key_clicked(KeyboardKey.SPACE) then
        print(entity:get_tag_component().name)
        print(state)
    end
end
