
local TIME = 0

function on_update(entity, state, dt)
    TIME = TIME + dt
    entity:get_rigid_body():set_transform( vec3( math.sin( TIME ) * 5, 3, 0 ), vec3( 0, 0, 0 ) )
end