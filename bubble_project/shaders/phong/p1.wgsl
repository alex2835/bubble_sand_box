#include <common>
#include <phong>

// One file per shader now, holding both entry points. WGSL puts every stage in
// one module, so the old arrangement - a .frag on its own, inheriting the
// engine's phong.vert - has nothing to inherit from. PhongVertex in <phong> is
// that default vertex stage, called explicitly.

struct VertexInput
{
    @location(0) aPosition: vec3<f32>,
    @location(1) aNormal: vec3<f32>,
    @location(2) aTexCoords: vec2<f32>,
    @location(3) aTangent: vec3<f32>,
    @location(4) aBitangent: vec3<f32>,
};

@vertex
fn vs_main( in: VertexInput ) -> VertexOutput
{
    return PhongVertex( in.aPosition, in.aNormal, in.aTexCoords, in.aTangent, in.aBitangent );
}

@fragment
fn fs_main( in: VertexOutput ) -> @location(0) vec4<f32>
{
    return PhongFragment( in );
}
