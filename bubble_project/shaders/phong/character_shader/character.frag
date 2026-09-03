#version 330 core

#include <phong>

// Per-entity color override, set from Lua:
//     entity.uniforms.uColor = vec4(1, 0, 0, 1)
// The initializer is the value a fresh ShaderComponent starts at.
uniform vec4 uColor = vec4(1.0);

out vec4 FragColor;

void main()
{
    FragColor = PhongFragment(uColor);
}
