#pragma body

vec3 position_raw = (u_inverseModelViewTransform * vec4(_surface.position, 1.0)).xyz;
vec3 bbox_center = (u_boundingBox[0] + u_boundingBox[1]) * 0.5;
vec3 bbox_extent = (u_boundingBox[1] - u_boundingBox[0]) * 0.5;
vec3 position = (position_raw - bbox_center) / bbox_extent;

vec3 color = 0.5 + 0.5*cos(u_time + position.xyz + vec3(0,2,4));

_surface.diffuse = vec4(color, 1.0);
