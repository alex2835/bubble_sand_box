-- A platform that slides back and forth. Kinematic: scripted, not simulated,
-- so it is moved by writing its transform and Bullet carries whatever stands
-- on it.

local AMPLITUDE = 5.0   -- units either side of the origin
local HEIGHT    = 3.0

function on_update( entity, state, dt )
    -- In state, not a chunk local. Every entity using this script shares the
    -- one loaded chunk, so a local up here would be a single clock for all of
    -- them - and it would not survive a save, where state does.
    state.time = ( state.time or 0 ) + dt
    entity:get_rigid_body():set_transform( vec3( math.sin( state.time ) * AMPLITUDE, HEIGHT, 0 ),
                                           vec3( 0, 0, 0 ) )
end
