#pragma body

vec3 color1 = vec3(1.0, 0.0, 0.0); // Red
vec3 color2 = vec3(0.0, 0.0, 1.0); // Blue

float t = 0.5 * (sin(u_time) + 1.0);
vec3 color = mix(color1, color2, t);

_surface.diffuse = vec4(color, 1.0);
