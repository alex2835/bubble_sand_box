#include <common>
#include <phong>

// Per-entity uniforms.
//
// A shader declares its own uniforms in a struct named UserUniforms, bound at
// group 3. The engine reflects that struct out of the source - WebGPU exposes no
// reflection of its own - to build the inspector, to drive the Lua table, and to
// know the byte offset each value is written at.
//
// The default lives in a comment because WGSL, unlike GLSL, does not allow an
// initializer on a uniform. It is the value a fresh ShaderComponent starts at.
struct UserUniforms
{
    uColor: vec4<f32>,   // @default(1, 1, 1, 1)
};
@group(3) @binding(0) var<uniform> uUser: UserUniforms;


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
    let phongColor = PhongFragment( in );
    return phongColor * uUser.uColor;
}
