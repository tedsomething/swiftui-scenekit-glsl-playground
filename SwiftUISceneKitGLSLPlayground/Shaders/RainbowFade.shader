vec3 palette(float t, vec3 a, vec3 b, vec3 c, vec3 d) {
    return a + b * cos(6.28318 * (c * t + d));
}

#pragma body

vec3 position_raw = (u_inverseModelViewTransform * vec4(_surface.position, 1.0)).xyz;
vec3 bbox_center = (u_boundingBox[0] + u_boundingBox[1]) * 0.5;
vec3 bbox_extent = (u_boundingBox[1] - u_boundingBox[0]) * 0.5;
vec3 position = (position_raw - bbox_center) / bbox_extent;

vec2 c1 = vec2(sin(u_time * 0.2) * 0.5, cos(u_time * 0.7));
vec2 c2 = vec2(sin(u_time * 0.2 * 0.7) * 0.9, cos(u_time * 0.65) * 0.6);

float d1 = length(position.xy - c1);
float d2 = length(position.xy - c2);

vec3 color1 = palette(d1 + u_time * 0.2, vec3(0.5, 0.5, 0.5), vec3(0.5, 0.5, 0.5), vec3(1.0, 1.0, 1.0), vec3(0.0, 0.33, 0.67));
vec3 color2 = palette(d2 + u_time * 0.2, vec3(0.5, 0.5, 0.5), vec3(0.5, 0.5, 0.5), vec3(1.0, 1.0, 1.0), vec3(0.0, 0.33, 0.67));

_surface.diffuse.rgb = (color1 + color2) / 2.0;
