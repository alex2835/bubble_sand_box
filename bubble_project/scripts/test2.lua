

function on_update(entity, state, dt)
    if is_key_clicked(KeyboardKey.space) then
        print(entity:get_tag().name)
        print(state)
    end
end
