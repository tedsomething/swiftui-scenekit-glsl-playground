#pragma body

vec3 color1 = vec3(1.0, 0.0, 0.0); // Red
vec3 color2 = vec3(0.0, 0.0, 1.0); // Blue

vec3 position_raw = (u_inverseModelViewTransform * vec4(_surface.position, 1.0)).xyz;
vec3 bbox_center = (u_boundingBox[0] + u_boundingBox[1]) * 0.5;
vec3 bbox_extent = (u_boundingBox[1] - u_boundingBox[0]) * 0.5;
vec3 position = (position_raw - bbox_center) / bbox_extent;

vec3 color = mix(color1, color2, (position.y / 2.0) + 0.5);

_surface.diffuse = vec4(color, 1.0);
