-- The player's animated body: the "body" child of the player in
-- prefabs/player.prefab. Being a child, it follows the capsule on its own; its
-- local position puts the model's feet (its origin) at the bottom of the
-- capsule (whose origin is its centre).
--
-- Everything the animation needs is read off the parent: how fast it moves
-- picks idle / walk / run, whether it is on the ground picks the airborne
-- pose, and the body turns to face the way it moves.

local TURN_TIME = 0.12    -- seconds to face a new direction

function on_start( entity, state )
    state.yaw = 0
end

function on_update( entity, state, dt )
    local player = entity:get_parent()
    if not player then return end
    local controller = player:get_character_controller()

    -- Feet on the ground: the capsule's centre, less half its height.
    local halfHeight = controller:get_height() * 0.5 + controller:get_radius()
    entity.position = vec3( 0, -halfHeight, 0 )

    -- The speed character.lua decided on, in units per second. (The
    -- controller's get_linear_velocity() is not that: its horizontal part is
    -- Bullet's per substep walk direction.)
    local velocity = player:get_state().velocity or vec3( 0, 0, 0 )
    local planar = vec3( velocity.x, 0, velocity.z )

    -- Face the direction of travel. The model looks down +Z at yaw 0.
    if length( planar ) > 1 then
        local target = math.atan( planar.x, planar.z )
        local delta = ( target - state.yaw + math.pi ) % ( 2 * math.pi ) - math.pi
        state.yaw = state.yaw + delta * math.min( 1, dt / TURN_TIME )
    end
    entity:get_transform():set_rotation( 0, state.yaw, 0 )

    -- What animations/player.anim reads: its blend is laid out in these
    -- speeds (idle 0, walk 40, run 70).
    local animator = entity:get_animator()
    animator:set( "speed", length( planar ) )
    animator:set( "grounded", controller:is_on_ground() )
end
