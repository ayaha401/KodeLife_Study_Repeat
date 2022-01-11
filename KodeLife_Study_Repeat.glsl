#version 150

uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;
uniform vec3 spectrum;

uniform sampler2D texture0;
uniform sampler2D texture1;
uniform sampler2D texture2;
uniform sampler2D texture3;
uniform sampler2D prevFrame;
uniform sampler2D prevPass;

in VertexData
{
    vec4 v_position;
    vec3 v_normal;
    vec2 v_texcoord;
} inData;

out vec4 fragColor;

float Sphere(vec2 p, float r)
{
    return length(p) - r;
}

vec2 FractRepeat(vec2 uv, float span)
{
    vec2 p = uv;
    p *= span;
    p = fract(p) - .5;
    return p;
}

vec2 ModRepeat(vec2 uv, float span)
{
    return abs(mod(uv, span)) - span * .5;
}

void main(void)
{
    vec2 uv = (2. * gl_FragCoord.xy - resolution) / min(resolution.x, resolution.y);
    uv = FractRepeat(uv, 5.);
    //uv = ModRepeat(uv, 3);
    vec3 col = vec3(0.);
    
    col = vec3(step(Sphere(uv, 0.2), .01));
    
    if(uv.x > .48 || uv.y > .48)
    {
        col = vec3(1., 0., 0.);
    }
    
    fragColor = vec4(col, 1.0);
}