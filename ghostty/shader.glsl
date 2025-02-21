// Author: paperu
// Title: minimalist starfield
// https://www.shadertoy.com/view/wlKBWm

#define P 6.28318530717958

float b(in vec2 p, in float s, in float r) { return length(abs(p) - s) - r; }
mat2 rot(in float a){ return mat2(cos(a),sin(a),-sin(a),cos(a)); }
float asympt(float x, float sp) { return x/(sp + x); }

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord * (1.0 / iResolution.xy);
    vec3 backColor = texture(iChannel0, uv).rgb;

    vec2 st = (fragCoord.xy - .5*iResolution.xy)/iResolution.y;
    float t = iTime*.2;
    // vec2 m = ((iMouse.xy - iResolution.xy*.5)/iResolution.y) + vec2(cos(.5*t),sin(.5*t))*.5;
    vec2 m = vec2(1.0, 1.0);
    float sz = 8.*(1. - m.y*.5);
    float aa = sz/iResolution.y;
    float tB = clamp(asympt(iTime - 1., 3.),0.,1.);

    vec2 p = st + m*.5;
    p *= rot(P*.125 + m.y*P*.125);
    vec2 pF = floor(p*sz);
    p = fract(p*sz) - .5;
    p *= rot(pF.x*P*.333);
    p = abs(p) - .042;
    float d = b(p,.4*tB - (.5+.5*cos(length(pF)*10.5 - t))*.5,.05);
    d = smoothstep(-aa,aa,abs(d) - aa*.95);

    vec3 color = mix(vec3(0.23),vec3(1.),1.-d);
    fragColor = vec4(mix(backColor, color, 0.01), 0.1);
}
